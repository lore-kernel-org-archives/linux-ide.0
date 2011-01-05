From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_hpt37x: actually limit HPT370 to UltraDMA/66
Date: Wed, 5 Jan 2011 21:59:49 +0300
Message-ID: <201101052159.49796.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58458 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750854Ab1AETBO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2011 14:01:14 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

The driver clearly tries to limit HPT370[A] to UltraDMA/66 if the PCI clock is
less than 50 MHz but due to cut&paste type mistake this code has no effect...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus 2 patches that I posted
before:

http://marc.info/?l=linux-ide&m=129330632207779
http://marc.info/?l=linux-ide&m=129356704826019

 drivers/ata/pata_hpt37x.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.17"
+#define DRV_VERSION	"0.6.18"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -771,20 +771,20 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = ATA_UDMA5,
 		.port_ops = &hpt370a_port_ops
 	};
-	/* HPT370 - UDMA100 */
+	/* HPT370 - UDMA66 */
 	static const struct ata_port_info info_hpt370_33 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
 		.mwdma_mask = ATA_MWDMA2,
-		.udma_mask = ATA_UDMA5,
+		.udma_mask = ATA_UDMA4,
 		.port_ops = &hpt370_port_ops
 	};
-	/* HPT370A - UDMA100 */
+	/* HPT370A - UDMA66 */
 	static const struct ata_port_info info_hpt370a_33 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
 		.mwdma_mask = ATA_MWDMA2,
-		.udma_mask = ATA_UDMA5,
+		.udma_mask = ATA_UDMA4,
 		.port_ops = &hpt370a_port_ops
 	};
 	/* HPT372 - UDMA133 */
