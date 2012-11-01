From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] sata_highbank: use ATA_BUSY
Date: Thu, 1 Nov 2012 20:59:28 +0300
Message-ID: <201211012059.29109.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:46496 "EHLO
	wasted.dev.rtsoft.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750745Ab2KARF3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2012 13:05:29 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

ahci_highbank_hardreset() uses bare number for the BSY bit of the ATA status
register, despite it is #define'd in <linux/ata.h>

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is atop of the 'upstream' branch of libata-dev.git...

 drivers/ata/sata_highbank.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: libata-dev/drivers/ata/sata_highbank.c
===================================================================
--- libata-dev.orig/drivers/ata/sata_highbank.c
+++ libata-dev/drivers/ata/sata_highbank.c
@@ -213,7 +213,7 @@ static int ahci_highbank_hardreset(struc
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = 0x80;
+	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	do {
