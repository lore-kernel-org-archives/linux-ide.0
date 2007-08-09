From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/4] it8213/piix/slc90e66: "de-couple" PIO and UDMA modes
Date: Thu, 9 Aug 2007 22:13:39 +0200
Message-ID: <200708092213.40058.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:48893 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbXHIUQE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:16:04 -0400
Received: by nf-out-0910.google.com with SMTP id g13so163759nfb
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:16:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


Don't force PIO4 when programming UDMA mode (suggested by Sergei).

Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/it8213.c   |    9 ++++-----
 drivers/ide/pci/piix.c     |   11 +++++------
 drivers/ide/pci/slc90e66.c |   10 ++++------
 3 files changed, 13 insertions(+), 17 deletions(-)

Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -93,7 +93,7 @@ static void it8213_set_dma_mode(ide_driv
 	int w_flag		= 0x10 << drive->dn;
 	int u_speed		= 0;
 	u16			reg4042, reg4a;
-	u8			reg48, reg54, reg55, pio;
+	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	pci_read_config_byte(dev, 0x48, &reg48);
@@ -134,10 +134,9 @@ static void it8213_set_dma_mode(ide_driv
 				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
-
-		pio = 4;
 	} else {
 		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		u8 pio;
 
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
@@ -152,9 +151,9 @@ static void it8213_set_dma_mode(ide_driv
 			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
 		else
 			pio = 2; /* only SWDMA2 is allowed */
-	}
 
-	it8213_set_pio_mode(drive, pio);
+		it8213_set_pio_mode(drive, pio);
+	}
 }
 
 /**
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.52	Jul 14, 2007
+ *  linux/drivers/ide/pci/piix.c	Version 0.53	Aug 9, 2007
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -194,7 +194,7 @@ static void piix_set_dma_mode(ide_drive_
 	int u_speed		= 0;
 	int			sitre;
 	u16			reg4042, reg4a;
-	u8			reg48, reg54, reg55, pio;
+	u8			reg48, reg54, reg55;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
@@ -231,10 +231,9 @@ static void piix_set_dma_mode(ide_drive_
 				pci_write_config_byte(dev, 0x54, reg54 | v_flag);
 		} else
 			pci_write_config_byte(dev, 0x54, reg54 & ~v_flag);
-
-		pio = 4;
 	} else {
 		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		u8 pio;
 
 		if (reg48 & u_flag)
 			pci_write_config_byte(dev, 0x48, reg48 & ~u_flag);
@@ -249,9 +248,9 @@ static void piix_set_dma_mode(ide_drive_
 			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
 		else
 			pio = 2; /* only SWDMA2 is allowed */
-	}
 
-	piix_set_pio_mode(drive, pio);
+		piix_set_pio_mode(drive, pio);
+	}
 }
 
 /**
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.17	Aug 2, 2007
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.18	Aug 9, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
@@ -82,7 +82,6 @@ static void slc90e66_set_dma_mode(ide_dr
 	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
-	u8			pio;
 
 	pci_read_config_word(dev, maslave, &reg4042);
 	sitre = (reg4042 & 0x4000) ? 1 : 0;
@@ -111,10 +110,9 @@ static void slc90e66_set_dma_mode(ide_dr
 			pci_read_config_word(dev, 0x4a, &reg4a);
 			pci_write_config_word(dev, 0x4a, reg4a|u_speed);
 		}
-
-		pio = 4;
 	} else {
 		const u8 mwdma_to_pio[] = { 0, 3, 4 };
+		u8 pio;
 
 		if (reg48 & u_flag)
 			pci_write_config_word(dev, 0x48, reg48 & ~u_flag);
@@ -125,9 +123,9 @@ static void slc90e66_set_dma_mode(ide_dr
 			pio = mwdma_to_pio[speed - XFER_MW_DMA_0];
 		else
 			pio = 2; /* only SWDMA2 is allowed */
-	}
 
-	slc90e66_set_pio_mode(drive, pio);
+		slc90e66_set_pio_mode(drive, pio);
+	}
 }
 
 static void __devinit init_hwif_slc90e66 (ide_hwif_t *hwif)
