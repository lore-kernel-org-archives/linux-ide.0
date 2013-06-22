From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2] AHCI: use ATA_BUSY
Date: Sun, 23 Jun 2013 01:39:39 +0400
Message-ID: <201306230139.39597.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:49827 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3FVVjc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Jun 2013 17:39:32 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so8955253lab.31
        for <linux-ide@vger.kernel.org>; Sat, 22 Jun 2013 14:39:30 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org

ahci_hardreset() and ahci_p5wdh_hardreset() use bare numbers for the BSY bit of
the  ATA status  register, despite it's #define'd in <linux/ata.h>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'for-3.11' branch of Tejun Heo's 'libata.git' repo. 

 drivers/ata/ahci.c    |    2 +-
 drivers/ata/libahci.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
Index: libata/drivers/ata/libahci.c
===================================================================
--- libata.orig/drivers/ata/libahci.c
+++ libata/drivers/ata/libahci.c
@@ -1413,7 +1413,7 @@ static int ahci_hardreset(struct ata_lin
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
-	tf.command = 0x80;
+	tf.command = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
 	rc = sata_link_hardreset(link, timing, deadline, &online,
