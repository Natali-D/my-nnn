- hosts: 10.*.*.*
    tasks:
      - name: make dir
        command: mkdir /etc/doc1
        ignore_errors: true
        tags: web
      - name: make dir
        command: mkdir /etc/doc2
        ignore_errors: true
        tags: py
      - name: Install apache
        copy:
          src: /root/exam/doc1/dockerfile
          dest: /etc/doc1/ 
        ignore_errors: true
        tags: web
      - name: server.py
        copy:
          src: /root/exam/doc2/dockerfile
          dest: /etc/doc2/ 
        ignore_errors: true
        tags: py
      - name: install docker.io
        apt:
          pkg: docker.io
          state: latest
          update_cache: yes
        tags: install_d
      - name: stop container web
        command: docker stop c_web
        ignore_errors: true
        tags: web
      - name: stop container py
        command: docker stop c_py
        ignore_errors: true
        tags: py
      - name: delete container web
        command: docker rm c_web
        ignore_errors: true
        tags: web
      - name: delete container ru
        command: docker rm c_ru
        ignore_errors: true
        tags: py
      - name: for image web
        command: cd /etc/doc1
        ignore_errors: true
        tags: web
      - name: make image web
        command: docker build -t i_web:1.0 ./
        ignore_errors: true
        tags: web
      - name: for image py
        command: cd /etc/doc2
        ignore_errors: true
        tags: py
      - name: make image ru
        command: docker build -t i_py:1.0 ./
        ignore_errors: true
        tags: py
      - name: make container web
        command: docker run -itd -- name i_web:1.0 -p 80:80 c_web
        ignore_errors: true
        tags: web
      - name: make container py
        command: docker run -itd -- name i_py:1.0 -p 80:80 c_py
        ignore_errors: true
        tags: py

