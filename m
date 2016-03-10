From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ata: ahci_xgene: dereferencing uninitialized pointer in probe
Date: Thu, 10 Mar 2016 10:45:32 +0300
Message-ID: <20160310074532.GA7163@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42899 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbcCJHpx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2016 02:45:53 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Suman Tripathi <stripathi@apm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

If the call to acpi_get_object_info() fails then "info" hasn't been
initialized.  In that situation, we already know that "version" should
be XGENE_AHCI_V1 so we don't actually need to dereference "info".

Fixes: c9802a4be661 ('ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 8e3f7fa..73b19b2 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -821,9 +821,9 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 				dev_warn(&pdev->dev, "%s: Error reading device info. Assume version1\n",
 					__func__);
 				version = XGENE_AHCI_V1;
-			}
-			if (info->valid & ACPI_VALID_CID)
+			} else if (info->valid & ACPI_VALID_CID) {
 				version = XGENE_AHCI_V2;
+			}
 		}
 	}
 #endif
