# interview-env

An environment for system administrators and SREs interviews.

# What's it?

The interviewing for jobs like system administrator or SRE sometimes requires some interaction between a candidate and an interviewer. The task is completely solved for a programming interview. You can use online platforms (codeshare.io e.g.) for screen/code sharing or the candidate may share their screen with IDE via Zoom or Google Meet.

But what should we do with the interview tasks about software/databases/system/network/etc troubleshooting and debugging? When we need tools like strace/proc/netstat/tcpdump/nsenter or console database client. Sure we can use imagination :) to talk and reason about situations and problems. 

I think the better way is using a similar service where the candidate may connect via SSH and get a set of tasks for online solving by their hands. The interviewers could see the candidate's terminal (w/o screen sharing) and may give some advice or may interact with the remote session.

# A solution that I see for the problem

(There're my thoughts and a small technical task. May be like the White Paper in FAANG companies).

The solution (or the product) should be maximum portable and independent from the environment. What follows from this? I can't use VMs images because the images depend on cloud providers. And I can use only open software and services (w/o the internals from my company e.g.)
A good idea is using Docker and Docker Compose. But I need privileged containers for tools like strace (the ptrace syscall) or ip (a network namespace creation). In general it isn't a problem.

# Unanswered questions

Should it use only an operating system image and docker-compose? Or does it have to build docker images that everybody could run? The second way avoids to run a package manager (like yum) to install software each time and saves a lot of time. But the first is faster during the developing process and I could get a minimal working model really soon.

# How it works
## The basic image 'ssh-interview'

You can login via SSH as user 'user' with ssh-key or password. A tmux session will open automatically after the user's first login. All extra user's sessions will be attached to that tmux session. As a result all users (a candidate and interviewers) will see and use the same session and will type on the same terminal. The interviewers may help the candidate if they want and could totally see a task solving process.

The image could be used as the basic layer or for developing or debugging new tasks.

## The tasks images

Coming soon...

# The roadmap
- ✅ Basic image that provides
-- ✅ sshd
-- ✅ password auth
-- ✅ ssh keys auth
-- ✅ shared tmux session
-- ✅ scripts for building, run and debug the image
- ❌ Task example image
-- ❌ A simple task
-- ❌ scripts for rebuild all test images
- ❌ Scripts or docker-compose for running specific task
- ❌ A production task
- ❌ Docker-compose or smtl like that
-- ❌ For ssh-keys installation e.g.
- ❌ Scripts or docker-compose for running specific task
- ❌ Dockerhub integration
- Complete docs