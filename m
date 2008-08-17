From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] cy82c693: remove no longer needed CY82C693_DEBUG_LOGS code
Date: Sun, 17 Aug 2008 21:53:57 +0200
Message-ID: <20080817195357.13393.92210.sendpatchset@localhost.localdomain>
References: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:16970 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbYHQT4R (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Aug 2008 15:56:17 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1481750fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 17 Aug 2008 12:56:17 -0700 (PDT)
In-Reply-To: <20080817195336.13393.86030.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

Having CY82C693_DEBUG_INFO is enough nowadays.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/cy82c693.c |   51 ---------------------------------------------
 1 file changed, 51 deletions(-)

Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -53,7 +53,6 @@
 /*
  *	The following are used to debug the driver.
  */
-#define CY82C693_DEBUG_LOGS	0
 #define CY82C693_DEBUG_INFO	0
 
 /*
@@ -172,17 +171,6 @@ static void cy82c693_set_dma_mode(ide_dr
 
 	index = hwif->channel ? CY82_INDEX_CHANNEL1 : CY82_INDEX_CHANNEL0;
 
-#if CY82C693_DEBUG_LOGS
-	/* for debug let's show the previous values */
-
-	outb(index, CY82_INDEX_PORT);
-	data = inb(CY82_DATA_PORT);
-
-	printk(KERN_INFO "%s (ch=%d, dev=%d): DMA mode is %d (single=%d)\n",
-		drive->name, HWIF(drive)->channel, drive->select.b.unit,
-		(data&0x3), ((data>>2)&1));
-#endif /* CY82C693_DEBUG_LOGS */
-
 	data = (mode & 3) | (single << 2);
 
 	outb(index, CY82_INDEX_PORT);
@@ -232,45 +220,6 @@ static void cy82c693_set_pio_mode(ide_dr
 		}
 	}
 
-#if CY82C693_DEBUG_LOGS
-	/* for debug let's show the register values */
-
-	if (drive->select.b.unit == 0) {
-		/*
-		 * get master drive registers
-		 * address setup control register
-		 * is 32 bit !!!
-		 */
-		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
-		addrCtrl &= 0x0F;
-
-		/* now let's get the remaining registers */
-		pci_read_config_byte(dev, CY82_IDE_MASTER_IOR, &pclk.time_16r);
-		pci_read_config_byte(dev, CY82_IDE_MASTER_IOW, &pclk.time_16w);
-		pci_read_config_byte(dev, CY82_IDE_MASTER_8BIT, &pclk.time_8);
-	} else {
-		/*
-		 * set slave drive registers
-		 * address setup control register
-		 * is 32 bit !!!
-		 */
-		pci_read_config_dword(dev, CY82_IDE_ADDRSETUP, &addrCtrl);
-
-		addrCtrl &= 0xF0;
-		addrCtrl >>= 4;
-
-		/* now let's get the remaining registers */
-		pci_read_config_byte(dev, CY82_IDE_SLAVE_IOR, &pclk.time_16r);
-		pci_read_config_byte(dev, CY82_IDE_SLAVE_IOW, &pclk.time_16w);
-		pci_read_config_byte(dev, CY82_IDE_SLAVE_8BIT, &pclk.time_8);
-	}
-
-	printk(KERN_INFO "%s (ch=%d, dev=%d): PIO timing is "
-		"(addr=0x%X, ior=0x%X, iow=0x%X, 8bit=0x%X)\n",
-		drive->name, hwif->channel, drive->select.b.unit,
-		addrCtrl, pclk.time_16r, pclk.time_16w, pclk.time_8);
-#endif /* CY82C693_DEBUG_LOGS */
-
 	/* let's calc the values for this PIO mode */
 	compute_clocks(pio, &pclk);
 
