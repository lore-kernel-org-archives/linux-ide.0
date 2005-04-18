From: Tim Moore <tim.moore@nsr500.net>
Subject: ST3120026A working in 2.4.30 w sata_sil
Date: Sun, 17 Apr 2005 23:26:03 -0700
Message-ID: <426352FB.1070507@nsr500.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:62116 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S261795AbVDRG0E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 18 Apr 2005 02:26:04 -0400
Received: from dsl081-056-134.sfo1.dsl.speakeasy.net (HELO [192.168.1.10]) ([64.81.56.134])
          (envelope-sender <tim.moore@nsr500.net>)
          by mail23.sea5.speakeasy.net (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 18 Apr 2005 06:26:02 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

FYI;

Applied the v0.9 patch to sata_sil.c:

# ChangeSet
# 2005/03/24 23:32:42-05:00 Carlos.Pardo@xxxxxxxxxxxxxxxx
# [PATCH] sata_sil: Fix FIFO PCI Bus Arbitration

Applied this Brian Kuschak hack to libata-core.c:

--- libata-core.c.orig	2005-02-23 17:41:03.831836464 -0800
+++ libata-core.c	2005-02-23 17:54:51.287044152 -0800
@@ -3158,6 +3158,11 @@
  	if (qc && (!(qc->tf.ctl & ATA_NIEN))) {
  		handled |= ata_host_intr(ap, qc);
  	}
+	else {
+		/* bk - just ack spurious interrupt here - temp workaround */
+		ata_irq_ack(ap, 0); 		
+		printk(KERN_WARNING "ata%d: irq trap\n", ap->id);
+	}

Added "pci=biosirq ide2=0 ide3=0" to boot params,
some combination of which reliabily and repeatedly works:
...
bata version 1.10 loaded.
sata_sil version 0.9
ata1: SATA max UDMA/100 cmd 0xF880F080 ctl 0xF880F08A bmdma 0xF880F000 irq 11
ata2: SATA max UDMA/100 cmd 0xF880F0C0 ctl 0xF880F0CA bmdma 0xF880F008 irq 11
ata1: irq trap
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 87:4003 88:003f
ata1: dev 0 ATA, max UDMA/100, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/100
ata2: no device found (phy stat 00000000)
scsi2 : sata_sil
scsi3 : sata_sil
   Vendor: ATA       Model: ST3120026A        Rev: 3.01
   Type:   Direct-Access                      ANSI SCSI revision: 05
...

Prior to making all three of these changes, boot attempts with the sata_sil
driver when any PATA disk was connected to the bridge would hard lock just after:
...
ata2: SATA max UDMA/100 cmd 0xF880F0C0 ctl 0xF880F0CA bmdma 0xF880F008 irq 11

The ide driver generated errors at each access and was removed:
...
kernel: hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
last message repeated 10 times

Hope this sheds some light.

Thanks,
Tim.

hardware: abit NF7-S + SiI3112 -> SiI3611 PATA bridge adapter.
kernel: stock 2.4.30

# fdisk -l /dev/sde

Disk /dev/sde: 255 heads, 63 sectors, 14593 cylinders
Units = cylinders of 16065 * 512 bytes

    Device Boot    Start       End    Blocks   Id  System
/dev/sde1   *         1        13    104391   83  Linux
/dev/sde2            14       109    771120   82  Linux swap
/dev/sde3           110      7321  57930390   83  Linux
/dev/sde4          7322     14593  58412340   83  Linux

# mount /dev/sde3 /mnt
# /usr/bin/time bonnie++ -d /mnt -s 2048:32k -n 0 -m sata_sil -u 0 -f
Using uid:0, gid:0.
Writing intelligently...done
Rewriting...done
Reading intelligently...done
start 'em...done...done...done...
Version  1.03       ------Sequential Output------ --Sequential Input- --Random-
                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
Machine   Size:chnk K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
sata_sil     2G:32k           57428  10 23621   4           49888   7 180.2   0
sata_sil,2G:32k,,,57428,10,23621,4,,,49888,7,180.2,0,,,,,,,,,,,,,
: sec 218.08 cpu 5% min 3:38.08 sys 11.71 usr 0.06 mapf 186 mipf 133
