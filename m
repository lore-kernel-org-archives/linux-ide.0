From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 2/3] libata: acpi: avoid passing NULL to ACPI evaluation method
Date: Fri, 14 Mar 2014 13:46:09 +0800
Message-ID: <1394775970-6022-3-git-send-email-aaron.lu@intel.com>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59736 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172AbaCNFpn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 01:45:43 -0400
In-Reply-To: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

If ACPI handle for an ATA device is NULL, we shouldn't call
ata_dev_get_GTF as that function will use handle to do some ACPI
evaluation.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/libata-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9e69a5308693..b4f7cc2522d9 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -835,6 +835,7 @@ void ata_acpi_on_resume(struct ata_port *ap)
 		ata_for_each_dev(dev, &ap->link, ALL) {
 			ata_acpi_clear_gtf(dev);
 			if (ata_dev_enabled(dev) &&
+			    ata_dev_acpi_handle(dev) &&
 			    ata_dev_get_GTF(dev, NULL) >= 0)
 				dev->flags |= ATA_DFLAG_ACPI_PENDING;
 		}
-- 
1.8.5.3

