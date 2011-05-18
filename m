From: Mark Lord <kernel@teksavvy.com>
Subject: Support for dual-drive pmp?  0x197b:0x2352
Date: Wed, 18 May 2011 15:07:26 -0400
Message-ID: <4DD418EE.8020405@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:41351 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933500Ab1ERTH3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 May 2011 15:07:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

I've seen this two-bay port-multiplier come up here before:

[   30.726818] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   30.727275] ata5.15: Port Multiplier 1.1, 0x197b:0x2352 r0, 2 ports, feat 0x0/0x0
[   30.727286] ata5.15: Asynchronous notification not supported, hotplug won't
[   30.727291]          work on fan-out ports. Use warm-plug instead.
[   30.733313] ata5.00: setting NO_LPM,NO_SRST,ASSUM_ATA for pmp link
[   30.733328] ata5.01: setting NO_LPM,NO_SRST,ASSUM_ATA for pmp link
[   30.734369] ata5.00: hard resetting link
[   31.064015] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   31.064085] ata5.01: hard resetting link
[   31.383993] ata5.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   36.383424] ata5.00: qc timeout (cmd 0xec)
[   36.383450] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   36.383465] ata5.15: hard resetting link
[   36.870072] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   36.870531] ata5.00: hard resetting link
[   37.190667] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   37.190733] ata5.01: hard resetting link
[   37.510651] ata5.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   47.510137] ata5.00: qc timeout (cmd 0xec)
[   47.510162] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   47.510177] ata5.15: hard resetting link
[   47.996772] ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   47.997267] ata5.00: hard resetting link
[   48.317433] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   48.317514] ata5.01: hard resetting link
[   48.637340] ata5.01: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   67.863040] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x100)
[   67.863054] ata5.00: failed to recover link after 3 tries, disabling
[   67.863068] ata5.15: hard resetting link

No worky.  That was with this patch:


--- linux/drivers/ata/libata-pmp.c.orig	2011-05-09 22:33:54.000000000 -0400
+++ linux/drivers/ata/libata-pmp.c	2011-05-18 14:47:56.051148187 -0400
@@ -449,6 +449,13 @@
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
+	} else if (vendor == 0x197b && devid == 0x2352) {
+		ata_for_each_link(link, ap, EDGE) {
+			ata_link_printk(link, KERN_INFO, "setting NO_LPM,NO_SRST,ASSUM_ATA for pmp
link");
+			link->flags |= ATA_LFLAG_NO_LPM  |
+				       ATA_LFLAG_NO_SRST |
+				       ATA_LFLAG_ASSUME_ATA;
+		}
 	}
 }


But it also fails equally well without the patch.  :)
The eSATA host controller is the ever-popular JMicron:

04:00.0 SATA controller: JMicron Technology Corp. JMB362/JMB363 Serial ATA
Controller (rev 02)
(197b:2363)

Just about everything around here has one of those JMicron chips
for the eSATA ports, so I'm guessing that this problem may be
somewhat more widespread than just my home office.

Here's what I know:

1) The 2-bay port-multiplier fails on all systems here using JMicron eSATA.
2) The libata-pmp patch above makes no difference.
3) The 2-bay port-multiplier *works* connected to a Marvell 7042 (sata_mv) board.
4) My other port-multipler, a 4-port, works with the JMicron controllers:

[  888.019990] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  888.020316] ata5.15: Port Multiplier 1.1, 0x11ab:0x4140 r192, 4 ports, feat
0x1/0x1f
[  888.020505] ata5.00: hard resetting link
[  888.506887] ata5.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[  888.506942] ata5.01: hard resetting link
[  888.827053] ata5.01: SATA link down (SStatus 0 SControl 310)
[  888.827145] ata5.02: hard resetting link
[  889.147053] ata5.02: SATA link down (SStatus 0 SControl 310)
[  889.147145] ata5.03: hard resetting link
[  889.467061] ata5.03: SATA link down (SStatus 0 SControl 310)
[  889.487226] ata5.00: ATA-6: HDS722512VLSA80, V33OA6MA, max UDMA/100
[  889.487238] ata5.00: 241254720 sectors, multi 0: LBA48
[  889.490635] ata5.00: configured for UDMA/100
[  889.490733] ata5: EH complete
[  889.491030] scsi 4:0:0:0: Direct-Access     ATA      HDS722512VLSA80  V33O
PQ: 0 ANSI: 5
[  889.491780] sd 4:0:0:0: Attached scsi generic sg2 type 0
[  889.492189] sd 4:0:0:0: [sdc] 241254720 512-byte logical blocks: (123 GB/115 GiB)
[  889.494489] sd 4:0:0:0: [sdc] Write Protect is off
[  889.494508] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[  889.494651] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
[  889.517801]  sdc: unknown partition table
[  889.518343] sd 4:0:0:0: [sdc] Attached SCSI disk

So what next?
I suspect something isn't quite right in the JMicron AHCI driver code.

Cheers
