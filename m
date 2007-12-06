From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: fix engine reset failed message
Date: Thu, 06 Dec 2007 15:02:48 +0900
Message-ID: <47579088.6010607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:8356 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbXLFGCy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 01:02:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so235291wah
        for <linux-ide@vger.kernel.org>; Wed, 05 Dec 2007 22:02:54 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

There isn't much point in reporting -EOPNOTSUPP as failure.  Also the
message was missing newline.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -1271,9 +1271,9 @@ static int ahci_do_softreset(struct ata_
 
 	/* prepare for SRST (AHCI-1.1 10.4.1) */
 	rc = ahci_kick_engine(ap, 1);
-	if (rc)
+	if (rc && rc != -EOPNOTSUPP)
 		ata_link_printk(link, KERN_WARNING,
-				"failed to reset engine (errno=%d)", rc);
+				"failed to reset engine (errno=%d)\n", rc);
 
 	ata_tf_init(link->device, &tf);
 
