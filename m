From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH 1/3] libata: zpodd: should depend on PM_RUNTIME
Date: Fri, 14 Mar 2014 13:46:08 +0800
Message-ID: <1394775970-6022-2-git-send-email-aaron.lu@intel.com>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:37840 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbaCNFpl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 01:45:41 -0400
In-Reply-To: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

ZPODD is built on top of runtime PM functionality, it doesn't make sense
to have it in a kernel that doesn't have CONFIG_PM_RUNTIME set.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 93fc2f052645..e4e608c72e01 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -60,7 +60,7 @@ config ATA_ACPI
 
 config SATA_ZPODD
 	bool "SATA Zero Power Optical Disc Drive (ZPODD) support"
-	depends on ATA_ACPI
+	depends on ATA_ACPI && PM_RUNTIME
 	default n
 	help
 	  This option adds support for SATA Zero Power Optical Disc
-- 
1.8.5.3

