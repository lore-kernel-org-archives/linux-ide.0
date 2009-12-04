From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 2/2] pata_cs5520: use ATA_DMA_* constants
Date: Sat, 5 Dec 2009 00:39:00 +0400
Message-ID: <200912042339.00746.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:19271 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1757170AbZLDUhr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Dec 2009 15:37:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Use ATA_DMA_* constants instead of the bare numbers for the BMIDE registers.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ata/pata_cs5520.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/pata_cs5520.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_cs5520.c
+++ linux-2.6/drivers/ata/pata_cs5520.c
@@ -99,9 +99,9 @@ static void cs5520_set_timings(struct at
 static void cs5520_enable_dma(struct ata_port *ap, struct ata_device *adev)
 {
 	/* Set the DMA enable/disable flag */
-	u8 reg = ioread8(ap->ioaddr.bmdma_addr + 0x02);
-	reg |= 1<<(adev->devno + 5);
-	iowrite8(reg, ap->ioaddr.bmdma_addr + 0x02);
+	u8 reg = ioread8(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
+	reg |= 1 << (adev->devno + 5);
+	iowrite8(reg, ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 }
 
 /**

