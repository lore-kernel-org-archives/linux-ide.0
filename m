From: Brad Campbell <brad@wasp.net.au>
Subject: 2.6.16 sata related oops..
Date: Tue, 18 Apr 2006 14:17:51 +0400
Message-ID: <4444BCCF.2070206@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:42378 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1750987AbWDRKQr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Apr 2006 06:16:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Yes, this is tainted. It's tainted by the qemu kqemu module.
I'm posting it anyway as it's as rare as rocking horse excrement and I'm not likely to see another 
one..

Unfortunately it's from syslog, but I'll chop out all the cron and other noise..
Since I upgraded from 2.6.10-git10 to 2.6.16 I've been seeing ata timeouts related to smart polling 
that never used to be there.. this one this morning looks like it pushed something over the edge..

This is a vanilla 2.6.16 kernel with no patches applied.

I kinda stuck with 2.6.10-git10 previously as it tended to handle sata errors gracefully and not 
oops.. it would just drop the drive out of the raid and I could always re-add it by hand.
I moved to 2.6.16 as md now has decent error handlers and won't boot a drive unless its quite sick. 
But 2.6.16 appears to have "issues" with handling ata errors..
I've had this (or similar) before on a 2.6.15 kernel but the oops never made it to disk. I'll make 
sure I'm not tainting the kernel and hammer it to see if I can reproduce it, but ata errors tend to 
be hard to reproduce on this machine.

For reference the drive that failed is a 250GB WD on a sata->pata bridge sitting on the on-board VIA 
controller of my Asus A7V600 board. This is the one that tends to give the most trouble and I'll be 
upgrading it to a native SATA drive as soon as I can. But I do get errors on ata11 and ata12 
(ata11-13 are a single raid-5 that sees quite heavy use 24/7, while ata1-10 are another raid-5 that 
sees almost no writes and very few reads)

[42949384.820000] sata_via 0000:00:0f.0: version 1.1
[42949384.820000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 16
[42949384.840000] sata_via 0000:00:0f.0: routed to hard irq line 0
[42949384.860000] ata13: SATA max UDMA/133 cmd 0x8400 ctl 0x8002 bmdma 0x7000 irq 16
[42949384.880000] ata14: SATA max UDMA/133 cmd 0x7800 ctl 0x7402 bmdma 0x7008 irq 16
[42949385.110000] ata13: SATA link up 1.5 Gbps (SStatus 113)
[42949385.300000] ata13: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:003f
[42949385.300000] ata13: dev 0 ATA-6, max UDMA/100, 488397168 sectors: LBA48
[42949385.320000] ata13(0): applying bridge limits
[42949385.330000] ata13: dev 0 configured for UDMA/100
[42949385.340000] scsi12 : sata_via
[42949385.560000] ata14: SATA link down (SStatus 0)
[42949385.570000] scsi13 : sata_via
[42949385.580000]   Vendor: ATA       Model: WDC WD2500BB-00D  Rev: 15.0
[42949385.600000]   Type:   Direct-Access                      ANSI SCSI revision: 05

brad@srv:~$ dmesg | head
[42949372.960000] Linux version 2.6.16 (brad@srv) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #2 Sat Mar 
25 15:51:12 GST 2006

Apr 18 08:22:03 srv smartd[3185]: Device: /dev/hda, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 111 to 121
Apr 18 08:22:03 srv smartd[3185]: Device: /dev/hda, SMART Prefailure Attribute: 7 Seek_Error_Rate 
changed from 200 to 100
Apr 18 08:22:03 srv smartd[3185]: Device: /dev/hda, SMART Usage Attribute: 194 Temperature_Celsius 
changed from 118 to 120
Apr 18 08:22:03 srv smartd[3185]: Device: /dev/sda, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 194 to 195
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdb, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 177 to 178
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdb, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 194 to 197
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdc, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 175 to 176
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdc, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 192 to 194
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdd, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 174 to 175
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdd, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 195 to 197
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sde, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 177 to 178
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sde, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 195 to 197
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdf, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 176 to 177
Apr 18 08:22:04 srv smartd[3185]: Device: /dev/sdf, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 194 to 195
Apr 18 08:22:05 srv smartd[3185]: Device: /dev/sdg, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 175 to 176
Apr 18 08:22:05 srv smartd[3185]: Device: /dev/sdh, SMART Prefailure Attribute: 3 Spin_Up_Time 
changed from 175 to 176
Apr 18 08:22:05 srv smartd[3185]: Device: /dev/sdh, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 195 to 194
Apr 18 08:22:05 srv smartd[3185]: Device: /dev/sdi, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 195 to 194
Apr 18 08:22:05 srv smartd[3185]: Device: /dev/sdj, SMART Usage Attribute: 209 
Offline_Seek_Performnce changed from 196 to 197
Apr 18 08:22:07 srv kernel: [44994237.470000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:22:07 srv kernel: [44994237.470000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:22:07 srv kernel: [44994237.470000] ata13: status=0xd0 { Busy }
Apr 18 08:22:07 srv kernel: [44994237.470000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:22:07 srv kernel: [44994237.470000] sdm: Current: sense key: Aborted Command
Apr 18 08:22:07 srv kernel: [44994237.470000]     Additional sense: Scsi parity error
Apr 18 08:22:07 srv kernel: [44994237.470000] end_request: I/O error, dev sdm, sector 413086248
Apr 18 08:22:07 srv kernel: [44994237.590000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:22:07 srv last message repeated 2 times
Apr 18 08:22:37 srv kernel: [44994267.590000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:22:37 srv kernel: [44994267.590000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:22:37 srv kernel: [44994267.590000] ata13: status=0xd0 { Busy }
Apr 18 08:22:37 srv kernel: [44994267.590000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:22:37 srv kernel: [44994267.590000] sdm: Current: sense key: Aborted Command
Apr 18 08:22:37 srv kernel: [44994267.590000]     Additional sense: Scsi parity error
Apr 18 08:22:37 srv kernel: [44994267.590000] end_request: I/O error, dev sdm, sector 413086256
Apr 18 08:22:37 srv kernel: [44994267.710000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:22:37 srv last message repeated 2 times
Apr 18 08:23:08 srv kernel: [44994297.710000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:23:08 srv kernel: [44994297.710000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:23:08 srv kernel: [44994297.710000] ata13: status=0xd0 { Busy }
Apr 18 08:23:08 srv kernel: [44994297.710000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:23:08 srv kernel: [44994297.710000] sdm: Current: sense key: Aborted Command
Apr 18 08:23:08 srv kernel: [44994297.710000]     Additional sense: Scsi parity error
Apr 18 08:23:08 srv kernel: [44994297.710000] end_request: I/O error, dev sdm, sector 413086264
Apr 18 08:23:08 srv kernel: [44994297.830000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:23:08 srv last message repeated 2 times
Apr 18 08:23:38 srv kernel: [44994327.830000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:23:38 srv kernel: [44994327.830000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:23:38 srv kernel: [44994327.830000] ata13: status=0xd0 { Busy }
Apr 18 08:23:38 srv kernel: [44994327.830000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:23:38 srv kernel: [44994327.830000] sdm: Current: sense key: Aborted Command
Apr 18 08:23:38 srv kernel: [44994327.830000]     Additional sense: Scsi parity error
Apr 18 08:23:38 srv kernel: [44994327.830000] end_request: I/O error, dev sdm, sector 413086272
Apr 18 08:23:38 srv kernel: [44994327.950000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:23:38 srv last message repeated 2 times
Apr 18 08:24:08 srv kernel: [44994357.950000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:24:08 srv kernel: [44994357.950000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:24:08 srv kernel: [44994357.950000] ata13: status=0xd0 { Busy }
Apr 18 08:24:08 srv kernel: [44994357.950000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:24:08 srv kernel: [44994357.950000] sdm: Current: sense key: Aborted Command
Apr 18 08:24:08 srv kernel: [44994357.950000]     Additional sense: Scsi parity error
Apr 18 08:24:08 srv kernel: [44994357.950000] end_request: I/O error, dev sdm, sector 413086280
Apr 18 08:24:08 srv kernel: [44994358.070000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:24:08 srv last message repeated 2 times
Apr 18 08:24:38 srv kernel: [44994388.070000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:24:38 srv kernel: [44994388.070000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:24:38 srv kernel: [44994388.070000] ata13: status=0xd0 { Busy }
Apr 18 08:24:38 srv kernel: [44994388.070000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:24:38 srv kernel: [44994388.070000] sdm: Current: sense key: Aborted Command
Apr 18 08:24:38 srv kernel: [44994388.070000]     Additional sense: Scsi parity error
Apr 18 08:24:38 srv kernel: [44994388.070000] end_request: I/O error, dev sdm, sector 413086288
Apr 18 08:24:38 srv kernel: [44994388.190000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:24:38 srv last message repeated 2 times
Apr 18 08:25:08 srv kernel: [44994418.190000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:25:08 srv kernel: [44994418.190000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:25:08 srv kernel: [44994418.190000] ata13: status=0xd0 { Busy }
Apr 18 08:25:08 srv kernel: [44994418.190000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:25:08 srv kernel: [44994418.190000] sdm: Current: sense key: Aborted Command
Apr 18 08:25:08 srv kernel: [44994418.190000]     Additional sense: Scsi parity error
Apr 18 08:25:08 srv kernel: [44994418.190000] end_request: I/O error, dev sdm, sector 413086296
Apr 18 08:25:08 srv kernel: [44994418.310000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:25:08 srv last message repeated 2 times
Apr 18 08:25:38 srv kernel: [44994448.310000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:25:38 srv kernel: [44994448.310000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:25:38 srv kernel: [44994448.310000] ata13: status=0xd0 { Busy }
Apr 18 08:25:38 srv kernel: [44994448.310000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:25:38 srv kernel: [44994448.310000] sdm: Current: sense key: Aborted Command
Apr 18 08:25:38 srv kernel: [44994448.310000]     Additional sense: Scsi parity error
Apr 18 08:25:38 srv kernel: [44994448.310000] end_request: I/O error, dev sdm, sector 413086304
Apr 18 08:25:38 srv kernel: [44994448.430000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:25:38 srv last message repeated 2 times
Apr 18 08:26:08 srv kernel: [44994478.430000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:26:08 srv kernel: [44994478.430000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:26:08 srv kernel: [44994478.430000] ata13: status=0xd0 { Busy }
Apr 18 08:26:08 srv kernel: [44994478.430000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:26:08 srv kernel: [44994478.430000] sdm: Current: sense key: Aborted Command
Apr 18 08:26:08 srv kernel: [44994478.430000]     Additional sense: Scsi parity error
Apr 18 08:26:08 srv kernel: [44994478.430000] end_request: I/O error, dev sdm, sector 413086312
Apr 18 08:26:08 srv kernel: [44994478.550000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:26:08 srv last message repeated 2 times
Apr 18 08:26:38 srv kernel: [44994508.550000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:26:38 srv kernel: [44994508.550000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:26:38 srv kernel: [44994508.550000] ata13: status=0xd0 { Busy }
Apr 18 08:26:38 srv kernel: [44994508.550000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:26:38 srv kernel: [44994508.550000] sdm: Current: sense key: Aborted Command
Apr 18 08:26:38 srv kernel: [44994508.550000]     Additional sense: Scsi parity error
Apr 18 08:26:38 srv kernel: [44994508.550000] end_request: I/O error, dev sdm, sector 413086320
Apr 18 08:26:38 srv kernel: [44994508.670000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:26:38 srv last message repeated 2 times
Apr 18 08:27:09 srv kernel: [44994538.670000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:27:09 srv kernel: [44994538.670000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:27:09 srv kernel: [44994538.670000] ata13: status=0xd0 { Busy }
Apr 18 08:27:09 srv kernel: [44994538.670000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:27:09 srv kernel: [44994538.670000] sdm: Current: sense key: Aborted Command
Apr 18 08:27:09 srv kernel: [44994538.670000]     Additional sense: Scsi parity error
Apr 18 08:27:09 srv kernel: [44994538.670000] end_request: I/O error, dev sdm, sector 413086328
Apr 18 08:27:09 srv kernel: [44994538.790000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:27:09 srv last message repeated 2 times
Apr 18 08:27:39 srv kernel: [44994568.790000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:27:39 srv kernel: [44994568.790000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:27:39 srv kernel: [44994568.790000] ata13: status=0xd0 { Busy }
Apr 18 08:27:39 srv kernel: [44994568.790000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:27:39 srv kernel: [44994568.790000] sdm: Current: sense key: Aborted Command
Apr 18 08:27:39 srv kernel: [44994568.790000]     Additional sense: Scsi parity error
Apr 18 08:27:39 srv kernel: [44994568.790000] end_request: I/O error, dev sdm, sector 413086336
Apr 18 08:27:39 srv kernel: [44994568.910000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:27:39 srv last message repeated 2 times
Apr 18 08:28:09 srv kernel: [44994598.910000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:28:09 srv kernel: [44994598.910000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:28:09 srv kernel: [44994598.910000] ata13: status=0xd0 { Busy }
Apr 18 08:28:09 srv kernel: [44994598.910000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:28:09 srv kernel: [44994598.910000] sdm: Current: sense key: Aborted Command
Apr 18 08:28:09 srv kernel: [44994598.910000]     Additional sense: Scsi parity error
Apr 18 08:28:09 srv kernel: [44994598.910000] end_request: I/O error, dev sdm, sector 413086344
Apr 18 08:28:09 srv kernel: [44994599.030000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:28:09 srv last message repeated 2 times
Apr 18 08:28:39 srv kernel: [44994629.030000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:28:39 srv kernel: [44994629.030000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:28:39 srv kernel: [44994629.030000] ata13: status=0xd0 { Busy }
Apr 18 08:28:39 srv kernel: [44994629.030000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:28:39 srv kernel: [44994629.030000] sdm: Current: sense key: Aborted Command
Apr 18 08:28:39 srv kernel: [44994629.030000]     Additional sense: Scsi parity error
Apr 18 08:28:39 srv kernel: [44994629.030000] end_request: I/O error, dev sdm, sector 413086352
Apr 18 08:28:39 srv kernel: [44994629.150000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:28:39 srv last message repeated 2 times
Apr 18 08:29:09 srv kernel: [44994659.150000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:29:09 srv kernel: [44994659.150000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:29:09 srv kernel: [44994659.150000] ata13: status=0xd0 { Busy }
Apr 18 08:29:09 srv kernel: [44994659.150000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:29:09 srv kernel: [44994659.150000] sdm: Current: sense key: Aborted Command
Apr 18 08:29:09 srv kernel: [44994659.150000]     Additional sense: Scsi parity error
Apr 18 08:29:09 srv kernel: [44994659.150000] end_request: I/O error, dev sdm, sector 413086360
Apr 18 08:29:09 srv kernel: [44994659.270000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:29:09 srv last message repeated 2 times
Apr 18 08:29:39 srv kernel: [44994689.270000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:29:39 srv kernel: [44994689.270000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:29:39 srv kernel: [44994689.270000] ata13: status=0xd0 { Busy }
Apr 18 08:29:39 srv kernel: [44994689.270000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:29:39 srv kernel: [44994689.270000] sdm: Current: sense key: Aborted Command
Apr 18 08:29:39 srv kernel: [44994689.270000]     Additional sense: Scsi parity error
Apr 18 08:29:39 srv kernel: [44994689.270000] end_request: I/O error, dev sdm, sector 413086368
Apr 18 08:29:39 srv kernel: [44994689.390000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:29:39 srv last message repeated 2 times
Apr 18 08:30:09 srv kernel: [44994719.390000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:30:09 srv kernel: [44994719.390000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:30:09 srv kernel: [44994719.390000] ata13: status=0xd0 { Busy }
Apr 18 08:30:09 srv kernel: [44994719.390000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:30:09 srv kernel: [44994719.390000] sdm: Current: sense key: Aborted Command
Apr 18 08:30:09 srv kernel: [44994719.390000]     Additional sense: Scsi parity error
Apr 18 08:30:09 srv kernel: [44994719.390000] end_request: I/O error, dev sdm, sector 413086376
Apr 18 08:30:09 srv kernel: [44994719.510000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:30:09 srv last message repeated 2 times
Apr 18 08:30:39 srv kernel: [44994749.510000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:30:39 srv kernel: [44994749.510000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:30:39 srv kernel: [44994749.510000] ata13: status=0xd0 { Busy }
Apr 18 08:30:39 srv kernel: [44994749.510000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:30:39 srv kernel: [44994749.510000] sdm: Current: sense key: Aborted Command
Apr 18 08:30:39 srv kernel: [44994749.510000]     Additional sense: Scsi parity error
Apr 18 08:30:39 srv kernel: [44994749.510000] end_request: I/O error, dev sdm, sector 413086384
Apr 18 08:30:39 srv kernel: [44994749.630000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:30:39 srv last message repeated 2 times
Apr 18 08:31:09 srv kernel: [44994779.630000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:31:09 srv kernel: [44994779.630000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:31:09 srv kernel: [44994779.630000] ata13: status=0xd0 { Busy }
Apr 18 08:31:09 srv kernel: [44994779.630000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:31:09 srv kernel: [44994779.630000] sdm: Current: sense key: Aborted Command
Apr 18 08:31:09 srv kernel: [44994779.630000]     Additional sense: Scsi parity error
Apr 18 08:31:09 srv kernel: [44994779.630000] end_request: I/O error, dev sdm, sector 413086392
Apr 18 08:31:09 srv kernel: [44994779.750000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:31:09 srv last message repeated 2 times
Apr 18 08:31:40 srv kernel: [44994809.750000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:31:40 srv kernel: [44994809.750000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:31:40 srv kernel: [44994809.750000] ata13: status=0xd0 { Busy }
Apr 18 08:31:40 srv kernel: [44994809.750000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:31:40 srv kernel: [44994809.750000] sdm: Current: sense key: Aborted Command
Apr 18 08:31:40 srv kernel: [44994809.750000]     Additional sense: Scsi parity error
Apr 18 08:31:40 srv kernel: [44994809.750000] end_request: I/O error, dev sdm, sector 413086400
Apr 18 08:31:40 srv kernel: [44994809.870000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:31:40 srv last message repeated 2 times
Apr 18 08:31:50 srv kernel: [44994819.870000] ata13: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Apr 18 08:31:50 srv kernel: [44994819.870000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:31:50 srv kernel: [44994819.870000] ata13: status=0xd0 { Busy }
Apr 18 08:31:50 srv kernel: [44994819.920000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:31:50 srv last message repeated 2 times
Apr 18 08:31:50 srv smartd[3185]: Device: /dev/sdm, not capable of SMART self-check
Apr 18 08:31:50 srv smartd[3185]: Sending warning via  mail to brad ...
Apr 18 08:31:50 srv smartd[3185]: Warning via mail to brad: successful
Apr 18 08:32:20 srv kernel: [44994849.920000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:32:20 srv kernel: [44994849.920000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:32:20 srv kernel: [44994849.920000] ata13: status=0xd0 { Busy }
Apr 18 08:32:20 srv kernel: [44994849.920000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:32:20 srv kernel: [44994849.920000] sdm: Current: sense key: Aborted Command
Apr 18 08:32:20 srv kernel: [44994849.920000]     Additional sense: Scsi parity error
Apr 18 08:32:20 srv kernel: [44994849.920000] end_request: I/O error, dev sdm, sector 413086408
Apr 18 08:32:20 srv kernel: [44994850.040000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:32:20 srv last message repeated 2 times
Apr 18 08:32:50 srv kernel: [44994880.040000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:32:50 srv kernel: [44994880.040000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:32:50 srv kernel: [44994880.040000] ata13: status=0xd0 { Busy }
Apr 18 08:32:50 srv kernel: [44994880.040000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:32:50 srv kernel: [44994880.040000] sdm: Current: sense key: Aborted Command
Apr 18 08:32:50 srv kernel: [44994880.040000]     Additional sense: Scsi parity error
Apr 18 08:32:50 srv kernel: [44994880.040000] end_request: I/O error, dev sdm, sector 413086416
Apr 18 08:32:50 srv kernel: [44994880.160000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:32:50 srv last message repeated 2 times
Apr 18 08:33:20 srv kernel: [44994910.160000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:33:20 srv kernel: [44994910.160000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:33:20 srv kernel: [44994910.160000] ata13: status=0xd0 { Busy }
Apr 18 08:33:20 srv kernel: [44994910.160000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:33:20 srv kernel: [44994910.160000] sdm: Current: sense key: Aborted Command
Apr 18 08:33:20 srv kernel: [44994910.160000]     Additional sense: Scsi parity error
Apr 18 08:33:20 srv kernel: [44994910.160000] end_request: I/O error, dev sdm, sector 413086424
Apr 18 08:33:20 srv kernel: [44994910.280000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:33:20 srv last message repeated 2 times
Apr 18 08:33:44 srv cucipop[26690]: Invalid command capa - -
Apr 18 08:33:44 srv cucipop[26690]: brad 127.0.0.1 0, 1 (1062), 0 (0)
Apr 18 08:33:50 srv kernel: [44994940.280000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:33:50 srv kernel: [44994940.280000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:33:50 srv kernel: [44994940.280000] ata13: status=0xd0 { Busy }
Apr 18 08:33:50 srv kernel: [44994940.280000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:33:50 srv kernel: [44994940.280000] sdm: Current: sense key: Aborted Command
Apr 18 08:33:50 srv kernel: [44994940.280000]     Additional sense: Scsi parity error
Apr 18 08:33:50 srv kernel: [44994940.280000] end_request: I/O error, dev sdm, sector 413086432
Apr 18 08:33:50 srv kernel: [44994940.400000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:33:50 srv last message repeated 2 times
Apr 18 08:34:20 srv kernel: [44994970.400000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:34:20 srv kernel: [44994970.400000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:34:20 srv kernel: [44994970.400000] ata13: status=0xd0 { Busy }
Apr 18 08:34:20 srv kernel: [44994970.400000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:34:20 srv kernel: [44994970.400000] sdm: Current: sense key: Aborted Command
Apr 18 08:34:20 srv kernel: [44994970.400000]     Additional sense: Scsi parity error
Apr 18 08:34:20 srv kernel: [44994970.400000] end_request: I/O error, dev sdm, sector 413086440
Apr 18 08:34:20 srv kernel: [44994970.520000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:34:20 srv last message repeated 2 times
Apr 18 08:34:50 srv kernel: [44995000.520000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:34:50 srv kernel: [44995000.520000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:34:50 srv kernel: [44995000.520000] ata13: status=0xd0 { Busy }
Apr 18 08:34:50 srv kernel: [44995000.520000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:34:50 srv kernel: [44995000.520000] sdm: Current: sense key: Aborted Command
Apr 18 08:34:50 srv kernel: [44995000.520000]     Additional sense: Scsi parity error
Apr 18 08:34:50 srv kernel: [44995000.520000] end_request: I/O error, dev sdm, sector 413086448
Apr 18 08:34:50 srv kernel: [44995000.640000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:34:50 srv last message repeated 2 times
Apr 18 08:35:20 srv kernel: [44995030.640000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:35:20 srv kernel: [44995030.640000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:35:20 srv kernel: [44995030.640000] ata13: status=0xd0 { Busy }
Apr 18 08:35:20 srv kernel: [44995030.640000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:35:20 srv kernel: [44995030.640000] sdm: Current: sense key: Aborted Command
Apr 18 08:35:20 srv kernel: [44995030.640000]     Additional sense: Scsi parity error
Apr 18 08:35:20 srv kernel: [44995030.640000] end_request: I/O error, dev sdm, sector 413086456
Apr 18 08:35:20 srv kernel: [44995030.760000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:35:20 srv last message repeated 2 times
Apr 18 08:35:51 srv kernel: [44995060.760000] ata13: command 0xea timeout, stat 0xd0 host_stat 0x0
Apr 18 08:35:51 srv kernel: [44995060.760000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:35:51 srv kernel: [44995060.760000] ata13: status=0xd0 { Busy }
Apr 18 08:35:51 srv kernel: [44995060.810000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:35:51 srv last message repeated 2 times
Apr 18 08:36:21 srv kernel: [44995090.810000] ata13: command 0x35 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:36:21 srv kernel: [44995090.810000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:36:21 srv kernel: [44995090.810000] ata13: status=0xd0 { Busy }
Apr 18 08:36:21 srv kernel: [44995090.810000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:36:21 srv kernel: [44995090.810000] sdm: Current: sense key: Aborted Command
Apr 18 08:36:21 srv kernel: [44995090.810000]     Additional sense: Scsi parity error
Apr 18 08:36:21 srv kernel: [44995090.810000] end_request: I/O error, dev sdm, sector 488396928
Apr 18 08:36:21 srv kernel: [44995090.930000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:36:21 srv last message repeated 2 times
Apr 18 08:36:51 srv kernel: [44995120.930000] ata13: command 0xea timeout, stat 0xd0 host_stat 0x0
Apr 18 08:36:51 srv kernel: [44995120.930000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:36:51 srv kernel: [44995120.930000] ata13: status=0xd0 { Busy }
Apr 18 08:36:51 srv kernel: [44995120.930000] raid5: Disk failure on sdm, disabling device. 
Operation continuing on 2 devices
Apr 18 08:36:51 srv kernel: [44995121.010000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:36:51 srv last message repeated 3 times
Apr 18 08:37:01 srv kernel: [44995131.010000] ata13: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Apr 18 08:37:01 srv kernel: [44995131.010000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:37:01 srv kernel: [44995131.010000] ata13: status=0xd0 { Busy }
Apr 18 08:37:01 srv kernel: [44995131.060000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:37:01 srv last message repeated 3 times
Apr 18 08:37:01 srv smartd[3185]: Device: /dev/sdm, failed to read SMART Attribute Data
Apr 18 08:37:01 srv smartd[3185]: Sending warning via  mail to brad ...
Apr 18 08:37:01 srv smartd[3185]: Warning via mail to brad: successful
Apr 18 08:37:21 srv kernel: [44995151.150000] ata13: PIO error
Apr 18 08:37:21 srv kernel: [44995151.160000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:37:21 srv kernel: [44995151.160000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:37:21 srv kernel: [44995151.160000] ata13: status=0xd0 { Busy }
Apr 18 08:37:21 srv kernel: [44995151.220000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:37:21 srv last message repeated 2 times
Apr 18 08:37:51 srv kernel: [44995181.220000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:37:51 srv kernel: [44995181.220000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:37:51 srv kernel: [44995181.220000] ata13: status=0xd0 { Busy }
Apr 18 08:37:51 srv kernel: [44995181.220000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:37:51 srv kernel: [44995181.220000] sdm: Current: sense key: Aborted Command
Apr 18 08:37:51 srv kernel: [44995181.220000]     Additional sense: Scsi parity error
Apr 18 08:37:51 srv kernel: [44995181.220000] end_request: I/O error, dev sdm, sector 196518536
Apr 18 08:37:51 srv kernel: [44995181.220000] raid5: read error not correctable.
Apr 18 08:37:51 srv kernel: [44995181.350000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:37:51 srv last message repeated 3 times
Apr 18 08:38:01 srv kernel: [44995191.350000] ata13: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Apr 18 08:38:01 srv kernel: [44995191.350000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:38:01 srv kernel: [44995191.350000] ata13: status=0xd0 { Busy }
Apr 18 08:38:01 srv kernel: [44995191.400000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:38:01 srv last message repeated 3 times
Apr 18 08:38:01 srv smartd[3185]: Device: /dev/sdm, Read SMART Self Test Log Failed
Apr 18 08:38:01 srv smartd[3185]: Sending warning via  mail to brad ...
Apr 18 08:38:01 srv smartd[3185]: Warning via mail to brad: successful
Apr 18 08:38:21 srv kernel: [44995211.500000] ata13: PIO error
Apr 18 08:38:21 srv kernel: [44995211.500000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:38:21 srv kernel: [44995211.500000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:38:21 srv kernel: [44995211.500000] ata13: status=0xd0 { Busy }
Apr 18 08:38:21 srv kernel: [44995211.570000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:38:21 srv last message repeated 2 times
Apr 18 08:38:52 srv kernel: [44995241.570000] ata13: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 18 08:38:52 srv kernel: [44995241.570000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:38:52 srv kernel: [44995241.570000] ata13: status=0xd0 { Busy }
Apr 18 08:38:52 srv kernel: [44995241.570000] sd 12:0:0:0: SCSI error: return code = 0x8000002
Apr 18 08:38:52 srv kernel: [44995241.570000] sdm: Current: sense key: Aborted Command
Apr 18 08:38:52 srv kernel: [44995241.570000]     Additional sense: Scsi parity error
Apr 18 08:38:52 srv kernel: [44995241.570000] end_request: I/O error, dev sdm, sector 413096312
Apr 18 08:38:52 srv kernel: [44995241.570000] raid5: read error not correctable.
Apr 18 08:38:52 srv kernel: [44995241.700000] ATA: abnormal status 0xD0 on port 0x8407
Apr 18 08:38:52 srv last message repeated 3 times
Apr 18 08:38:52 srv kernel: [44995241.810000] RAID5 conf printout:
Apr 18 08:38:52 srv kernel: [44995241.820000]  --- rd:3 wd:2 fd:1
Apr 18 08:38:52 srv kernel: [44995241.830000]  disk 0, o:1, dev:sdl
Apr 18 08:38:52 srv kernel: [44995241.840000]  disk 1, o:1, dev:sdk
Apr 18 08:38:52 srv kernel: [44995241.850000]  disk 2, o:0, dev:sdm
Apr 18 08:38:52 srv kernel: [44995241.890000] RAID5 conf printout:
Apr 18 08:38:52 srv kernel: [44995241.900000]  --- rd:3 wd:2 fd:1
Apr 18 08:38:52 srv kernel: [44995241.910000]  disk 0, o:1, dev:sdl
Apr 18 08:38:52 srv kernel: [44995241.920000]  disk 1, o:1, dev:sdk
Apr 18 08:39:01 srv kernel: [44995251.700000] ata13: command 0xb0 timeout, stat 0xd0 host_stat 0x0
Apr 18 08:39:01 srv kernel: [44995251.700000] ata13: translated ATA stat/err 0xd0/00 to SCSI 
SK/ASC/ASCQ 0xb/47/00
Apr 18 08:39:01 srv kernel: [44995251.700000] ata13: status=0xd0 { Busy }
Apr 18 08:39:01 srv kernel: [44995251.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:01 srv smartd[3185]: Device: /dev/sdm, Read SMART Error Log Failed
Apr 18 08:39:01 srv smartd[3185]: Sending warning via  mail to brad ...
Apr 18 08:39:01 srv kernel: [44995251.800000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:01 srv kernel: [44995251.840000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995251.880000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995251.920000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995251.960000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.000000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.040000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.080000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.120000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.240000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:02 srv kernel: [44995252.290000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.340000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.380000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.490000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.540000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.640000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.690000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.740000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.780000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.920000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995252.970000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.010000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.050000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.100000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.200000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.250000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.290000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.330000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.370000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.410000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.450000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.490000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.530000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.570000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.610000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv smartd[3185]: Warning via mail to brad: successful
Apr 18 08:39:03 srv kernel: [44995253.660000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.700000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:03 srv kernel: [44995253.740000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995253.810000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995253.860000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995253.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995253.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995253.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:04 srv kernel: [44995254.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995254.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995254.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995254.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995254.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:05 srv kernel: [44995255.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995255.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995255.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995255.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995255.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:06 srv kernel: [44995256.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995256.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995256.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995256.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995256.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:07 srv kernel: [44995257.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995257.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995257.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995257.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995257.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:08 srv kernel: [44995258.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995258.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995258.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995258.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995258.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:09 srv kernel: [44995259.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995259.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995259.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995259.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995259.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:10 srv kernel: [44995260.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995260.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995260.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995260.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995260.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:11 srv kernel: [44995261.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995261.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995261.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995261.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995261.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:12 srv kernel: [44995262.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995262.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995262.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995262.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995262.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:13 srv kernel: [44995263.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995263.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995263.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995263.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995263.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:14 srv kernel: [44995264.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995264.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995264.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995264.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995264.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:15 srv kernel: [44995265.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995265.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995265.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995265.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995265.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:16 srv kernel: [44995266.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995266.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995266.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995266.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995266.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:17 srv kernel: [44995267.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995267.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995267.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995267.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995267.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:18 srv kernel: [44995268.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995268.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995268.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995268.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995268.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:19 srv kernel: [44995269.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995269.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995269.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995269.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995269.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:20 srv kernel: [44995270.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995270.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995270.910000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995270.950000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995270.990000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.030000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.070000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.110000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.150000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.190000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.230000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.270000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.310000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.350000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.390000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.430000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.470000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.510000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.550000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.590000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.630000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.670000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.710000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.750000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.790000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:21 srv kernel: [44995271.830000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:22 srv kernel: [44995271.870000] Assertion failed! qc != 
NULL,drivers/scsi/libata-core.c,ata_pio_poll,line=2897
Apr 18 08:39:22 srv kernel: [44995271.890000] Unable to handle kernel NULL pointer dereference at 
virtual address 0000008c
Apr 18 08:39:22 srv kernel: [44995271.920000]  printing eip:
Apr 18 08:39:22 srv kernel: [44995271.920000] c029ae4d
Apr 18 08:39:22 srv kernel: [44995271.930000] *pde = 00000000
Apr 18 08:39:22 srv kernel: [44995271.940000] Oops: 0002 [#1]
Apr 18 08:39:22 srv kernel: [44995271.940000] Modules linked in: tun kqemu xt_length xt_CLASSIFY 
cls_u32 sch_sfq sch_htb iptable_mangle ipt_REJECT xt_state ipt_MASQUERADE ipt_REDIRECT xt_tcpudp 
iptable_filter iptable_nat ip_tables x_tables ehci_hcd uhci_hcd usbcore atm ip_nat_irc ip_nat 
ip_conntrack_irc ip_conntrack 8139too mii it87 hwmon_vid i2c_isa ohci1394 ieee1394 sk98lin
Apr 18 08:39:22 srv kernel: [44995271.940000] CPU:    0
Apr 18 08:39:22 srv kernel: [44995271.940000] EIP:    0060:[<c029ae4d>]    Tainted: P      VLI
Apr 18 08:39:22 srv kernel: [44995271.940000] EFLAGS: 00210297   (2.6.16 #2)
Apr 18 08:39:22 srv kernel: [44995271.940000] EIP is at ata_pio_poll+0x8d/0x110
Apr 18 08:39:22 srv kernel: [44995271.940000] eax: 0c315615   ebx: f7922280   ecx: c03cef0c   edx: 
00008407
Apr 18 08:39:22 srv kernel: [44995271.940000] esi: 00000000   edi: 00000004   ebp: 00000002   esp: 
f7d91eec
Apr 18 08:39:22 srv kernel: [44995271.940000] ds: 007b   es: 007b   ss: 0068
Apr 18 08:39:22 srv kernel: [44995271.940000] Process ata/0 (pid: 726, threadinfo=f7d90000 
task=f7d955d0)
Apr 18 08:39:22 srv kernel: [44995271.940000] Stack: <0>f7922280 c0394ece c0394de7 c035e0b7 00000b51 
c0485030 f7922280 00000000
Apr 18 08:39:22 srv kernel: [44995271.940000]        f7c133a0 f7922280 c029b7ec f7922280 f7922830 
00200296 c0127582 f7922280
Apr 18 08:39:22 srv kernel: [44995271.940000]        001e8480 1b30fe80 f7c133b8 f7c133a8 c029b7a0 
f7c133b0 f7d91f88 f7c133a8
Apr 18 08:39:22 srv kernel: [44995271.940000] Call Trace:
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c029b7ec>] ata_pio_task+0x4c/0x80
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c0127582>] run_workqueue+0x62/0xd0
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c029b7a0>] ata_pio_task+0x0/0x80
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c0127730>] worker_thread+0x140/0x170
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c0115310>] default_wake_function+0x0/0x20
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c0115310>] default_wake_function+0x0/0x20
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c01275f0>] worker_thread+0x0/0x170
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c012aab1>] kthread+0xb1/0xc0
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c012aa00>] kthread+0x0/0xc0
Apr 18 08:39:22 srv kernel: [44995271.940000]  [<c0100fd1>] kernel_thread_helper+0x5/0x14
Apr 18 08:39:22 srv kernel: [44995271.940000] Code: 1d 89 bb dc 05 00 00 31 c0 8b 5c 24 18 8b 74 24 
1c 8b 7c 24 20 8b 6c 24 24 83 c4 28 c3 90 a1 38 00 3d c0 39 83 e0 05 00 00 79 13 <83> 8e 8c 00 00 00 
04 c7 83 dc 05 00 00 03 00 00 00 eb c9 b8 02


-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
