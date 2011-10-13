From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: fix for transport xfer attributes
Date: Thu, 13 Oct 2011 22:03:45 +0200
Message-ID: <201110132203.45394.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58632 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1JMURT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Oct 2011 16:17:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] libata: fix for transport xfer attributes

Fix display of pio_mode, dma_mode and xfer_mode device attributes.

before:
$ cat /sys/class/ata_device/dev1.0/xfer_mode
XFER_UDMA_7, XFER_UDMA_6, XFER_UDMA_5, XFER_UDMA_4, XFER_UDMA_3, XFER_UDMA_2, XF
ER_UDMA_1, XFER_UDMA_0, XFER_MW_DMA_4, XFER_MW_DMA_3, XFER_MW_DMA_2, XFER_SW_DMA
_2, XFER_PIO_6, XFER_PIO_5, XFER_PIO_4, XFER_PIO_3, XFER_PIO_2

after:
$ cat /sys/class/ata_device/dev1.0/xfer_mode
XFER_UDMA_6

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/ABI/testing/sysfs-ata |    4 ++--
 drivers/ata/libata-transport.c      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: b/Documentation/ABI/testing/sysfs-ata
===================================================================
--- a/Documentation/ABI/testing/sysfs-ata
+++ b/Documentation/ABI/testing/sysfs-ata
@@ -59,12 +59,12 @@ class
 
 dma_mode
 
-	Transfer modes supported by the device when in DMA mode.
+	Transfer mode currently used by the device when in DMA mode.
 	Mostly used by PATA device.
 
 pio_mode
 
-	Transfer modes supported by the device when in PIO mode.
+	Transfer mode currently used by the device when in PIO mode.
 	Mostly used by PATA device.
 
 xfer_mode
Index: b/drivers/ata/libata-transport.c
===================================================================
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -194,7 +194,7 @@ static struct {
 	{ XFER_PIO_0,			"XFER_PIO_0" },
 	{ XFER_PIO_SLOW,		"XFER_PIO_SLOW" }
 };
-ata_bitfield_name_match(xfer,ata_xfer_names)
+ata_bitfield_name_search(xfer, ata_xfer_names)
 
 /*
  * ATA Port attributes
