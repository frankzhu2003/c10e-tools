FROM python:3.9

CMD ["bash"]

ENV PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ENV LANG=C.UTF-8

RUN /bin/sh -c set -eux; apt-get update; apt-get install -y --no-install-recommends ca-certificates netbase; rm -rf /var/lib/apt/lists/*

ENV GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568

ENV PYTHON_VERSION=3.8.12

RUN /bin/sh -c set -ex && savedAptMark="$(apt-mark showmanual)" && apt-get update && apt-get install -y --no-install-recommends dpkg-dev gcc libbluetooth-dev libbz2-dev libc6-dev libexpat1-dev libffi-dev libgdbm-dev liblzma-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev make tk-dev uuid-dev wget xz-utils zlib1g-dev $(command -v gpg > /dev/null || echo 'gnupg dirmngr') && wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" && wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" && export GNUPGHOME="$(mktemp -d)" && gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys "$GPG_KEY" && gpg --batch --verify python.tar.xz.asc python.tar.xz && { command -v gpgconf > /dev/null && gpgconf --kill all || :; } && rm -rf "$GNUPGHOME" python.tar.xz.asc && mkdir -p /usr/src/python && tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz 	&& rm python.tar.xz && cd /usr/src/python && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" && ./configure --build="$gnuArch" --enable-loadable-sqlite-extensions --enable-optimizations --enable-option-checking=fatal --enable-shared --with-system-expat --with-system-ffi --without-ensurepip && make -j "$(nproc)" LDFLAGS="-Wl,--strip-all" && make install && rm -rf /usr/src/python && find /usr/local -depth \( \( -type d -a \( -name test -o -name tests -o -name idle_test \) \) -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' -o -name '*.a' \) \) -o \( -type f -a -name 'wininst-*.exe' \) \) -exec rm -rf '{}' + && ldconfig && apt-mark auto '.*' > /dev/null && apt-mark manual $savedAptMark && find /usr/local -type f -executable -not \( -name '*tkinter*' \) -exec ldd '{}' ';' | awk '/=>/ { print $(NF-1) }' | sort -u | xargs -r dpkg-query --search | cut -d: -f1 | sort -u | xargs -r apt-mark manual && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && rm -rf /var/lib/apt/lists/* && python3 --version

# RUN /bin/sh -c set -eux; 	for src in idle3 pydoc3 python3 python3-config; do 		dst="$(echo "$src" | tr -d 3)"; 		[ -s "/usr/local/bin/$src" ]; 		[ ! -e "/usr/local/bin/$dst" ]; 		ln -svT "/usr/local/bin/$src" "/usr/local/bin/$dst"; 	done

ENV PYTHON_PIP_VERSION=21.2.4

ENV PYTHON_SETUPTOOLS_VERSION=57.5.0

ENV PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/2caf84b14febcda8077e59e9b8a6ef9a680aa392/public/get-pip.py

ENV PYTHON_GET_PIP_SHA256=7c5239cea323cadae36083079a5ee6b2b3d56f25762a0c060d2867b89e5e06c5

RUN /bin/sh -c set -ex; 		savedAptMark="$(apt-mark showmanual)"; 	apt-get update; 	apt-get install -y --no-install-recommends wget; 		wget -O get-pip.py "$PYTHON_GET_PIP_URL"; 	echo "$PYTHON_GET_PIP_SHA256 *get-pip.py" | sha256sum --check --strict -; 		apt-mark auto '.*' > /dev/null; 	[ -z "$savedAptMark" ] || apt-mark manual $savedAptMark; 	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; 	rm -rf /var/lib/apt/lists/*; 		python get-pip.py 		--disable-pip-version-check 		--no-cache-dir 		"pip==$PYTHON_PIP_VERSION" 		"setuptools==$PYTHON_SETUPTOOLS_VERSION" 	; 	pip --version; 		find /usr/local -depth 		\( 			\( -type d -a \( -name test -o -name tests -o -name idle_test \) \) 			-o 			\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) 		\) -exec rm -rf '{}' +; 	rm -f get-pip.py

CMD ["python3"]

# RUN /bin/sh -c mkdir /app

WORKDIR /app

RUN apt update &&     apt install -y iproute2 iputils-ping stress git

RUN pip install flask requests structlog

RUN pip install opentelemetry-api opentelemetry-sdk opentelemetry-instrumentation opentelemetry-propagator-b3 opentelemetry-distro opentelemetry-exporter-otlp

RUN pip install flask opentelemetry-instrumentation-flask requests opentelemetry-instrumentation-requests   

RUN opentelemetry-bootstrap -a install

RUN pip install opentelemetry-exporter-otlp-proto-grpc

# RUN pip install -e "git+https://github.com/codeboten/opentelemetry-python.git#egg=opentelemetry-exporter-otlp-proto-grpc&subdirectory=exporter/opentelemetry-exporter-otlp-proto-grpc" 

# RUN pip install -e "git+https://github.com/codeboten/opentelemetry-python.git@metric-reader-storage-2378#egg=opentelemetry-sdk&subdirectory=opentelemetry-sdk"

# ADD ./product.py ./ 

COPY ./localmachineresourcedetector.py ./

COPY ./common.py ./

COPY ./grocery_store.py ./

RUN chmod u+x /app/grocery_store.py

CMD ["python3", "/app/grocery_store.py"]

# CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]



