#!/usr/bin/env python3

import argparse
import json
import csv

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", "-i", help="input file", required=True)
    parser.add_argument("--output", "-o", help="output file", required=True)
    args = parser.parse_args()

    in_file = args.input
    out_file = args.output
    result = []

    try:
        with open(in_file,"r") as f:
            data = json.load(f)
    except:
        print("Error reading data")
        return

    result.append([".jobs.read.slat_ns.mean",".jobs.read.clat_ns.mean",".jobs.read.clat_ns.percentile",".jobs.read.clat_ns.percentile_val",".jobs.write.slat_ns.mean",".jobs.write.clat_ns.mean",".jobs.write.clat_ns.percentile",".jobs.write.clat_ns.percentile_val"])

    try:
        for j in data["jobs"]:
            result.append([j["read"]["slat_ns"]["mean"],j["read"]["clat_ns"]["mean"],"50",j["read"]["clat_ns"]["percentile"]["50.000000"],j["write"]["slat_ns"]["mean"],j["write"]["clat_ns"]["mean"],"50",j["write"]["clat_ns"]["percentile"]["50.000000"]])
            result.append(["","","80",j["read"]["clat_ns"]["percentile"]["80.000000"],"","","80",j["write"]["clat_ns"]["percentile"]["80.000000"]])
            result.append(["","","90",j["read"]["clat_ns"]["percentile"]["90.000000"],"","","90",j["write"]["clat_ns"]["percentile"]["90.000000"]])
            result.append(["","","95",j["read"]["clat_ns"]["percentile"]["95.000000"],"","","95",j["write"]["clat_ns"]["percentile"]["95.000000"]])
            result.append(["","","99",j["read"]["clat_ns"]["percentile"]["99.000000"],"","","99",j["write"]["clat_ns"]["percentile"]["99.000000"]])
    except KeyError:
        print("No jobs in data")
        return
    with open(out_file,"w") as f:
        writer = csv.writer(f, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        writer.writerows(result)
    return

if __name__ == "__main__":
    main()
