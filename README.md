# Metis V2
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

**Tl;Dr:** A Neuromorphic IC with LIF neurons fabricated in efabless MPW-8 shuttle using OpenLane and Skywater 130nm PDK
### To implement: 

Refer to [README](docs/source/index.rst#section-quickstart) for a quickstart of how to use caravel_user_project

Refer to [README](docs/source/index.rst) for this sample project documentation. 

## Abstract
A programmable 256-neuron, 2048-synapse neuromorphic chip in 130nm CMOS is developed to accelerate inference and learning for various types of recurrent spiking neural networks(RSNNs). The chip features an analog circuit for leaky integrate-and-fire neuron and on-chip e-prop learning. The on-chip e-prop trains a spiking neural network to achieve an accuracy of 98.96\% in MNIST dataset with power efficiency of 4.78pJ/SOP at 1.8V. It is also able to learn intelligent behaviour from rewards as shown in the Atari video games.<br/>
**Keywords:** Spiking Neural Networks (SNNs), neuromorphic computing, Linear Integrate-and-fire Neurons

## Introduction
Spiking Neural Networks (SNNs) are a type of neural network that models the behavior of biological neurons. They use spikes (events that occur at specific times) to represent information instead of continuous activations as used in traditional neural networks. Neuromorphic hardware refers to hardware that implements the functioning of biological neurons and synapses to perform computations [1,2]. These devices can efficiently implement SNNs and achieve energy-efficient computing, making them suitable for real-time edge computing tasks.


## Leaky Integrate-and-fire neuron
The equation for the Leaky Integrate-and-fire neuron is:
\begin{equation}
\tau_{m} \frac{dV}{dt} = V_{rest}-V(t) + RI(t)
\end{equation}
The $\tau_{m}$ represents the membrane time constant of the neuron. $V(t)$ is the charge on the capacitor . $V_{rest}$ denotes the resting voltage of the neuron. $R$ is the leaky resistance in parallel to the capacitor. $I(t)$ is the input current. The work uses a Leaky Integrate-and-Fire(LIF) analog neuron (see figure 1) to reduce the energy consumption that comes with digital neuron implementations. The circuit consists of a Schmitt trigger, a capacitor, 3 current-steering Digital-to-Analog converters (DACs), and a set of transistors. The current input charges the capacitor which is directly attached to the Schmitt trigger. As soon as the Schmitt trigger reaches its upper threshold it turns on the discharging transistors. The capacitor then discharges until the voltage reaches the lower threshold of the Schmitt trigger. This process repeats until the input is cut off. The DACs 1 and 2 connected to the Schmitt trigger are for controlling the lower and upper threshold of the Schmitt trigger. The DAC 3 connected to the capacitor controls the amount of leaky behavior of the LIF neuron. Thus, the analog circuit is able to achieve the best possible energy efficiency while being completely adjustable and avoiding the digital overhead.

![Integrate-and-Fire Neuron Circuit}(docs/resources/circuit.png)<br/>
Figure 1: Integrate-and-Fire Neuron Circuit

## Architecture
The chip implements a completely adjustable spiking neural network accelerator(see Figure 2). The system utilizes an 8-bit, 4-phase handshake AE decoder to handle input spike events from asynchronous neuromorphic sensors. The recurrent hidden layer is made up of up to 256 leaky integrate-and-fire (LIF) neurons, which have all-to-all input and recurrent connectivity through 8-bit weights stored in two 64kB SRAMs. The neuron states are stored in a 2kB SRAM, with each 128-bit word storing the states of two LIF neurons, along with their shared leakage and threshold parameters. Input and recurrent spiking activities are buffered into binary sparsity maps, which are then processed at the next timestep. During this processing, the corresponding synaptic weights are read, and two time-multiplexed instances of the LIF update logic are executed: adding the weighted input and recurrent activities to the membrane potential, assessing the threshold crossing condition and the associated reset-by-subtraction mechanism, and computing the membrane decay corresponding to the neuron leakage. The e-prop algorithm, proposed in [3], approximates backpropagation through time (BPTT) by using a product of error-dependent learning signals and eligibility traces (ETs) computed during the feed-forward path. This sidesteps the need to unroll the network in time during training, avoiding the memory penalty that often comes with BPTT by having to use short temporal depths.

![Architecture of Metis}(docs/resources/arch.png)<br/>
Figure 2: Architecture of Metis

## The Mixed-signal Methodology
The mixed-signal design required the creation of the analog neuron's design using Xschem and Ngspice. Once the initial simulation was completed, the design of the digital part began using Verilog. The testbenches were written in C++ and Verilog to verify it using Verilator and Vivado respectively. Once the RTL design and verification were completed, synthesis was done using OpenLane(Yosys) to create a gate-level netlist that could be integrated with the analog neuron's netlist to verify the functionality of the entire chip using Ngspice. Next, the analog neuron's layout was done using MAGIC and sky130 PDK and it was hardened to a macro. Finally the Verilog and the hardened macro was given to the OpenLane flow to produce the final GDSII.
							    
## Observation and Results
The chip achieves 98.96\% accuracy in MNIST [4] dataset(see Figure 3). It could also learn intelligent behaviour from rewards as shown in the Atari video games provided by the Arcade Learning Environment [5](see Figure 4). It is able to achieve these results while only consuming 4.78pJ/SOP at 1.8V supply voltage in 130nm technology(see Figure 5).

![Learning Progress of the RSNN in MNIST trained with e-prop}(docs/resources/final_mnist.png)<br/>
Figure 3: Learning Progress of the RSNN in MNIST trained with e-prop<br/>

![Learning Progress of the RSNN in Pong-v0 trained with reward-based e-prop}(docs/resources/final_pong.png)<br/>
Figure 4: Learning Progress of the RSNN in Pong-v0 trained with reward-based e-prop<br/>

![Comparison to prior work}(docs/resources/final_tablr.png)<br/>
Figure 5: Comparison to prior work

## Conclusion
In this paper, a Mixed-signal Programmable 256-neuron, 2048-synapse neuromorphic chip is implemented in 130nm technology node. The chip uses an analog neuron to achieve minimum energy consumption while avoiding digital overhead. It is equipped with on-chip e-prop algorithm to train the spiking neural network.

## Bibliography
G. K. Chen *et al*. "A 4096-Neuron 1M-Synapse 3.8PJ/SOP Spiking Neural Network with On-Chip STDP Learning and Sparse Weights in 10NM FinFET CMOS," *IEEE Symposium on VLSI Circuits}, Honolulu, HI, USA, 2018, pp. 255-256, doi: 10.1109/VLSIC.2018.8502423.*

Park, J. *et al*. "A 65nm 236.5 nJ/classification neuromorphic processor with 7.5\% energy overhead on-chip learning using direct spike-only feedback." In *2019 IEEE International Solid-State Circuits Conference-(ISSCC)*

Bellec, G. *et al*. A solution to the learning dilemma for recurrent networks of spiking neurons. *Nature communications*, 11(1), 3625.

Deng, L. (2012). The mnist database of handwritten digit images for machine learning research. *IEEE Signal Processing Magazine*, 29(6), 141–142.

Brockman, G.,*et al* OpenAI Gym. arXiv. https://doi.org/10.48550/arXiv.1606.01540
# Neuromorphic IC

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)

