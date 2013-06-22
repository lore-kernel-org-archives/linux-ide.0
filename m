From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] ahci: use ATA_BUSY
Date: Sun, 23 Jun 2013 01:14:37 +0400
Message-ID: <201306230114.37999.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62985 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3FVVOa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jun 2013 17:14:30 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so8909735lab.33
        for <linux-ide@vger.kernel.org>; Sat, 22 Jun 2013 14:14:29 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

ahci_p5wdh_hardreset() uses bare number for the BSY bit of the ATA status
register, despite it's #define'd in <linux/ata.h>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/ata/ahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: libata/drivers/ata/ahci.c
===================================================================
--- libata.orig/drivers/ata/ahci.c
+++ libata/drivers/ata/ahci.c
@@ -583,7 +583,7 @@ static int ahci_p5wdh_hardreset(struct a
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = 0x80;
+	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
