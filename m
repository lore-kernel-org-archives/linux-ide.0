From: Hubert Bailey <hbailey@marvell.com>
Subject: RE: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Thu, 7 Jul 2011 21:42:40 -0700
Message-ID: <B9B10C29375C5B40A2D240808654F60E5EE470A72D@SC-VEXCH2.marvell.com>
References: <4DEE6831.9020501@seoss.co.uk>
 <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk>
 <20110610102403.GE15235@htj.dyndns.org> <4DF249BB.3040808@seoss.co.uk>
 <4E14C6ED.5040208@buttersideup.com> <4E15A2F1.7080106@seoss.co.uk>
 <4E15FB4A.809@buttersideup.com> <4E15FD43.6030701@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36172 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750816Ab1GHEnW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jul 2011 00:43:22 -0400
In-Reply-To: <4E15FD43.6030701@seoss.co.uk>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tim Small' <tim@seoss.co.uk>, Tejun Heo <tj@kernel.org>, Larry Li <lil@marvell.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tim,

The 9125 is a simple controller without a internal processor.  The 9123 contains an internal processor to enhance RAID 0/1 operations.  If you are testing in a JBOD configuration you will not take advantage of the 9123 internal processor.  The internal processor can result in lower performance than the 9125.  However if you configure the drives in a RAID configuration using the 9123 RAID  utility you should see better performance than with 9125.

-----Original Message-----
From: Tim Small [mailto:tim@seoss.co.uk]
Sent: Thursday, July 07, 2011 1:39 PM
To: Tejun Heo; Hubert Bailey; Larry Li; linux-ide@vger.kernel.org
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI controller

In the same machine as the previous test set, but with 2.6.38 (debian squeeze backports kernel):

NCQ 1, two drives both connected to 3726 behind the **88SE9123** (previous mail was for the 88SE9125):

# while true ; do sh -c "(hdparm -t /dev/sdb & hdparm -t /dev/sdc) 2>&1
| grep MB" ; done
 Timing buffered disk reads: 190 MB in  3.02 seconds =  62.97 MB/sec 190 MB in  3.02 seconds =  62.99 MB/sec  Timing buffered disk reads: 194 MB in  3.02 seconds =  64.27 MB/sec
194 MB in  3.02 seconds =  64.24 MB/sec
 Timing buffered disk reads: 192 MB in  3.01 seconds =  63.87 MB/sec
194 MB in  3.01 seconds =  64.44 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.26 MB/sec
194 MB in  3.02 seconds =  64.23 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.14 MB/sec
194 MB in  3.03 seconds =  64.13 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.31 MB/sec
194 MB in  3.02 seconds =  64.18 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.31 MB/sec
194 MB in  3.02 seconds =  64.15 MB/sec
 Timing buffered disk reads: 192 MB in  3.01 seconds =  63.73 MB/sec
196 MB in  3.02 seconds =  64.87 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.16 MB/sec
194 MB in  3.02 seconds =  64.27 MB/sec
 Timing buffered disk reads: 192 MB in  3.01 seconds =  63.72 MB/sec
196 MB in  3.02 seconds =  64.83 MB/sec
 Timing buffered disk reads: 194 MB in  3.01 seconds =  64.47 MB/sec
192 MB in  3.01 seconds =  63.79 MB/sec


... so it works, but is about 50% slower than the 88SE9125...

change NCQ depth to 31:

# while true ; do sh -c "(hdparm -t /dev/sdb & hdparm -t /dev/sdc) 2>&1
| grep MB" ; done
[after a considerable pause:]
 Timing buffered disk reads: 382 MB in  3.01 seconds = 127.10 MB/sec


... i.e. one drive results only, the other read failed, with this in dmesg:

[ 2930.016043] ata7.00: failed to read SCR 1 (Emask=0x40) [ 2930.020801] ata7.01: failed to read SCR 1 (Emask=0x40) [ 2930.025429] ata7.02: failed to read SCR 1 (Emask=0x40) [ 2930.029970] ata7.03: failed to read SCR 1 (Emask=0x40) [ 2930.034447] ata7.04: failed to read SCR 1 (Emask=0x40) [ 2930.038859] ata7.05: failed to read SCR 1 (Emask=0x40) [ 2930.043218] ata7.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6 frozen [ 2930.047661] ata7.00: exception Emask 0x100 SAct 0xc SErr 0x0 action
0x6 frozen
[ 2930.052077] ata7.00: failed command: READ FPDMA QUEUED [ 2930.056439] ata7.00: cmd 60/00:10:00:06:00/01:00:00:00:00/40 tag 2 ncq 131072 in
[ 2930.056443]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2930.065295] ata7.00: status: { DRDY } [ 2930.069753] ata7.00: failed command: READ FPDMA QUEUED [ 2930.074243] ata7.00: cmd 60/00:18:00:07:00/01:00:00:00:00/40 tag 3 ncq 131072 in
[ 2930.074247]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2930.083380] ata7.00: status: { DRDY } [ 2930.087981] ata7.01: exception Emask 0x100 SAct 0x3 SErr 0x0 action
0x6 frozen
[ 2930.092672] ata7.01: failed command: READ FPDMA QUEUED [ 2930.097279] ata7.01: cmd 60/00:00:00:06:00/01:00:00:00:00/40 tag 0 ncq 131072 in
[ 2930.097283]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2930.106463] ata7.01: status: { DRDY } [ 2930.111040] ata7.01: failed command: READ FPDMA QUEUED [ 2930.115630] ata7.01: cmd 60/00:08:00:07:00/01:00:00:00:00/40 tag 1 ncq 131072 in
[ 2930.115634]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2930.124786] ata7.01: status: { DRDY } [ 2930.129349] ata7.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2930.133977] ata7.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2930.138537] ata7.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2930.143074] ata7.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2930.147538] ata7.15: hard resetting link [ 2930.864034] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 2930.868757] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 2930.873236] ata7.15: PMP revalidation failed (errno=-19) [ 2935.868025] ata7.15: hard resetting link [ 2936.588038] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 2936.592742] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 2936.597296] ata7.15: PMP revalidation failed (errno=-19) [ 2936.601803] ata7.15: limiting SATA link speed to 1.5 Gbps [ 2941.592044] ata7.15: hard resetting link [ 2942.312039] ata7.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310) [ 2942.316762] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 2942.321236] ata7.15: PMP revalidation failed (errno=-19) [ 2942.325672] ata7.15: failed to recover PMP after 5 tries, giving up [ 2942.330101] ata7.15: Port Multiplier detaching [ 2942.334489] ata7.00: disabled [ 2942.338863] ata7.01: disabled [ 2942.343145] ata7.00: disabled [ 2947.316024] ata7: hard resetting link [ 2948.036036] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 2948.040497] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9 [ 2948.044701] ahci 0000:02:00.0: FBS is enabled.
[ 2948.049005] ata7.00: hard resetting link [ 2948.368250] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320) [ 2948.372472] ata7.01: hard resetting link [ 2948.696248] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300) [ 2948.700471] ata7.02: hard resetting link [ 2949.024255] ata7.02: SATA link down (SStatus 0 SControl 320) [ 2949.028581] ata7.03: hard resetting link [ 2949.352249] ata7.03: SATA link down (SStatus 0 SControl 320) [ 2949.356582] ata7.04: hard resetting link [ 2949.680248] ata7.04: SATA link down (SStatus 0 SControl 320) [ 2949.684638] ata7.05: hard resetting link [ 2950.008192] ata7.05: failed to write SCR 1 (Emask=0x1) [ 2950.012618] ata7.05: SATA link down (SStatus 0 SControl 0) [ 2950.018426] ata7.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[ 2950.022698] ata7.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA [ 2950.028551] ata7.00: configured for UDMA/133 [ 2950.034073] ata7.01: native sectors (2) is smaller than sectors
(3907029168)
[ 2950.038668] ata7.01: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[ 2950.043219] ata7.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA [ 2950.049087] ata7.01: configured for UDMA/133 [ 2950.053758] ata7.01: device reported invalid CHS sector 0 [ 2950.058290] ata7.01: device reported invalid CHS sector 0 [ 2950.062735] ata7.00: device reported invalid CHS sector 0 [ 2950.067131] ata7.00: device reported invalid CHS sector 0 [ 2950.071451] sd 6:1:0:0: [sdc]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 2950.075844] sd 6:1:0:0: [sdc]  Sense Key : Aborted Command [current] [descriptor] [ 2950.080228] Descriptor sense data with sense descriptors (in hex):
[ 2950.084616]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 2950.089114]         00 00 00 00
[ 2950.093453] sd 6:1:0:0: [sdc]  Add. Sense: No additional sense information [ 2950.097839] sd 6:1:0:0: [sdc] CDB: Read(10): 28 00 00 00 06 00 00 01 00 00 [ 2950.102283] end_request: I/O error, dev sdc, sector 1536 [ 2950.106652] quiet_error: 45 callbacks suppressed [ 2950.110957] Buffer I/O error on device sdc, logical block 192 [ 2950.115306] Buffer I/O error on device sdc, logical block 193 [ 2950.119578] Buffer I/O error on device sdc, logical block 194 [ 2950.123816] Buffer I/O error on device sdc, logical block 195 [ 2950.127958] Buffer I/O error on device sdc, logical block 196 [ 2950.132036] Buffer I/O error on device sdc, logical block 197 [ 2950.136119] Buffer I/O error on device sdc, logical block 198 [ 2950.140190] Buffer I/O error on device sdc, logical block 199 [ 2950.14426
 9] Buffer I/O error on device sdc, logical block 200 [ 2950.148281] Buffer I/O error on device sdc, logical block 201 [ 2950.152265] sd 6:1:0:0: [sdc]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 2950.156275] sd 6:1:0:0: [sdc]  Sense Key : Aborted Command [current] [descriptor] [ 2950.160289] Descriptor sense data with sense descriptors (in hex):
[ 2950.164318]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 2950.168471]         00 00 00 00
[ 2950.172471] sd 6:1:0:0: [sdc]  Add. Sense: No additional sense information [ 2950.176525] sd 6:1:0:0: [sdc] CDB: Read(10): 28 00 00 00 07 00 00 01 00 00 [ 2950.180659] end_request: I/O error, dev sdc, sector 1792 [ 2950.184743] sd 6:0:0:0: [sdb]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 2950.188856] sd 6:0:0:0: [sdb]  Sense Key : Aborted Command [current] [descriptor] [ 2950.192976] Descriptor sense data with sense descriptors (in hex):
[ 2950.197094]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 2950.201337]         00 00 00 00
[ 2950.205439] sd 6:0:0:0: [sdb]  Add. Sense: No additional sense information [ 2950.209626] sd 6:0:0:0: [sdb] CDB: Read(10): 28 00 00 00 06 00 00 01 00 00 [ 2950.213939] end_request: I/O error, dev sdb, sector 1536 [ 2950.218252] sd 6:0:0:0: [sdb]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 2950.222627] sd 6:0:0:0: [sdb]  Sense Key : Aborted Command [current] [descriptor] [ 2950.227010] Descriptor sense data with sense descriptors (in hex):
[ 2950.231370]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 2950.235813]         00 00 00 00
[ 2950.240143] sd 6:0:0:0: [sdb]  Add. Sense: No additional sense information [ 2950.244528] sd 6:0:0:0: [sdb] CDB: Read(10): 28 00 00 00 07 00 00 01 00 00 [ 2950.248975] end_request: I/O error, dev sdb, sector 1792 [ 2950.253351] ata7: EH complete [ 2950.257986] ata7.00: detaching (SCSI 6:0:0:0) [ 2950.260412] sd 6:1:0:0: rejecting I/O to offline device [ 2950.262676] sd 6:0:0:0: rejecting I/O to offline device [ 2950.272236] sd 6:0:0:0: [sdb] Synchronizing SCSI cache [ 2950.274778] sd 6:0:0:0: [sdb] Stopping disk [ 2950.284568] end_request: I/O error, dev sdb, sector 0 [ 2950.287099] sd 6:1:0:0: rejecting I/O to offline device [ 2950.288321] end_request: I/O error, dev sdc, sector 0 [ 2950.291531] end_request: I/O error, dev sdb, sector 0 [ 2950.293912] sd 6:1:0:0: rejecting I/O to offli
 ne device [ 2950.296077] end_request: I/O error, dev sdc, sector 0 [ 2950.868137] ata7.01: detaching (SCSI 6:1:0:0) [ 2950.879987] sd 6:1:0:0: [sdc] Synchronizing SCSI cache [ 2950.884351] sd 6:1:0:0: [sdc] Stopping disk
[ 2951.490748] scsi 6:0:0:0: Direct-Access     ATA      Hitachi HDS5C302
ML6O PQ: 0 ANSI: 5
[ 2951.497341] sd 6:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[ 2951.501834] sd 6:0:0:0: [sdb] Write Protect is off [ 2951.506067] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 2951.506855] scsi 6:1:0:0: Direct-Access     ATA      Hitachi HDS5C302
ML6O PQ: 0 ANSI: 5
[ 2951.518252] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 2951.523911] sd 6:1:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[ 2951.530008] sd 6:1:0:0: [sdc] Write Protect is off [ 2951.532522] sd 6:1:0:0: [sdc] Mode Sense: 00 3a 00 00 [ 2951.533349] sd 6:1:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 2953.444386]  sdc: sdc1
[ 2953.450667] sd 6:1:0:0: [sdc] Attached SCSI disk [ 2954.301886]  sdb: sdb1 [ 2954.311753] sd 6:0:0:0: [sdb] Attached SCSI disk [ 2994.016046] ata7.00: failed to read SCR 1 (Emask=0x40) [ 2994.020684] ata7.01: failed to read SCR 1 (Emask=0x40) [ 2994.025282] ata7.02: failed to read SCR 1 (Emask=0x40) [ 2994.029859] ata7.03: failed to read SCR 1 (Emask=0x40) [ 2994.034443] ata7.04: failed to read SCR 1 (Emask=0x40) [ 2994.039024] ata7.05: failed to read SCR 1 (Emask=0x40) [ 2994.043613] ata7.15: exception Emask 0x4 SAct 0x0 SErr 0x400000 action 0x6 frozen [ 2994.048221] ata7.15: SError: { Handshk } [ 2994.052790] ata7.00: exception Emask 0x100 SAct 0xa SErr 0x0 action
0x6 frozen
[ 2994.057393] ata7.00: failed command: READ FPDMA QUEUED [ 2994.061957] ata7.00: cmd 60/00:08:00:18:00/01:00:00:00:00/40 tag 1 ncq 131072 in
[ 2994.061961]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2994.071179] ata7.00: status: { DRDY } [ 2994.075747] ata7.00: failed command: READ FPDMA QUEUED [ 2994.080311] ata7.00: cmd 60/00:18:00:19:00/01:00:00:00:00/40 tag 3 ncq 131072 in
[ 2994.080314]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2994.089460] ata7.00: status: { DRDY } [ 2994.093974] ata7.01: exception Emask 0x100 SAct 0x5 SErr 0x0 action
0x6 frozen
[ 2994.098544] ata7.01: failed command: READ FPDMA QUEUED [ 2994.103096] ata7.01: cmd 60/00:00:00:04:00/01:00:00:00:00/40 tag 0 ncq 131072 in
[ 2994.103099]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2994.112254] ata7.01: status: { DRDY } [ 2994.116770] ata7.01: failed command: READ FPDMA QUEUED [ 2994.121280] ata7.01: cmd 60/00:10:00:05:00/01:00:00:00:00/40 tag 2 ncq 131072 in
[ 2994.121283]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[ 2994.130329] ata7.01: status: { DRDY } [ 2994.134794] ata7.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2994.139343] ata7.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2994.143815] ata7.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2994.148233] ata7.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[ 2994.152588] ata7.15: hard resetting link [ 2994.872040] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 2994.876666] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 2994.881056] ata7.15: PMP revalidation failed (errno=-19) [ 2999.876031] ata7.15: hard resetting link [ 3000.596037] ata7.15: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 3000.600759] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 3000.605307] ata7.15: PMP revalidation failed (errno=-19) [ 3000.609803] ata7.15: limiting SATA link speed to 1.5 Gbps [ 3005.600038] ata7.15: hard resetting link [ 3006.320038] ata7.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310) [ 3006.324835] ata7.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[ 3006.329398] ata7.15: PMP revalidation failed (errno=-19) [ 3006.333932] ata7.15: failed to recover PMP after 5 tries, giving up [ 3006.338486] ata7.15: Port Multiplier detaching [ 3006.343045] ata7.00: disabled [ 3006.347531] ata7.01: disabled [ 3006.351918] ata7.00: disabled [ 3011.324021] ata7: hard resetting link [ 3012.044038] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 370) [ 3012.048607] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9 [ 3012.052909] ahci 0000:02:00.0: FBS is enabled.
[ 3012.057467] ata7.00: hard resetting link [ 3012.376255] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320) [ 3012.380560] ata7.01: hard resetting link [ 3012.704248] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300) [ 3012.708580] ata7.02: hard resetting link [ 3013.032247] ata7.02: SATA link down (SStatus 0 SControl 320) [ 3013.036615] ata7.03: hard resetting link [ 3013.360248] ata7.03: SATA link down (SStatus 0 SControl 320) [ 3013.364635] ata7.04: hard resetting link [ 3013.688246] ata7.04: SATA link down (SStatus 0 SControl 320) [ 3013.692689] ata7.05: hard resetting link [ 3014.016194] ata7.05: failed to write SCR 1 (Emask=0x1) [ 3014.020635] ata7.05: SATA link down (SStatus 0 SControl 0) [ 3014.026285] ata7.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[ 3014.030646] ata7.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA [ 3014.036430] ata7.00: configured for UDMA/133 [ 3014.042023] ata7.01: native sectors (2) is smaller than sectors
(3907029168)
[ 3014.046718] ata7.01: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[ 3014.051279] ata7.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA [ 3014.057159] ata7.01: configured for UDMA/133 [ 3014.059537] ata7.01: device reported invalid CHS sector 0 [ 3014.061890] ata7.00: device reported invalid CHS sector 0 [ 3014.064203] ata7.01: device reported invalid CHS sector 0 [ 3014.066474] ata7.00: device reported invalid CHS sector 0 [ 3014.068733] sd 6:1:0:0: [sdc]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 3014.071007] sd 6:1:0:0: [sdc]  Sense Key : Aborted Command [current] [descriptor] [ 3014.073291] Descriptor sense data with sense descriptors (in hex):
[ 3014.075562]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 3014.077904]         00 00 00 00
[ 3014.080183] sd 6:1:0:0: [sdc]  Add. Sense: No additional sense information [ 3014.082476] sd 6:1:0:0: [sdc] CDB: Read(10): 28 00 00 00 04 00 00 01 00 00 [ 3014.084797] end_request: I/O error, dev sdc, sector 1024 [ 3014.087077] quiet_error: 118 callbacks suppressed [ 3014.089320] Buffer I/O error on device sdc, logical block 128 [ 3014.091593] Buffer I/O error on device sdc, logical block 129 [ 3014.093817] Buffer I/O error on device sdc, logical block 130 [ 3014.096015] Buffer I/O error on device sdc, logical block 131 [ 3014.098167] Buffer I/O error on device sdc, logical block 132 [ 3014.100286] Buffer I/O error on device sdc, logical block 133 [ 3014.102402] Buffer I/O error on device sdc, logical block 134 [ 3014.104521] Buffer I/O error on device sdc, logical block 135 [ 3014.1066
 38] Buffer I/O error on device sdc, logical block 136 [ 3014.108721] Buffer I/O error on device sdc, logical block 137 [ 3014.110792] sd 6:0:0:0: [sdb]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 3014.112877] sd 6:0:0:0: [sdb]  Sense Key : Aborted Command [current] [descriptor] [ 3014.114966] Descriptor sense data with sense descriptors (in hex):
[ 3014.117053]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 3014.119211]         00 00 00 00
[ 3014.121313] sd 6:0:0:0: [sdb]  Add. Sense: No additional sense information [ 3014.123421] sd 6:0:0:0: [sdb] CDB: Read(10): 28 00 00 00 18 00 00 01 00 00 [ 3014.125605] end_request: I/O error, dev sdb, sector 6144 [ 3014.127754] sd 6:1:0:0: [sdc]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 3014.129913] sd 6:1:0:0: [sdc]  Sense Key : Aborted Command [current] [descriptor] [ 3014.132067] Descriptor sense data with sense descriptors (in hex):
[ 3014.134199]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 3014.136423]         00 00 00 00
[ 3014.138587] sd 6:1:0:0: [sdc]  Add. Sense: No additional sense information [ 3014.140791] sd 6:1:0:0: [sdc] CDB: Read(10): 28 00 00 00 05 00 00 01 00 00 [ 3014.143051] end_request: I/O error, dev sdc, sector 1280 [ 3014.145323] sd 6:0:0:0: [sdb]  Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE [ 3014.147615] sd 6:0:0:0: [sdb]  Sense Key : Aborted Command [current] [descriptor] [ 3014.149897] Descriptor sense data with sense descriptors (in hex):
[ 3014.152156]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[ 3014.154478]         00 00 00 00
[ 3014.156758] sd 6:0:0:0: [sdb]  Add. Sense: No additional sense information [ 3014.159056] sd 6:0:0:0: [sdb] CDB: Read(10): 28 00 00 00 19 00 00 01 00 00 [ 3014.161406] end_request: I/O error, dev sdb, sector 6400 [ 3014.163703] ata7: EH complete [ 3014.165979] ata7.00: detaching (SCSI 6:0:0:0) [ 3014.168308] sd 6:0:0:0: rejecting I/O to offline device [ 3014.177610] sd 6:0:0:0: [sdb] Synchronizing SCSI cache [ 3014.179969] sd 6:0:0:0: [sdb] Stopping disk [ 3014.791747] ata7.01: detaching (SCSI 6:1:0:0) [ 3014.799621] sd 6:1:0:0: [sdc] Synchronizing SCSI cache [ 3014.804160] sd 6:1:0:0: [sdc] Stopping disk
[ 3015.419701] scsi 6:0:0:0: Direct-Access     ATA      Hitachi HDS5C302
ML6O PQ: 0 ANSI: 5
[ 3015.425355] sd 6:0:0:0: [sdb] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[ 3015.429980] sd 6:0:0:0: [sdb] Write Protect is off [ 3015.434322] sd 6:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3015.435019] scsi 6:1:0:0: Direct-Access     ATA      Hitachi HDS5C302
ML6O PQ: 0 ANSI: 5
[ 3015.440304] sd 6:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 3015.445835] sd 6:1:0:0: [sdc] 3907029168 512-byte logical blocks:
(2.00 TB/1.81 TiB)
[ 3015.450897] sd 6:1:0:0: [sdc] Write Protect is off [ 3015.455341] sd 6:1:0:0: [sdc] Mode Sense: 00 3a 00 00 [ 3015.456615] sd 6:1:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[ 3017.371727]  sdc: sdc1
[ 3017.377835] sd 6:1:0:0: [sdc] Attached SCSI disk [ 3018.219239]  sdb: sdb1 [ 3018.225421] sd 6:0:0:0: [sdb] Attached SCSI disk

... and the drives have this smartctl output:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0009  2           56  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           35  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0009  2            9  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2            5  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS



--
South East Open Source Solutions Limited Registered in England and Wales with company number 06134732.
Registered Office: 2 Powell Gardens, Redhill, Surrey, RH1 1TQ VAT number: 900 6633 53  http://seoss.co.uk/ +44-(0)1273-808309


-----
No virus found in this message.
Checked by AVG - www.avg.com
Version: 10.0.1388 / Virus Database: 1516/3750 - Release Date: 07/07/11
