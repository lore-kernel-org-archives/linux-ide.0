From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sata_dwc_460ex: use ATA_PIO4
Date: Tue, 25 Jan 2011 19:27:35 +0300
Message-ID: <201101251927.35378.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57885 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751251Ab1AYQ25 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Jan 2011 11:28:57 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Somehow the driver was committed with a bare number for the PIO mask, instead
of ATA_PIO4...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

NB: this driver has some more issues (including compilation warnings) --
meaning that the review process should have been more attentive...

 drivers/ata/sata_dwc_460ex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/ata/sata_dwc_460ex.c
===================================================================
--- linux-2.6.orig/drivers/ata/sata_dwc_460ex.c
+++ linux-2.6/drivers/ata/sata_dwc_460ex.c
@@ -1582,7 +1582,7 @@ static const struct ata_port_info sata_d
 	{
 		.flags		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_NCQ,
-		.pio_mask	= 0x1f,	/* pio 0-4 */
+		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &sata_dwc_ops,
 	},
