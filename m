From: Minwoo Im <dn3108@gmail.com>
Subject: [PATCH] libahci: code indent should use tabs where possible ERROR fix.
Date: Sat, 17 Jun 2017 15:45:19 +0900
Message-ID: <1497681919-5290-1-git-send-email-dn3108@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34019 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdFQGp0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 17 Jun 2017 02:45:26 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so9122728pge.1
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2017 23:45:26 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Minwoo Im <dn3108@gmail.com>

libahci.c has been fixed for this error by replacing
white space with tab.

Signed-off-by: Minwoo Im <dn3108@gmail.com>
---
 drivers/ata/libahci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3159f9e..4c16736 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2568,7 +2568,7 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
 		if (hpriv->irq_handler)
 			dev_warn(host->dev,
-			         "both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented\n");
+				"both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented\n");
 		if (!hpriv->get_irq_vector) {
 			dev_err(host->dev,
 				"AHCI_HFLAG_MULTI_MSI requires ->get_irq_vector!\n");
-- 
1.7.9.5

