From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ata: ahci_xgene: potential NULL dereference in probe
Date: Fri, 15 May 2015 12:24:15 +0300
Message-ID: <20150515092415.GA21508@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:51405 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbbEOJY3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 May 2015 05:24:29 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Suman Tripathi <stripathi@apm.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

Smatch complains about this potential NULL dereference of "acpi_id".

Fixes: c9802a4be661 ('ata: ahci_xgene: Add AHCI Support for 2nd HW version of APM X-Gene SoC AHCI SATA Host controller.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 2add250..e2c6d9e 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -732,9 +732,7 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 		if (!acpi_id) {
 			dev_warn(&pdev->dev, "No node entry in ACPI table. Assume version1\n");
 			version = XGENE_AHCI_V1;
-		}
-
-		if (acpi_id->driver_data) {
+		} else if (acpi_id->driver_data) {
 			version = (enum xgene_ahci_version) acpi_id->driver_data;
 			status = acpi_get_object_info(ACPI_HANDLE(&pdev->dev), &info);
 			if (ACPI_FAILURE(status)) {
