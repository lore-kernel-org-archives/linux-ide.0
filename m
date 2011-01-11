From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_hpt37x: inherit prereset() method for HPT374
Date: Tue, 11 Jan 2011 21:01:23 +0300
Message-ID: <201101112101.23988.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:34860 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753913Ab1AKSCn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Jan 2011 13:02:43 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk

Commit ab81a505ae6be069be5b67acd7e1bab3cfb53968 (pata_hpt37x: unify ->pre_reset
methods) neglected to remove the initializer for the prereset() method from
'hpt374_fn1_port_ops' (it's inherited from 'hpt372_port_ops' anyway), as well
as to update the comment in hpt37x_init_one()...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree plus 3 patches that I've posted
before:

http://marc.info/?l=linux-ide&m=129468455026976
http://marc.info/?l=linux-ide&m=129468485927420
http://marc.info/?l=linux-ide&m=129468797632201

 drivers/ata/pata_hpt37x.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.21"
+#define DRV_VERSION	"0.6.22"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -642,7 +642,6 @@ static struct ata_port_operations hpt372
 static struct ata_port_operations hpt374_fn1_port_ops = {
 	.inherits	= &hpt372_port_ops,
 	.cable_detect	= hpt374_fn1_cable_detect,
-	.prereset	= hpt37x_pre_reset,
 };
 
 /**
@@ -803,7 +802,7 @@ static int hpt37x_init_one(struct pci_de
 		.udma_mask = ATA_UDMA6,
 		.port_ops = &hpt302_port_ops
 	};
-	/* HPT374 - UDMA100, function 1 uses different prereset method */
+	/* HPT374 - UDMA100, function 1 uses different cable_detect method */
 	static const struct ata_port_info info_hpt374_fn0 = {
 		.flags = ATA_FLAG_SLAVE_POSS,
 		.pio_mask = ATA_PIO4,
