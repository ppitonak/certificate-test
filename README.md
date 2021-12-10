oc apply -f pipeline.yaml && tkn p start test-certificates --use-param-defaults -w name=source,claimName=shared-pvc --showlog
