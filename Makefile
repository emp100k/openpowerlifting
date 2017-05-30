.PHONY: builddir csvfile check probe

DATADIR = meet-data
BUILDDIR = build

PLFILE = openpowerlifting.csv
PLFILEJS = openpowerlifting.js
MEETFILE = meets.csv
MEETFILEJS = meets.js

all: csvfile sqlite web

builddir:
	mkdir -p '${BUILDDIR}'

# Cram all the data into a single, huge CSV file.
csvfile: builddir
	scripts/compile "${BUILDDIR}" "${DATADIR}"
	scripts/age-from-birthyear "${BUILDDIR}/${PLFILE}" "${BUILDDIR}/${MEETFILE}"
	scripts/csv-bodyweight "${BUILDDIR}/${PLFILE}"
	scripts/csv-wilks "${BUILDDIR}/${PLFILE}"

sqlite: csvfile
	scripts/compile-sqlite

web: csvfile
	$(MAKE) -C web

# Make sure that all the fields in the CSV files are in expected formats.
check:
	scripts/check-lifters-csv
	scripts/check-meet-csv
	scripts/check-sex-consistency

# List of probes for federations that should be fully up-to-date,
# or at least are quick to read and not filled with noise.
# Data showing up here should be immediately actionable.
probe-quick:
	${DATADIR}/commonwealthpf/commonwealthpf-probe || true
	${DATADIR}/ipa/ipa-probe || true
	${DATADIR}/nipf/nipf-probe || true
	${DATADIR}/pa/pa-probe || true
	${DATADIR}/rps/rps-probe || true
	${DATADIR}/rupc/rupc-probe || true
	${DATADIR}/sct/sct-probe || true
	${DATADIR}/spf/spf-probe || true
	${DATADIR}/spf-archive/spf-archive-probe || true
	${DATADIR}/usapl/usapl-probe || true
	${DATADIR}/uspa/uspa-probe || true
	${DATADIR}/xpc/xpc-probe || true

# List of all probes.
probe:
	${DATADIR}/apf/apf-probe || true
	${DATADIR}/commonwealthpf/commonwealthpf-probe || true
	${DATADIR}/cpf/cpf-probe || true
	${DATADIR}/epf/epf-probe || true
	${DATADIR}/fesupo/fesupo-probe || true
	${DATADIR}/fpo/fpo-probe || true
	${DATADIR}/gbpf/gbpf-probe || true
	${DATADIR}/ipa/ipa-probe || true
	${DATADIR}/ipf/ipf-probe || true
	${DATADIR}/napf/napf-probe || true
	${DATADIR}/nasa/nasa-probe || true
	${DATADIR}/nipf/nipf-probe || true
	${DATADIR}/nsf/nsf-probe || true
	${DATADIR}/pa/pa-probe || true
	${DATADIR}/raw/raw-probe || true
	${DATADIR}/rps/rps-probe || true
	${DATADIR}/rupc/rupc-probe || true
	${DATADIR}/sct/sct-probe || true
	${DATADIR}/spf/spf-probe || true
	${DATADIR}/spf-archive/spf-archive-probe || true
	${DATADIR}/thspa/thspa-probe || true
	${DATADIR}/upa/upa-probe || true
	${DATADIR}/usapl/usapl-probe || true
	${DATADIR}/usapl-archive/usapl-archive-probe || true
	${DATADIR}/uspa/uspa-probe || true
	${DATADIR}/wrpf/wrpf-probe || true
	${DATADIR}/xpc/xpc-probe || true

clean:
	rm -rf '${BUILDDIR}'
	rm -rf 'scripts/__pycache__'
	rm -rf '${DATADIR}/cpu/__pycache__'
	rm -rf '${DATADIR}/nasa/__pycache__'
	rm -rf '${DATADIR}/nipf/__pycache__'
	rm -rf '${DATADIR}/nsf/__pycache__'
	rm -rf '${DATADIR}/pa/__pycache__'
	rm -rf '${DATADIR}/rps/__pycache__'
	rm -rf '${DATADIR}/spf/__pycache__'
	rm -rf '${DATADIR}/thspa/__pycache__'
	rm -rf '${DATADIR}/usapl/__pycache__'
	rm -rf '${DATADIR}/ipf/__pycache__'
	$(MAKE) -C web clean
