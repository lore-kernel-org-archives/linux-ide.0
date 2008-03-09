From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] ATA: logical-bitwise and confusion in ahci_save_initial_config()
Date: Sun, 09 Mar 2008 21:42:40 +0100
Message-ID: <47D44BC0.2090906@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:54852 "EHLO
	smtp-out0.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYCIUmo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 16:42:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

logical-bitwise & confusion

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 8a49835..1b73307 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -672,7 +672,7 @@ static void ahci_save_initial_config(struct pci_dev *pdev,
 		cap &= ~HOST_CAP_NCQ;
 	}
 
-	if ((cap && HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
+	if ((cap & HOST_CAP_PMP) && (hpriv->flags & AHCI_HFLAG_NO_PMP)) {
 		dev_printk(KERN_INFO, &pdev->dev,
 			   "controller can't do PMP, turning off CAP_PMP\n");
 		cap &= ~HOST_CAP_PMP;
