# Toronto Bike Share Analytics

.PHONY: help update test clean

help:
	@echo "Toronto Bike Share Analytics"
	@echo ""
	@echo "Usage:"
	@echo "  make update   - Fetch data, regenerate README, plots, and dashboard"
	@echo "  make test     - Run the R test suite"
	@echo "  make clean    - Remove generated plot images"

# Fetch the latest snapshot and regenerate all outputs
update:
	Rscript update_report.R

# Run the test suite
test:
	Rscript tests/run_all.R

# Remove generated plot images (data and dashboards are kept)
clean:
	rm -rf docs/plots
	@echo "Removed generated plots."
