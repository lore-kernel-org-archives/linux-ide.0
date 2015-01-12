From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] sata_dwc_460ex: disable compilation on ARM and ARM64
Date: Mon, 12 Jan 2015 14:57:44 +0200
Message-ID: <1421067464-13725-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:25653 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbALM5q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jan 2015 07:57:46 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For now disable the compilation of the driver on ARM and ARM64. In the future
we will fix the DMA handling in that driver and re-enable compilation back.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 5ed20e3..9f2ba27 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -269,7 +269,7 @@ config ATA_PIIX
 
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
-	depends on 460EX || COMPILE_TEST
+	depends on 460EX || (COMPILE_TEST && !(ARM || ARM64))
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
-- 
2.1.4

