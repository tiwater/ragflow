FROM infiniflow/ragflow-base:v2.0
USER  root

WORKDIR /ragflow

ADD ./requirements_dev.txt ./requirements_dev.txt
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple/ -r requirements_dev.txt
RUN pip3 install -i https://mirrors.aliyun.com/pypi/simple/ pocketbase --no-deps

ADD ./web ./web
RUN cd ./web && npm i --force && npm run build

ADD ./api ./api
ADD ./conf ./conf
ADD ./deepdoc ./deepdoc
ADD ./rag ./rag

ENV PYTHONPATH=/ragflow/
ENV HF_ENDPOINT=https://hf-mirror.com

ADD docker/entrypoint.sh ./entrypoint.sh
ADD docker/.env ./
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]