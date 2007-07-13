From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] piix/slc90e66: fix PIO1 handling in ->speedproc method (take 2)
Date: Fri, 13 Jul 2007 23:03:39 +0200
Message-ID: <200707132303.39408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:44346 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbXGMVbH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 17:31:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so647444ugf
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 14:31:06 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
  {piix,slc90e66}_tune_chipset().

* Add PIO1 handling to {piix,slc90e66}_tune_chipset().

* Bump driver version.  

v2:
* Remove PIO modes from {piix,slc90e66}_dma_2_pio(), they are no longer needed
  there (Noticed by Sergei)

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
---
 drivers/ide/pci/piix.c     |   17 ++++++++---------
 drivers/ide/pci/slc90e66.c |   15 +++++++--------
 2 files changed, 15 insertions(+), 17 deletions(-)

Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/piix.c	Version 0.50	Jun 10, 2007
+ *  linux/drivers/ide/pci/piix.c	Version 0.51	Jul 6, 2007
  *
  *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
  *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
@@ -109,7 +109,7 @@ static int no_piix_dma;
  *	piix_dma_2_pio		-	return the PIO mode matching DMA
  *	@xfer_rate: transfer speed
  *
- *	Returns the nearest equivalent PIO timing for the PIO or DMA
+ *	Returns the nearest equivalent PIO timing for the DMA
  *	mode requested by the controller.
  */
  
@@ -123,20 +123,14 @@ static u8 piix_dma_2_pio (u8 xfer_rate) 
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
 		case XFER_MW_DMA_2:
-		case XFER_PIO_4:
 			return 4;
 		case XFER_MW_DMA_1:
-		case XFER_PIO_3:
 			return 3;
 		case XFER_SW_DMA_2:
-		case XFER_PIO_2:
 			return 2;
 		case XFER_MW_DMA_0:
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-		case XFER_PIO_SLOW:
 		default:
 			return 0;
 	}
@@ -269,6 +263,7 @@ static int piix_tune_chipset (ide_drive_
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:	break;
 		default:		return -1;
 	}
@@ -299,7 +294,11 @@ static int piix_tune_chipset (ide_drive_
 			pci_write_config_byte(dev, 0x55, (u8) reg55 & ~w_flag);
 	}
 
-	piix_tune_pio(drive, piix_dma_2_pio(speed));
+	if (speed > XFER_PIO_4)
+		piix_tune_pio(drive, piix_dma_2_pio(speed));
+	else
+		piix_tune_pio(drive, speed - XFER_PIO_0);
+
 	return ide_config_drive_speed(drive, speed);
 }
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/pci/slc90e66.c	Version 0.14	February 8, 2007
+ *  linux/drivers/ide/pci/slc90e66.c	Version 0.15	Jul 6, 2007
  *
  *  Copyright (C) 2000-2002 Andre Hedrick <andre@linux-ide.org>
  *  Copyright (C) 2006-2007 MontaVista Software, Inc. <source@mvista.com>
@@ -29,20 +29,14 @@ static u8 slc90e66_dma_2_pio (u8 xfer_ra
 		case XFER_UDMA_1:
 		case XFER_UDMA_0:
 		case XFER_MW_DMA_2:
-		case XFER_PIO_4:
 			return 4;
 		case XFER_MW_DMA_1:
-		case XFER_PIO_3:
 			return 3;
 		case XFER_SW_DMA_2:
-		case XFER_PIO_2:
 			return 2;
 		case XFER_MW_DMA_0:
 		case XFER_SW_DMA_1:
 		case XFER_SW_DMA_0:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-		case XFER_PIO_SLOW:
 		default:
 			return 0;
 	}
@@ -136,6 +130,7 @@ static int slc90e66_tune_chipset (ide_dr
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:        break;
 		default:		return -1;
 	}
@@ -156,7 +151,11 @@ static int slc90e66_tune_chipset (ide_dr
 			pci_write_config_word(dev, 0x4a, reg4a & ~a_speed);
 	}
 
-	slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
+	if (speed > XFER_PIO_4)
+		slc90e66_tune_pio(drive, slc90e66_dma_2_pio(speed));
+	else
+		slc90e66_tune_pio(drive, speed - XFER_PIO_0);
+
 	return ide_config_drive_speed(drive, speed);
 }
 
