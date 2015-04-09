From: Ronny Hegewald <ronny.hegewald@online.de>
Subject: [PATCH] resolve collision of generic ATA_FLAG_LOWTAG and driver specific flag
Date: Thu, 9 Apr 2015 20:09:08 +0000
Message-ID: <201504092009.08703.ronny.hegewald@online.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:57427 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933254AbbDIUIl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Apr 2015 16:08:41 -0400
Received: from server2-groupware.localnet ([217.188.216.225]) by
 mrelayeu.kundenserver.de (mreue101) with ESMTPSA (Nemesis) id
 0LfAVs-1ZDAg30zNo-00olYf for <linux-ide@vger.kernel.org>; Thu, 09 Apr 2015
 22:08:39 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The patch "libata: allow sata_sil24 to opt-out of tag ordered submission" 
(72dd299d5039a336493993dcc63413cf31d0e662) introduces a regression with the 
sata_sil24 driver.

The new flag ATA_FLAG_LOWTAG accidentially uses the same bit as 
SIL24_FLAG_PCIX_IRQ_WOC in the driver. This activates code for Silicon Image 
3132, which is only suppossed to run under 3124.

ATA_FLAG_LOWTAG is only used in sata_sil24 and is planned to be removed soon, 
so lets just use another bit for the flag in sata_sil24. 

Signed-off-by: Ronny Hegewald <Ronny.Hegewald@online.de>
Cc: stable@vger.kernel.org

--- linux-3.18.5/drivers/ata/sata_sil24.c.org
+++ linux-3.18.5/drivers/ata/sata_sil24.c
@@ -247,7 +247,7 @@
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
 				  ATA_FLAG_AN | ATA_FLAG_PMP | ATA_FLAG_LOWTAG,
-	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
+	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 25), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
 };

