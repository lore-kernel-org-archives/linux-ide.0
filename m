From: Tim Small <tim@seoss.co.uk>
Subject: Re: SiI 3726 pmp doesn't work with 2.6.38 and Marvell 88SE9123 AHCI
 controller
Date: Thu, 07 Jul 2011 19:43:39 +0100
Message-ID: <4E15FE5B.3000405@seoss.co.uk>
References: <4DEE6831.9020501@seoss.co.uk> <20110609143755.GA2615@htj.dyndns.org> <4DF136FF.2010404@seoss.co.uk> <20110610102403.GE15235@htj.dyndns.org> <4DF249BB.3040808@seoss.co.uk> <4E14C6ED.5040208@buttersideup.com> <4E15A2F1.7080106@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay0.allsecurenet.com ([109.169.27.60]:54335 "EHLO
	relay0.allsecurenet.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab1GGSnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Jul 2011 14:43:41 -0400
Received: from [78.105.152.189] (helo=zebedee.buttersideup.com)
	by relay0.allsecurenet.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <tim@seoss.co.uk>)
	id 1QetY4-00070L-HY
	for linux-ide@vger.kernel.org; Thu, 07 Jul 2011 19:43:40 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by zebedee.buttersideup.com (Postfix) with ESMTP id F0EAF415B8
	for <linux-ide@vger.kernel.org>; Thu,  7 Jul 2011 19:43:39 +0100 (BST)
In-Reply-To: <4E15A2F1.7080106@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Sorry - I accidentally sent this from the wrong email address, which I
think kept it from reaching the list.

On 07/07/11 13:13, Tim Small wrote:
> 2x 2G Hitachi drives connected via a SiI 3726, and to the 88SE9125 card
> ( Debian 6.0  2.6.32 NCQ depth 31  - same with any value between 2 and
> 31 ) - works for simultaneous reads with hdparm - read speeds at 31M per
> second on both drives.  Reads from a single drive at between 19M per
> second and 130M per second with NCQ depth = 31 (most often 130M), but
> reads from a single drive with NCQ depth = 2 varied between 5M per
> second and 54M per second.  Reads from a single drive (direct to host,
> not via PMP) at 130M per second (127M per second with depth = 2).
>   

In the same machine, but with 2.6.38 (debian squeeze backports kernel):

NCQ 31, two drives connected to 3726 behind the **88SE9125** :

root@netboot:~# hdparm -t /dev/sdb

/dev/sdb:
 Timing buffered disk reads: 386 MB in  3.00 seconds = 128.59 MB/sec
root@netboot:~# hdparm -t /dev/sdc

/dev/sdc:
 Timing buffered disk reads:  38 MB in  7.01 seconds =   5.42 MB/sec
root@netboot:~# hdparm -t /dev/sdc

/dev/sdc:
 Timing buffered disk reads: read(2097152) returned 823296 bytes
BLKFLSBUF failed: No such device

This coincides with the following dmesg:

[  102.880043] ata3.00: failed to read SCR 1 (Emask=0x40)
[  102.884798] ata3.01: failed to read SCR 1 (Emask=0x40)
[  102.889604] ata3.02: failed to read SCR 1 (Emask=0x40)
[  102.894352] ata3.03: failed to read SCR 1 (Emask=0x40)
[  102.899057] ata3.04: failed to read SCR 1 (Emask=0x40)
[  102.903730] ata3.05: failed to read SCR 1 (Emask=0x40)
[  102.908365] ata3.15: exception Emask 0x4 SAct 0x0 SErr 0x400000
action 0x6 frozen
[  102.913067] ata3.15: SError: { Handshk }
[  102.917727] ata3.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  102.922460] ata3.01: exception Emask 0x100 SAct 0x7 SErr 0x0 action
0x6 frozen
[  102.927107] ata3.01: failed command: READ FPDMA QUEUED
[  102.931757] ata3.01: cmd 60/98:00:00:47:02/00:00:00:00:00/40 tag 0
ncq 77824 in
[  102.931761]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  102.941055] ata3.01: status: { DRDY }
[  102.945643] ata3.01: failed command: READ FPDMA QUEUED
[  102.950234] ata3.01: cmd 60/68:08:98:47:02/00:00:00:00:00/40 tag 1
ncq 53248 in
[  102.950238]          res 40/00:01:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  102.959550] ata3.01: status: { DRDY }
[  102.964223] ata3.01: failed command: READ FPDMA QUEUED
[  102.968945] ata3.01: cmd 60/b8:10:48:46:02/00:00:00:00:00/40 tag 2
ncq 94208 in
[  102.968949]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
0x4 (timeout)
[  102.978510] ata3.01: status: { DRDY }
[  102.983270] ata3.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  102.988128] ata3.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  102.992942] ata3.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  102.997719] ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  103.002468] ata3.15: hard resetting link
[  103.720029] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[  103.725058] ata3.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[  103.729797] ata3.15: PMP revalidation failed (errno=-19)
[  108.724032] ata3.15: hard resetting link
[  109.444033] ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[  109.448924] ata3.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[  109.453679] ata3.15: PMP revalidation failed (errno=-19)
[  109.458399] ata3.15: limiting SATA link speed to 1.5 Gbps
[  114.448029] ata3.15: hard resetting link
[  115.168034] ata3.15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  115.173007] ata3.15: Port Multiplier vendor mismatch '0x1095' != '0x0'
[  115.177781] ata3.15: PMP revalidation failed (errno=-19)
[  115.182541] ata3.15: failed to recover PMP after 5 tries, giving up
[  115.187291] ata3.15: Port Multiplier detaching
[  115.191959] ata3.00: disabled
[  115.196572] ata3.01: disabled
[  115.201115] ata3.00: disabled
[  120.172024] ata3: hard resetting link
[  120.892037] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
[  120.896695] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x1/0x9
[  120.901169] ahci 0000:01:00.0: FBS is enabled.
[  120.905800] ata3.00: hard resetting link
[  121.228222] ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  121.232855] ata3.01: hard resetting link
[  121.556224] ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  121.560862] ata3.02: hard resetting link
[  121.884223] ata3.02: SATA link down (SStatus 0 SControl 320)
[  121.888866] ata3.03: hard resetting link
[  122.212222] ata3.03: SATA link down (SStatus 0 SControl 320)
[  122.216721] ata3.04: hard resetting link
[  122.540221] ata3.04: SATA link down (SStatus 0 SControl 320)
[  122.544633] ata3.05: hard resetting link
[  122.868232] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[  122.873827] ata3.00: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[  122.878067] ata3.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
[  122.883669] ata3.00: configured for UDMA/133
[  122.889185] ata3.01: ATA-8: Hitachi HDS5C3020ALA632, ML6OA580, max
UDMA/133
[  122.893487] ata3.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth
31/32), AA
[  122.899114] ata3.01: configured for UDMA/133
[  122.903547] ata3.01: device reported invalid CHS sector 0
[  122.907930] ata3.01: device reported invalid CHS sector 0
[  122.912322] ata3.01: device reported invalid CHS sector 0
[  122.916715] sd 1:1:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[  122.921135] sd 1:1:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
[  122.925558] Descriptor sense data with sense descriptors (in hex):
[  122.929959]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[  122.934528]         00 00 00 00
[  122.938953] sd 1:1:0:0: [sdc]  Add. Sense: No additional sense
information
[  122.943428] sd 1:1:0:0: [sdc] CDB: Read(10): 28 00 00 02 47 00 00 00
98 00
[  122.947984] end_request: I/O error, dev sdc, sector 149248
[  122.952425] Buffer I/O error on device sdc, logical block 18656
[  122.956888] Buffer I/O error on device sdc, logical block 18657
[  122.961268] Buffer I/O error on device sdc, logical block 18658
[  122.965594] Buffer I/O error on device sdc, logical block 18659
[  122.969830] Buffer I/O error on device sdc, logical block 18660
[  122.974033] Buffer I/O error on device sdc, logical block 18661
[  122.978172] Buffer I/O error on device sdc, logical block 18662
[  122.982256] Buffer I/O error on device sdc, logical block 18663
[  122.986239] Buffer I/O error on device sdc, logical block 18664
[  122.990165] Buffer I/O error on device sdc, logical block 18665
[  122.994116] sd 1:1:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[  122.998160] sd 1:1:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
[  123.002283] Descriptor sense data with sense descriptors (in hex):
[  123.006370]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[  123.010586]         00 00 00 00
[  123.014657] sd 1:1:0:0: [sdc]  Add. Sense: No additional sense
information
[  123.018792] sd 1:1:0:0: [sdc] CDB: Read(10): 28 00 00 02 47 98 00 00
68 00
[  123.023005] end_request: I/O error, dev sdc, sector 149400
[  123.027149] sd 1:1:0:0: [sdc]  Result: hostbyte=DID_OK
driverbyte=DRIVER_SENSE
[  123.031332] sd 1:1:0:0: [sdc]  Sense Key : Aborted Command [current]
[descriptor]
[  123.035531] Descriptor sense data with sense descriptors (in hex):
[  123.039728]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00
[  123.044071]         00 00 00 00
[  123.048263] sd 1:1:0:0: [sdc]  Add. Sense: No additional sense
information
[  123.052512] sd 1:1:0:0: [sdc] CDB: Read(10): 28 00 00 02 46 48 00 00
b8 00
[  123.056830] end_request: I/O error, dev sdc, sector 149064
[  123.061084] ata3: EH complete
[  123.065640] ata3.00: detaching (SCSI 1:0:0:0)
[  123.068043] sd 1:1:0:0: rejecting I/O to offline device
[  123.075042] sd 1:0:0:0: [sdb] Synchronizing SCSI cache
[  123.077512] sd 1:0:0:0: [sdb] Stopping disk
[  123.082745] sd 1:1:0:0: rejecting I/O to offline device
[  123.084984] end_request: I/O error, dev sdc, sector 0
[  123.087925] sd 1:1:0:0: rejecting I/O to offline device
[  123.090124] end_request: I/O error, dev sdc, sector 0
[  123.694656] ata3.01: detaching (SCSI 1:1:0:0)
[  123.703452] sd 1:1:0:0: [sdc] Synchronizing SCSI cache
[  123.707890] sd 1:1:0:0: [sdc] Stopping disk


After reset - set NCQ depth to 1:


root@netboot:~# find /sys  -name queue_depth -print0 | xargs -0 -i sh -c
"echo -n {}: ; echo 1 > {} ; cat {}"
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host1/target1:0:0/1:0:0:0/queue_depth:1
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host1/target1:1:0/1:1:0:0/queue_depth:1
root@netboot:~# hdparm -t /dev/sdc

/dev/sdc:
 Timing buffered disk reads: 380 MB in  3.01 seconds = 126.06 MB/sec
root@netboot:~# hdparm -t /dev/sdc

/dev/sdc:
 Timing buffered disk reads: 384 MB in  3.01 seconds = 127.47 MB/sec
root@netboot:~# while true ; do hdparm -t /dev/sdb ; done

/dev/sdb:
 Timing buffered disk reads: 388 MB in  3.01 seconds = 129.03 MB/sec

/dev/sdb:
 Timing buffered disk reads: 394 MB in  3.01 seconds = 130.80 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.57 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.40 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.46 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.39 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.43 MB/sec

/dev/sdb:
 Timing buffered disk reads: 394 MB in  3.01 seconds = 130.80 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.60 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.42 MB/sec

/dev/sdb:
^C

[set NCQ back to 31:]
root@netboot:~# find /sys  -name queue_depth -print0 | xargs -0 -i sh -c
"echo -n {}: ; echo 31 > {} ; cat {}"
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host1/target1:0:0/1:0:0:0/queue_depth:31
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host1/target1:1:0/1:1:0:0/queue_depth:31

root@netboot:~# while true ; do hdparm -t /dev/sdb ; done

/dev/sdb:
 Timing buffered disk reads: 328 MB in  3.55 seconds =  92.29 MB/sec

/dev/sdb:
 Timing buffered disk reads: 204 MB in  5.30 seconds =  38.48 MB/sec

/dev/sdb:
 Timing buffered disk reads: 376 MB in  3.01 seconds = 124.78 MB/sec

/dev/sdb:
 Timing buffered disk reads: 200 MB in  3.01 seconds =  66.53 MB/sec

/dev/sdb:
 Timing buffered disk reads: 276 MB in  3.01 seconds =  91.68 MB/sec

/dev/sdb:
 Timing buffered disk reads: 154 MB in  3.36 seconds =  45.81 MB/sec

/dev/sdb:
 Timing buffered disk reads: 384 MB in  3.01 seconds = 127.45 MB/sec

/dev/sdb:
 Timing buffered disk reads: 358 MB in  3.01 seconds = 119.03 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.65 MB/sec

/dev/sdb:
 Timing buffered disk reads: 364 MB in  4.33 seconds =  84.11 MB/sec

/dev/sdb:
 Timing buffered disk reads: 188 MB in  3.01 seconds =  62.44 MB/sec

/dev/sdb:
 Timing buffered disk reads: 342 MB in  3.01 seconds = 113.47 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.01 seconds = 130.39 MB/sec

/dev/sdb:
 Timing buffered disk reads: 394 MB in  3.01 seconds = 130.76 MB/sec

/dev/sdb:
 Timing buffered disk reads: 274 MB in  3.91 seconds =  70.16 MB/sec

/dev/sdb:
 Timing buffered disk reads: 392 MB in  3.00 seconds = 130.50 MB/sec


Now it seems to work (no more resets), but performance does wander down
to 45MB/sec

For simultaneous reads for two drives behind an 3726 pmp on the 88SE9125
and NCQ=1 using 2.6.38:

root@netboot:~# while true ; do sh -c "(hdparm -t /dev/sdb & hdparm -t
/dev/sdc) 2>&1 | grep MB" ; done
 Timing buffered disk reads: 280 MB in  3.01 seconds =  93.05 MB/sec
280 MB in  3.01 seconds =  93.12 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.45 MB/sec
284 MB in  3.02 seconds =  94.11 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.39 MB/sec
284 MB in  3.02 seconds =  94.12 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.28 MB/sec
284 MB in  3.02 seconds =  94.07 MB/sec
 Timing buffered disk reads: 284 MB in  3.02 seconds =  94.19 MB/sec
284 MB in  3.02 seconds =  94.06 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.32 MB/sec
284 MB in  3.02 seconds =  94.18 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.24 MB/sec
284 MB in  3.01 seconds =  94.24 MB/sec
 Timing buffered disk reads: 284 MB in  3.02 seconds =  94.17 MB/sec
284 MB in  3.01 seconds =  94.28 MB/sec
 Timing buffered disk reads: 284 MB in  3.02 seconds =  94.10 MB/sec
284 MB in  3.02 seconds =  94.08 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.31 MB/sec
284 MB in  3.01 seconds =  94.21 MB/sec
 Timing buffered disk reads: 284 MB in  3.02 seconds =  94.05 MB/sec
284 MB in  3.02 seconds =  94.12 MB/sec
 Timing buffered disk reads: 284 MB in  3.01 seconds =  94.23 MB/sec
284 MB in  3.01 seconds =  94.24 MB/sec


... so faster than 2.6.32, and consistent.  For NCQ=31:



root@netboot:~# while true ; do sh -c "(hdparm -t /dev/sdb & hdparm -t
/dev/sdc) 2>&1 | grep MB" ; done
 Timing buffered disk reads: 276 MB in  3.02 seconds =  91.37 MB/sec
276 MB in  3.02 seconds =  91.52 MB/sec
 Timing buffered disk reads: 278 MB in  3.01 seconds =  92.31 MB/sec
278 MB in  3.01 seconds =  92.46 MB/sec
 Timing buffered disk reads: 268 MB in  3.00 seconds =  89.31 MB/sec
268 MB in  3.00 seconds =  89.32 MB/sec
 Timing buffered disk reads: 278 MB in  3.00 seconds =  92.61 MB/sec
278 MB in  3.01 seconds =  92.31 MB/sec
 Timing buffered disk reads: 194 MB in  3.02 seconds =  64.27 MB/sec
194 MB in  3.02 seconds =  64.24 MB/sec
 Timing buffered disk reads: 260 MB in  3.00 seconds =  86.55 MB/sec
260 MB in  3.00 seconds =  86.61 MB/sec
 Timing buffered disk reads: 278 MB in  3.01 seconds =  92.36 MB/sec
278 MB in  3.02 seconds =  92.20 MB/sec
 Timing buffered disk reads: 248 MB in  3.02 seconds =  82.23 MB/sec
248 MB in  3.01 seconds =  82.39 MB/sec
 Timing buffered disk reads: 268 MB in  3.00 seconds =  89.21 MB/sec
268 MB in  3.01 seconds =  89.09 MB/sec
 Timing buffered disk reads: 278 MB in  3.01 seconds =  92.44 MB/sec
278 MB in  3.01 seconds =  92.45 MB/sec
 Timing buffered disk reads: 280 MB in  3.02 seconds =  92.83 MB/sec
280 MB in  3.02 seconds =  92.61 MB/sec
 Timing buffered disk reads: 274 MB in  3.02 seconds =  90.77 MB/sec
274 MB in  3.02 seconds =  90.81 MB/sec



... a little slower, and with some strange performance dips (e.g. the
65M figure).

After all this, I tried a "smartctl -x /dev/sd[bc]" and got this for sdb:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0009  2           26  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2           14  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS

and this for sdc:

SATA Phy Event Counters (GP Log 0x11)
ID      Size     Value  Description
0x0001  2            0  Command failed due to ICRC error
0x0002  2            0  R_ERR response for data FIS
0x0003  2            0  R_ERR response for device-to-host data FIS
0x0004  2            0  R_ERR response for host-to-device data FIS
0x0005  2            0  R_ERR response for non-data FIS
0x0006  2            0  R_ERR response for device-to-host non-data FIS
0x0007  2            0  R_ERR response for host-to-device non-data FIS
0x0009  2            3  Transition from drive PhyRdy to drive PhyNRdy
0x000a  2            2  Device-to-host register FISes sent due to a COMRESET
0x000b  2            0  CRC errors within host-to-device FIS
0x000d  2            0  Non-CRC errors within host-to-device FIS



Tim.
