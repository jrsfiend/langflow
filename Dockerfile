FROM python:3.10

RUN apt-get update && apt-get install gcc g++ git make -y && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
	PATH=/home/user/.local/bin:$PATH

WORKDIR $HOME/app

COPY --chown=user . $HOME/app

RUN pip install langflow>==0.0.86 -U --user
CMD ["python", "-m", "langflow", "--host", "0.0.0.0", "--port", "10000", "--workers", "8"]
