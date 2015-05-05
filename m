From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
Date: Tue,  5 May 2015 12:14:03 +0300
Message-ID: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64418 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965632AbbEEJOI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 May 2015 05:14:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, Julian Margetson <runaway@candw.ms>, linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
user can still compile it.

Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ee5209f..9dca4b9 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -270,6 +270,7 @@ config ATA_PIIX
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
 	depends on 460EX
+	select DW_DMAC
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
-- 
2.1.4

