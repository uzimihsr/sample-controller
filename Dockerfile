FROM golang AS build

WORKDIR /sample-controller

COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o /out/sample-controller .

FROM scratch

COPY --from=build /out/sample-controller /

ENTRYPOINT [ "/sample-controller" ]