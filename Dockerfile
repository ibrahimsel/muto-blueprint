FROM ros:humble-ros-core

RUN apt update && apt install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-pip \
    git

RUN rosdep init && rosdep update

COPY . /root/composer_ws/src/composer

WORKDIR /root/composer_ws

RUN rosdep install --from-paths src --ignore-src -r -y

RUN . /opt/ros/humble/setup.sh && colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN echo "source /root/composer_ws/install/setup.bash" >> ~/.bashrc

ENTRYPOINT ["/bin/bash", "-c", "source /root/composer_ws/install/setup.bash", "echo 'hello'"]
