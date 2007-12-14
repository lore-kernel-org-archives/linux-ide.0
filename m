From: akpm@linux-foundation.org
Subject: [patch 8/9] libata-fix-early-use-of-port-printk-checkpatch-fixes
Date: Thu, 13 Dec 2007 16:01:43 -0800
Message-ID: <200712140001.lBE01igl025449@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57943 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764332AbXLNAB5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Dec 2007 19:01:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, htejun@gmail.com

From: Andrew Morton <akpm@linux-foundation.org>

total: 0 errors, 0 warnings, 15 lines checked

Your patch has no obvious style problems and is ready for submission.

Please run checkpatch prior to sending patches

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/libata-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/ata/libata-core.c~libata-fix-early-use-of-port-printk-checkpatch-fixes drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-fix-early-use-of-port-printk-checkpatch-fixes
+++ a/drivers/ata/libata-core.c
@@ -6994,7 +6994,9 @@ int ata_host_start(struct ata_host *host
 			rc = ap->ops->port_start(ap);
 			if (rc) {
 				if (rc != -ENODEV)
-					dev_printk(KERN_ERR, host->dev, "failed to start port %d (errno=%d)\n", i, rc);
+					dev_printk(KERN_ERR, host->dev,
+						"failed to start port %d "
+						"(errno=%d)\n", i, rc);
 				goto err_out;
 			}
 		}
_
