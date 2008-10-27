From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/2] cmd64x: set IDE_HFLAG_SERIALIZE explictly for CMD646
Date: Mon, 27 Oct 2008 20:58:54 +0100
Message-ID: <200810272058.54522.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:27155 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbYJ0UCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Oct 2008 16:02:43 -0400
Received: by gv-out-0910.google.com with SMTP id e6so301594gvc.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Oct 2008 13:02:41 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>

* Set IDE_HFLAG_SERIALIZE explictly for CMD646.

* Remove no longer needed ide_cmd646 chipset type (which has
  a nice side-effect of fixing handling of unexpected IRQs).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cmd64x.c    |    4 ++--
 drivers/ide/ide-probe.c |    2 +-
 drivers/ide/ide-proc.c  |    1 -
 include/linux/ide.h     |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

Index: b/drivers/ide/cmd64x.c
===================================================================
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -424,10 +424,10 @@ static const struct ide_port_info cmd64x
 		.name		= DRV_NAME,
 		.init_chipset	= init_chipset_cmd64x,
 		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
-		.chipset	= ide_cmd646,
 		.port_ops	= &cmd64x_port_ops,
 		.dma_ops	= &cmd648_dma_ops,
-		.host_flags	= IDE_HFLAG_ABUSE_PREFETCH,
+		.host_flags	= IDE_HFLAG_SERIALIZE |
+				  IDE_HFLAG_ABUSE_PREFETCH,
 		.pio_mask	= ATA_PIO5,
 		.mwdma_mask	= ATA_MWDMA2,
 		.udma_mask	= ATA_UDMA2,
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1123,7 +1123,7 @@ static int init_irq (ide_hwif_t *hwif)
 		sa = IRQF_SHARED;
 #endif /* __mc68000__ */
 
-		if (hwif->chipset == ide_pci || hwif->chipset == ide_cmd646)
+		if (hwif->chipset == ide_pci)
 			sa = IRQF_SHARED;
 
 		if (io_ports->ctl_addr)
Index: b/drivers/ide/ide-proc.c
===================================================================
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -48,7 +48,6 @@ static int proc_ide_read_imodel
 	case ide_ht6560b:	name = "ht6560b";	break;
 	case ide_rz1000:	name = "rz1000";	break;
 	case ide_trm290:	name = "trm290";	break;
-	case ide_cmd646:	name = "cmd646";	break;
 	case ide_cy82c693:	name = "cy82c693";	break;
 	case ide_4drives:	name = "4drives";	break;
 	case ide_pmac:		name = "mac-io";	break;
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -164,7 +164,7 @@ enum {		ide_unknown,	ide_generic,	ide_pc
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_rz1000,	ide_trm290,
-		ide_cmd646,	ide_cy82c693,	ide_4drives,
+		ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_acorn,
 		ide_au1xxx,	ide_palm3710
 };
