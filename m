From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [git patches] IDE fixes
Date: Tue, 29 Apr 2008 23:12:37 +0200
Message-ID: <200804292312.37414.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:42245 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758530AbYD2U5A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 16:57:00 -0400
Received: by nf-out-0910.google.com with SMTP id d3so129198nfc.21
        for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 13:56:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Linus, please pull from:

master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

to receive the following updates:

 drivers/ide/pci/alim15x3.c |   10 +++++-----
 drivers/ide/pci/siimage.c  |    9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)


Anton Vorontsov (1):
      alim15x3: disable init_hwif_ali15x3 for PowerPC

Benjamin Herrenschmidt (1):
      ide: fix crash at boot with siimage driver


diff --git a/drivers/ide/pci/alim15x3.c b/drivers/ide/pci/alim15x3.c
index b36a22b..c1922f9 100644
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -412,14 +412,14 @@ static u8 __devinit ali_cable_detect(ide_hwif_t *hwif)
 	return cbl;
 }
 
-#ifndef CONFIG_SPARC64
+#if !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC)
 /**
  *	init_hwif_ali15x3	-	Initialize the ALI IDE x86 stuff
  *	@hwif: interface to configure
  *
  *	Obtain the IRQ tables for an ALi based IDE solution on the PC
  *	class platforms. This part of the code isn't applicable to the
- *	Sparc systems
+ *	Sparc and PowerPC systems.
  */
 
 static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
@@ -463,7 +463,9 @@ static void __devinit init_hwif_ali15x3 (ide_hwif_t *hwif)
 			hwif->irq = irq;
 	}
 }
-#endif
+#else
+#define init_hwif_ali15x3 NULL
+#endif /* !defined(CONFIG_SPARC64) && !defined(CONFIG_PPC) */
 
 /**
  *	init_dma_ali15x3	-	set up DMA on ALi15x3
@@ -517,9 +519,7 @@ static const struct ide_dma_ops ali_dma_ops = {
 static const struct ide_port_info ali15x3_chipset __devinitdata = {
 	.name		= "ALI15X3",
 	.init_chipset	= init_chipset_ali15x3,
-#ifndef CONFIG_SPARC64
 	.init_hwif	= init_hwif_ali15x3,
-#endif
 	.init_dma	= init_dma_ali15x3,
 	.port_ops	= &ali_port_ops,
 	.pio_mask	= ATA_PIO5,
diff --git a/drivers/ide/pci/siimage.c b/drivers/ide/pci/siimage.c
index 4cf8fc5..0006b9e 100644
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -737,8 +737,15 @@ static const struct ide_port_ops sil_sata_port_ops = {
 	.cable_detect		= sil_cable_detect,
 };
 
-static struct ide_dma_ops sil_dma_ops = {
+static const struct ide_dma_ops sil_dma_ops = {
+	.dma_host_set		= ide_dma_host_set,
+	.dma_setup		= ide_dma_setup,
+	.dma_exec_cmd		= ide_dma_exec_cmd,
+	.dma_start		= ide_dma_start,
+	.dma_end		= __ide_dma_end,
 	.dma_test_irq		= siimage_dma_test_irq,
+	.dma_timeout		= ide_dma_timeout,
+	.dma_lost_irq		= ide_dma_lost_irq,
 };
 
 #define DECLARE_SII_DEV(name_str, p_ops)		\
