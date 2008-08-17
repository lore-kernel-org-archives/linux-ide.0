From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/9] cy82c693: remove dead CY82C693_SETDMA_CLOCK code
Date: Sun, 17 Aug 2008 21:53:50 +0200
Message-ID: <20080817195350.13393.33407.sendpatchset@localhost.localdomain>
References: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:16970 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYHQT4K (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 15:56:10 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1481750fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 12:56:10 -0700 (PDT)
In-Reply-To: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Remove dead CY82C693_SETDMA_CLOCK code and now not needed
init_chipset_cy82c693().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cy82c693.c |   60 ---------------------------------------------
 1 file changed, 60 deletions(-)

Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -50,18 +50,12 @@
 
 #define DRV_NAME "cy82c693"
 
-/* the current version */
-#define CY82_VERSION	"CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)"
-
 /*
  *	The following are used to debug the driver.
  */
 #define CY82C693_DEBUG_LOGS	0
 #define CY82C693_DEBUG_INFO	0
 
-/* define CY82C693_SETDMA_CLOCK to set DMA Controller Clock Speed to ATCLK */
-#undef CY82C693_SETDMA_CLOCK
-
 /*
  *	NOTE: the value for busmaster timeout is tricky and I got it by
  *	trial and error!  By using a to low value will cause DMA timeouts
@@ -89,7 +83,6 @@
 #define CY82_INDEX_PORT		0x22
 #define CY82_DATA_PORT		0x23
 
-#define CY82_INDEX_CTRLREG1	0x01
 #define CY82_INDEX_CHANNEL0	0x30
 #define CY82_INDEX_CHANNEL1	0x31
 #define CY82_INDEX_TIMEOUT	0x32
@@ -329,58 +322,6 @@ static void cy82c693_set_pio_mode(ide_dr
 #endif /* CY82C693_DEBUG_INFO */
 }
 
-/*
- * this function is called during init and is used to setup the cy82c693 chip
- */
-static unsigned int init_chipset_cy82c693(struct pci_dev *dev)
-{
-	if (PCI_FUNC(dev->devfn) != 1)
-		return 0;
-
-#ifdef CY82C693_SETDMA_CLOCK
-	u8 data = 0;
-#endif /* CY82C693_SETDMA_CLOCK */
-
-	/* write info about this verion of the driver */
-	printk(KERN_INFO CY82_VERSION "\n");
-
-#ifdef CY82C693_SETDMA_CLOCK
-       /* okay let's set the DMA clock speed */
-
-	outb(CY82_INDEX_CTRLREG1, CY82_INDEX_PORT);
-	data = inb(CY82_DATA_PORT);
-
-#if CY82C693_DEBUG_INFO
-	printk(KERN_INFO DRV_NAME ": Peripheral Configuration Register: 0x%X\n",
-		data);
-#endif /* CY82C693_DEBUG_INFO */
-
-	/*
-	 * for some reason sometimes the DMA controller
-	 * speed is set to ATCLK/2 ???? - we fix this here
-	 *
-	 * note: i don't know what causes this strange behaviour,
-	 *       but even changing the dma speed doesn't solve it :-(
-	 *       the ide performance is still only half the normal speed
-	 *
-	 *       if anybody knows what goes wrong with my machine, please
-	 *       let me know - ASK
-	 */
-
-	data |= 0x03;
-
-	outb(CY82_INDEX_CTRLREG1, CY82_INDEX_PORT);
-	outb(data, CY82_DATA_PORT);
-
-#if CY82C693_DEBUG_INFO
-	printk(KERN_INFO ": New Peripheral Configuration Register: 0x%X\n",
-		data);
-#endif /* CY82C693_DEBUG_INFO */
-
-#endif /* CY82C693_SETDMA_CLOCK */
-	return 0;
-}
-
 static void __devinit init_iops_cy82c693(ide_hwif_t *hwif)
 {
 	static ide_hwif_t *primary;
@@ -401,7 +342,6 @@ static const struct ide_port_ops cy82c69
 
 static const struct ide_port_info cy82c693_chipset __devinitdata = {
 	.name		= DRV_NAME,
-	.init_chipset	= init_chipset_cy82c693,
 	.init_iops	= init_iops_cy82c693,
 	.port_ops	= &cy82c693_port_ops,
 	.chipset	= ide_cy82c693,
