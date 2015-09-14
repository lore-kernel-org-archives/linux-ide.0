From: <Yuantian.Tang@freescale.com>
Subject: [PATCH v3] ahci: qoriq: fixed using uninitialized variable warnings
Date: Mon, 14 Sep 2015 15:12:49 +0800
Message-ID: <1442214769-46567-1-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1on0117.outbound.protection.outlook.com ([157.56.110.117]:43840
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751769AbbINHSq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Sep 2015 03:18:46 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hdegoede@redhat.com
Cc: tj@kernel.org, fengguang.wu@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Tang Yuantian <Yuantian.Tang@freescale.com>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

kbuild test robot reports the warnings:
drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
>> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
>> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
>> uninitialized in this function [-Wuninitialized]
drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here

This is caused by openrisc arch's compiler. This driver is for
QorIQ ARM platforms. So add the dependency on ARM to remove
these warnings.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v3:
	- fix it by in a new way
v2:
	- try another way to fix the warnings
	- remove clean up code

 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 6aaa3f8..a830344 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -177,7 +177,7 @@ config AHCI_XGENE
 
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
-	depends on OF
+	depends on OF && ARM
 	help
 	  This option enables support for the Freescale QorIQ AHCI SoC's
 	  onboard AHCI SATA.
-- 
2.1.0.27.g96db324

