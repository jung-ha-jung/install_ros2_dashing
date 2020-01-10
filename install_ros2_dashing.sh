#!/bin/sh -e

echo "[#Setup Locale]"
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8


echo "[#Setup Sources]"
sudo apt update && sudo apt install curl gnupg2 lsb-release
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
#add the repository to your sources list
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'


echo "[#Install ROS 2 packages]"
sudo apt update
sudo apt install ros-dashing-desktop
#sudo apt install ros-dashing-ros-base


echo "[#Environment setup]"
echo "[#Sourcing the setup script]"
source /opt/ros/dashing/setup.bash
echo "[#Launching the setup script]"
sh -c "echo \"source /opt/ros/dashing/setup.bash\" >> ~/.bashrc"

echo "[#Install argcomplete]"
sudo apt install python3-argcomplete


#Try some examples
#ros2 run demo_nodes_cpp talker
#new terminal execution
#tmux new -s
#ros2 run demo_nodes_py listener


echo "[#Install additional RMW implementations]"
sudo apt update
sudo apt install ros-dashing-rmw-opensplice-cpp # for OpenSplice
#sudo apt install ros-dashing-rmw-connext-cpp # for RTI Connext (requires license agreement)


#echo "[#Install additional packages using ROS 1 packages]"
#sudo apt update
#sudo apt install ros-dashing-ros1-bridge


echo "[#Install turtlesim]" #https://index.ros.org/doc/ros2/Tutorials/Turtlesim/Introducing-Turtlesim/
sudo apt update
sudo apt install ros-dashing-turtlesim
#ros2 pkg executables turtlesim
#Use turtlesim
#ros2 run turtlesim turtlesim_node
#ros2 run turtlesim turtle_teleop_key



#-----------------------------------------------------------------------------------------------
echo "[#Install colcon to build packages]"
sudo apt install python3-colcon-common-extensions

echo "[#Create example workspace]"
mkdir -p ~/ros2_example_ws/src
cd ~/ros2_example_ws

echo "[#Add example sources]"
git clone https://github.com/ros2/examples src/examples
cd ~/ros2_example_ws/src/examples/
git checkout dashing
cd ~/ros2_example_ws

echo "[#Build the workspace]"
colcon build --symlink-install

echo "[#Source the environment]"
. install/setup.bash

#Try a demo
#ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function

#tmux new -s
#ros2 run examples_rclcpp_minimal_publisher publisher_member_function

#Tips
#If you do not want to build a specific package place an empty file named COLCON_IGNORE in the directory and it will not be indexed.
