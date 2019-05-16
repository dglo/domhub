#!/bin/bash
#
# Softboot all of the inclinometer DOMs (iDOMs)
# assuming the standard cabling (CWD). Used for
# iDOM readout runs.
#
# Benjamin Eberhardt & Kathrin Mallot
# May 2019
#
ssh testdaq@ichub01 "softboot 71B 71A" &
ssh testdaq@ichub07 "softboot 71B 71A" &
ssh testdaq@ichub08 "softboot 50A 60A 63A" &
ssh testdaq@ichub09 "softboot 70B 70A 71B 71A" &
ssh testdaq@ichub22 "softboot 71B 71A" &
ssh testdaq@ichub23 "softboot 51A 62B 63A 71A" &
ssh testdaq@ichub24 "softboot 70B 70A 71B 71A" &
ssh testdaq@ichub25 "softboot 31B 53A 62A 71A" &
ssh testdaq@ichub31 "softboot 71B 71A" &
ssh testdaq@ichub32 "softboot 41A 53B 61A 71A" &
ssh testdaq@ichub35 "softboot 70B 70A 71B 71A" &
ssh testdaq@ichub43 "softboot 41B 52A 61B 71A" &
ssh testdaq@ichub51 "softboot 43B 60B 63B 71A" &
ssh testdaq@ichub80 "softboot 70B 70A 71B 71A"
