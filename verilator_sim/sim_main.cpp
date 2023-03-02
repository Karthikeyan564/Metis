// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

// For std::unique_ptr
#include <memory>
#include <bits/stdc++.h>

// Include common routines
#include <verilated.h>
#include "verilated_fst_c.h"
#include "verilated_vpi.h"


#include "tbench.h"

#define EPOCHS                      10
#define PATH_TO_INIT_INP_WEIGHTS "/home/karthikeyan/final_push/ReckOn/src/data/init_rand_weights_inp_cueAcc.dat"
#define PATH_TO_INIT_REC_WEIGHTS "/home/karthikeyan/final_push/ReckOn/src/data/init_rand_weights_rec_cueAcc.dat"
#define PATH_TO_INIT_OUT_WEIGHTS "/home/karthikeyan/final_push/ReckOn/src/data/init_rand_weights_out_cueAcc.dat"
#define PATH_TO_TRAIN_SET        "/home/karthikeyan/final_push/ReckOn/src/data/dataset_cueAcc_train.dat"
#define PATH_TO_TEST_SET         "/home/karthikeyan/final_push/ReckOn/src/data/dataset_cueAcc_test.dat"

// Include model header, generated from Verilating "top.v"
#include "Vmetis.h"

//For IO routine
#include <iostream>

template<class module> class testbench {
    VerilatedFstC* trace = new VerilatedFstC;
    unsigned long tick_counter;
    bool getDataNextCycle;

    public:
        const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
        const std::unique_ptr<Vmetis> core{new Vmetis{contextp.get(), "METIS"}};
        bool loaded = false;

        testbench() {
            // Verilated::traceEverOn(true);
            // Verilated::mkdir("logs");
            // contextp->traceEverOn(true);
            // core->trace(trace, 99);
            // trace->open("logs/dump.fst");

            tick_counter = 0l;

            core->CLK_EXT      = 0;
            core->SCK          = 0;
            core->MOSI         = 0;
            core->AERIN_ADDR   = 0;
            core->AERIN_REQ    = 0;
            core->AERIN_TAR_EN = 0;
            core->TARGET_VALID = 0;
            core->INFER_ACC    = 0;
            core->SAMPLE       = 0;
            core->TIME_TICK    = 0;
            core->OUT_ACK      = 0;

            core->RST          = 0;
            this->wait(5);
            core->RST          = 1;
            this->wait(5);
            core->RST          = 0;
            this->wait(5);
        }

        ~testbench(void) {
            core->final();
            // trace->close();
            // trace = NULL;
        }

        virtual void tick(void) {

            contextp->timeInc(1); 
            core->CLK_EXT = !core->CLK_EXT;
            core->eval();
            VerilatedVpi::callValueCbs();
            tick_counter++;
            // trace->dump(contextp->time());
            // trace->flush();
        }

        virtual bool done(void) {
            return (Verilated::gotFinish());
        }

        virtual void spi_send(std::bitset<32> addr, std::bitset<32> data) {
            for (int i = 0; i < 32; i++) {
                core->MOSI = (int)addr[31-i];
                wait(5);
                core->SCK  = true;
                wait(5);
                core->SCK  = false;
            }
            for (int i = 0; i < 32; i++) {
                core->MOSI = data[31-i];
                wait(5);
                core->SCK  = true;
                wait(5);
                core->SCK  = false;
            }
        }
        virtual void spi_half_w(std::bitset<32> data){
            for (int i=0; i<32; i=i+1){
            core->MOSI = data[31-i];
            wait(5);
            core->SCK  = 1;
            wait(5);
            core->SCK  = 0;
            }
        }
        virtual void aer_send(std::bitset<8> addr_in){
            // std::cout<<"Waiting [AER start]\n\n";
            while (core->AERIN_ACK==1) wait(1);
            core->AERIN_ADDR = addr_in.to_ulong();
            core->AERIN_REQ = 1;
            while (core->AERIN_ACK==0) wait(1);
            core->AERIN_REQ = 0;
            // std::cout<<"Waiting [AER end]\n\n";
        }
        void wait(int time){
            for (int i = 0; i < time; i++) {
                this->tick();
            }
        }
};

// Legacy function required only so linking works on Cygwin and MSVC++
double sc_time_stamp() { return 0; }




int main(int argc, char** argv) {
    // This is a more complicated example, please also see the simpler examples/make_hello_c.

    // Prevent unused variable warnings
    if (false && argc && argv) {}


    Verilated::commandArgs(argc, argv);
    auto *core = new testbench<Vmetis>;

    int weight,status;
    int correct;
    int len;
    int curr_tick;
    uint32_t prog_val32;
    int evt_neur,evt_time, evt_target;
    bool prev_TIMING_ERROR_RDY;
    int test;
    int inference;

    std::cout<<"----- Programming SNN parameters...\n\n";
    core->spi_send(0x00010000,0x1);
    core->spi_send(0x00010001,SPI_RO_STAGE_SEL);
    core->spi_send(0x00010002,SPI_GET_CLKINT_OUT);
    core->spi_send(0x00010008,SPI_RST_MODE);
    core->spi_send(0x00010009,SPI_DO_EPROP);
    core->spi_send(0x0001000A,SPI_LOCAL_TICK);
    core->spi_send(0x0001000B,SPI_ERROR_HALT);
    core->spi_send(0x0001000C,SPI_FP_LOC_WINP);
    core->spi_send(0x0001000D,SPI_FP_LOC_WREC);
    core->spi_send(0x0001000E,SPI_FP_LOC_WOUT);
    core->spi_send(0x0001000F,SPI_FP_LOC_TINP);
    core->spi_send(0x00010010,SPI_FP_LOC_TREC);
    core->spi_send(0x00010011,SPI_FP_LOC_TOUT);
    core->spi_send(0x00010012,SPI_LEARN_SIG_SCALE);
    core->spi_send(0x00010013,SPI_REGUL_MODE);
    core->spi_send(0x00010014,SPI_REGUL_W);
    core->spi_send(0x00010015,SPI_EN_STOCH_ROUND);
    core->spi_send(0x00010016,SPI_SRAM_SPEEDMODE);
    core->spi_send(0x00010017,SPI_TIMING_MODE);
    core->spi_send(0x00010019,SPI_REGRESSION);
    core->spi_send(0x0001001A,SPI_SINGLE_LABEL);
    core->spi_send(0x0001001B,SPI_NO_OUT_ACT);
    core->spi_send(0x0001001E,SPI_SEND_PER_TIMESTEP);
    core->spi_send(0x0001001F,SPI_SEND_LABEL_ONLY);
    core->spi_send(0x00010020,SPI_NOISE_EN);
    core->spi_send(0x00010021,SPI_FORCE_TRACES);
    core->spi_send(0x00010040,SPI_CYCLES_PER_TICK);
    for (int i=0; i<4; i=i+1)
        core->spi_send(0x00010041+i,SPI_ALPHA_CONF>>(32*i));
    core->spi_send(0x00010045,SPI_KAPPA);
    core->spi_send(0x00010046,SPI_THR_H_0);
    core->spi_send(0x00010047,SPI_THR_H_1);
    core->spi_send(0x00010048,SPI_THR_H_2);
    core->spi_send(0x00010049,SPI_THR_H_3);
    core->spi_send(0x0001004A,SPI_H_0);
    core->spi_send(0x0001004B,SPI_H_1);
    core->spi_send(0x0001004C,SPI_H_2);
    core->spi_send(0x0001004D,SPI_H_3);
    core->spi_send(0x0001004E,SPI_H_4);
    core->spi_send(0x0001004F,SPI_LR_R_WINP);
    core->spi_send(0x00010050,SPI_LR_P_WINP);
    core->spi_send(0x00010051,SPI_LR_R_WREC);
    core->spi_send(0x00010052,SPI_LR_P_WREC);
    core->spi_send(0x00010053,SPI_LR_R_WOUT);
    core->spi_send(0x00010054,SPI_LR_P_WOUT);
    core->spi_send(0x00010055,SPI_SEED_INP);
    core->spi_send(0x00010056,SPI_SEED_REC);
    core->spi_send(0x00010057,SPI_SEED_OUT);
    core->spi_send(0x00010058,SPI_SEED_STRND_NEUR);
    core->spi_send(0x00010059,SPI_SEED_STRND_ONEUR);
    core->spi_send(0x0001005A,SPI_SEED_STRND_TINP);
    core->spi_send(0x0001005B,SPI_SEED_STRND_TREC);
    core->spi_send(0x0001005C,SPI_SEED_STRND_TOUT);
    core->spi_send(0x0001005D,SPI_SEED_NOISE_NEUR);
    core->spi_send(0x0001005E,SPI_NUM_INP_NEUR);
    core->spi_send(0x0001005F,SPI_NUM_REC_NEUR);
    core->spi_send(0x00010060,SPI_NUM_OUT_NEUR);
    core->spi_send(0x00010062,SPI_REGUL_F0);
    core->spi_send(0x00010063,SPI_REGUL_K_INP_R);
    core->spi_send(0x00010064,SPI_REGUL_K_INP_P);
    core->spi_send(0x00010065,SPI_REGUL_K_REC_R);
    core->spi_send(0x00010066,SPI_REGUL_K_REC_P);
    core->spi_send(0x00010067,SPI_REGUL_K_MUL);
    core->spi_send(0x00010068,SPI_NOISE_STR);
    core->spi_send(0x00010000,0);



// std::cout<<"----- Starting verification of programmed SNN parameters";
//    // std::cout<<core->spi_read(0x00010000);
//     core->spi_read();



    core->wait(100);
    core->spi_send(0x00010000,1);
    std::cout<<"----- Starting delayed-supervision navigation benchmarking (e-prop enabled on random weights)...\n\n";
    std::cout<<"      Initializing input weights (with SPI)...\n\n";
    FILE* fd;

    fd = fopen(PATH_TO_INIT_INP_WEIGHTS,"r");
    for (int i=0; i<40; i=i+1){
        core->spi_half_w(0x30190000+i<<6);
        for (int j=0; j<25; j=j+1){
            prog_val32 = 0;
            for (int k=0; k<4; k=k+1){
                status = fscanf(fd,"%d",&weight);
                assert(status == 1 && "A problem occured while processing input weights file.");
                prog_val32 = prog_val32 | (0x00000000+(weight&0xFF)) << (8*k);
            }
            core->spi_half_w(prog_val32);

        }
    }
    fclose(fd);

    std::cout<<"      Initializing recurrent weights (with SPI)...\n\n";
    fd = fopen(PATH_TO_INIT_REC_WEIGHTS,"r");
    for (int i=0; i<100; i=i+1){
        core->spi_half_w(0x40190000+i<<6);
        for (int j=0; j<25; j=j+1){
            prog_val32 = 0;
            for (int k=0; k<4; k=k+1){
                status = fscanf(fd,"%d",&weight);
                assert(status == 1 && "A problem occured while processing recurrent weights file.");
                prog_val32 = prog_val32 | (0x00000000+(weight&0xFF)) << (8*k);
            }
            core->spi_half_w(prog_val32);
        }
    }
    fclose(fd);

    std::cout<<"      Initializing output weights (with SPI)...\n\n";
    fd = fopen(PATH_TO_INIT_OUT_WEIGHTS,"r");
    for (int i=0; i<100; i=i+1){
            prog_val32 = 0;
            for (int k=0; k<2; k=k+1){
                status = fscanf(fd,"%d",&weight);
                assert(status == 1 && "A problem occured while processing output weights file.");
                prog_val32 = prog_val32 | (0x00000000+(weight&0xFF)) << (8*k);
            }
        core->spi_send(0x50010000+i<<2,prog_val32);
    }
    fclose(fd);
    core->wait(100);
    std::cout<<"      Initializing neurons (with SPI)...\n\n";
    std::string prog_val128_str = "11111110111100000010011001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    core->spi_half_w(0x11900000);
    for (int i=0; i<100; i=i+1){
        for (int j=0; j<4; j=j+1){
            prog_val32 = std::bitset<32>(prog_val128_str.substr(j*32,32)).to_ulong();
            core->spi_half_w(prog_val32);
        }
    }
    core->wait(100);
    
    printf("      Start training for %d epochs...\n\n", EPOCHS);
     for (int e=0; e<EPOCHS; e++){
        printf("      --- Epoch %d:\n\n", e+1);
        for (test=0; test<=1; test++) {
            correct = 0;
            core->spi_send(0x00010000,1);
            if(test){
                core->spi_send(0x000010009,0);
                fd = fopen(PATH_TO_TEST_SET,"r");
            }
            else {
                core->spi_send(0x000010009,0x7);
                fd = fopen(PATH_TO_TRAIN_SET,"r");
            }
            status = fscanf(fd,"%d",&len);
            assert (status == 1 && "A problem occured while reading the header of the delayed-supervision navigation dataset.");
            core->wait(100);
            for (int curr_sample=0; curr_sample<len; curr_sample=curr_sample+1){
                curr_tick = 0;
                core->core->SAMPLE = 1;
                core->wait(10);
                while(true) {
                    status = fscanf(fd, "%d, %d", &evt_neur, &evt_time);
                    // std::cout<<"Waiting [Read] "<<evt_neur<<" "<<evt_time<<"\n\n"<<std::flush; 
                    assert(status == 2 && "A problem occured while reading an event from the dataset.");
                    if (evt_neur == -2) {           // Target start mark
                        evt_target = evt_time;
                        while (curr_tick < 2100){
                            core->core->TIME_TICK = 1;
                            core->wait(10);
                            core->core->TIME_TICK = 0;
                            curr_tick = curr_tick + 1;
                            do {
                               // std::cout<<"Waiting [346]\n\n";
                                prev_TIMING_ERROR_RDY=core->core->TIMING_ERROR_RDY;
                                core->tick();
                            } while(!(prev_TIMING_ERROR_RDY==0 && core->core->TIMING_ERROR_RDY==1));
                            core->wait(10);
                        }
                        if (!test) {
                            core->core->AERIN_TAR_EN = 1;
                            core->aer_send(evt_target&0xFF);
                            core->wait(20);
                            core->core->AERIN_TAR_EN = 0;
                            core->wait(10);
                            core->core->TARGET_VALID = 1;
                        }
                        core->core->INFER_ACC    = 1;
                        core->wait(100);
                        status = fscanf(fd, "%d, %d", &evt_neur, &evt_time); 
                        assert(status == 2 && "A problem occured while reading an event post-target from the dataset.");
                    }
                    while (curr_tick < evt_time) {
                            if (curr_tick == 2249) {
                                core->core->SAMPLE = 0;
                                core->wait(10);
                            }
                            core->core->TIME_TICK = 1;
                            core->wait(10);
                            core->core->TIME_TICK = 0;

                            if (curr_tick == 2249) break;
                            curr_tick = curr_tick + 1;
                            do {
                                //std::cout<<"Waiting [377]\n\n";
                                prev_TIMING_ERROR_RDY=core->core->TIMING_ERROR_RDY;
                                core->tick();
                                //std::cout<<"Waiting [382] "<<prev_TIMING_ERROR_RDY<<" "<<(bool)core->core->TIMING_ERROR_RDY<<"\n\n"<<std::flush;
                            } while(!(prev_TIMING_ERROR_RDY==0 && core->core->TIMING_ERROR_RDY==1));
                            core->wait(10);
                    }
                    if (evt_neur == -1) break;
                    core->aer_send(evt_neur&0xFF);
                    core->wait(10);
                }
                // std::cout<<"Waiting [387]\n\n";
                while (core->core->OUT_REQ==0) core->wait(10);
                std::cout<<"Waiting [393] "<<(int)core->core->OUT_DATA<<"\n\n"<<std::flush;
                // std::cout<<"Waiting [389]\n\n";
                inference = int(core->core->OUT_DATA) & 0xF;
                if (inference == evt_target & 0xF)
                    correct = correct + 1;
                printf("            Sample %2d: inference is %2d, label is %2d\n\n", curr_sample, inference, evt_target); 
                core->core->OUT_ACK = 1;
                while (core->core->OUT_REQ==1) core->wait(10);
                core->core->OUT_ACK = 0;
                core->wait(100);
                core->core->TARGET_VALID = 0;
                core->core->INFER_ACC    = 0;
                core->wait(100);
            }
            fclose(fd);
            if (test)
                printf("          Score on test set is %0d/%0d (%d percents)!\n\n", correct, len, 100*correct/len);
            else
                printf("          Score while training is %0d/%0d (%d percents)!\n\n", correct, len, 100*correct/len);
        }
     }

     std::cout<<"----- Ending delayed-supervision navigation benchmarking.";
     core->wait(1000);

    return 0;
}
