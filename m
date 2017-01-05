From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
Subject: [PATCH] ata: ahci_xgene: free structure returned by acpi_get_object_info()
Date: Thu,  5 Jan 2017 15:14:01 +0100
Message-ID: <20170105141401.4896-1-kernel@kempniu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33915 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032590AbdAEOOU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Jan 2017 09:14:20 -0500
Received: by mail-lf0-f67.google.com with SMTP id d16so35354349lfb.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Jan 2017 06:14:14 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_get_object_info() allocates the returned structure, which the
caller has to free when the call succeeds.  Free it when appropriate.

Fixes: c9802a4be661 ("ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.")
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/ata/ahci_xgene.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 73b19b277138..c2b5941d9184 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -821,8 +821,10 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 				dev_warn(&pdev->dev, "%s: Error reading device info. Assume version1\n",
 					__func__);
 				version = XGENE_AHCI_V1;
-			} else if (info->valid & ACPI_VALID_CID) {
-				version = XGENE_AHCI_V2;
+			} else {
+				if (info->valid & ACPI_VALID_CID)
+					version = XGENE_AHCI_V2;
+				kfree(info);
 			}
 		}
 	}
-- 
2.11.0

