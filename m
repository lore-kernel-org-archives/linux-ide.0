From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/12] piix/slc90e66: fix PIO1 handling in ->speedproc method
Date: Sun, 8 Jul 2007 15:36:54 +0200
Message-ID: <200707081536.54841.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:5731 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264AbXGHOAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Jul 2007 10:00:13 -0400
Received: by mu-out-0910.google.com with SMTP id i10so570149mue
        for <linux-ide@vger.kernel.org>; Sun, 08 Jul 2007 07:00:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Don't call {piix,slc90e66}_dma_2_pio() for PIO modes in
  {piix,slc90e66}_tune_chipset().

* Add PIO1 handling to {piix,slc90e66}_tune_chipset().

* Bump driver version.  

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/piix.c     |    9 +++++++--
 drivers/ide/pci/slc90e66.c |    9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

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
@@ -269,6 +269,7 @@ static int piix_tune_chipset (ide_drive_
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:	break;
 		default:		return -1;
 	}
@@ -299,7 +300,11 @@ static int piix_tune_chipset (ide_drive_
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
@@ -136,6 +136,7 @@ static int slc90e66_tune_chipset (ide_dr
 		case XFER_PIO_4:
 		case XFER_PIO_3:
 		case XFER_PIO_2:
+		case XFER_PIO_1:
 		case XFER_PIO_0:        break;
 		default:		return -1;
 	}
@@ -156,7 +157,11 @@ static int slc90e66_tune_chipset (ide_dr
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
 
