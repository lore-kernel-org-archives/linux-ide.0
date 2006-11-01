From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] ahci: fix status register check in ahci_softreset
Date: Wed, 1 Nov 2006 17:19:18 +0900
Message-ID: <20061101081918.GO13677@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:2326 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946700AbWKAIT0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 03:19:26 -0500
Received: by nf-out-0910.google.com with SMTP id c2so710815nfe
        for <linux-ide@vger.kernel.org>; Wed, 01 Nov 2006 00:19:24 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

ahci_softreset() used to use ahci_tf_read() which reads D2H_REG area
to check for the Status register.  However, this area is zeroed on
initialization and not set by initial signature FIS.  Replace it with
ahci_check_status().

This bug prevented CLO code from being activated whenever BSY and/or
DRQ is set prior to softreset.  This fix makes
AHCI_FLAG_RESET_NEEDS_CLO flag redundant.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Jeff, check_status fix is separated as requested.  Please apply to
#upstream-fixes.

Thanks.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index cef2e70..988f8bb 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -736,8 +736,7 @@ static int ahci_softreset(struct ata_por
 	}
 
 	/* check BUSY/DRQ, perform Command List Override if necessary */
-	ahci_tf_read(ap, &tf);
-	if (tf.command & (ATA_BUSY | ATA_DRQ)) {
+	if (ahci_check_status(ap) & (ATA_BUSY | ATA_DRQ)) {
 		rc = ahci_clo(ap);
 
 		if (rc == -EOPNOTSUPP) {
