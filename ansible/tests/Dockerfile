FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Create a non-root user to simulate a real WSL user environment.
# The user needs passwordless sudo for tasks that use become: true.
RUN useradd -m -s /bin/bash testuser \
    && echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN apt-get update -qq && apt-get install -y \
    ansible \
    git \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

USER testuser
WORKDIR /home/testuser

COPY --chown=testuser:testuser . /home/testuser/.files

# Install required Galaxy collections
RUN ansible-galaxy collection install \
    -r /home/testuser/.files/ansible/requirements.yml

# First run: full provisioning
RUN ansible-playbook /home/testuser/.files/ansible/playbook.yml \
    -i /home/testuser/.files/ansible/inventory \
    -v

# Second run: must produce 0 changed tasks.
# If any task reports changed, the diff output helps diagnose what broke idempotency.
RUN ansible-playbook /home/testuser/.files/ansible/playbook.yml \
    -i /home/testuser/.files/ansible/inventory \
    --diff \
    | tee /tmp/second-run.log \
    && grep -q "changed=0" /tmp/second-run.log
