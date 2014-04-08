From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ata: fix i.MX AHCI driver dependencies
Date: Tue, 8 Apr 2014 11:06:26 +0200
Message-ID: <20140408110626.0eebbbf2@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55143 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbaDHJGa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2014 05:06:30 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Richard Zhu <r65037@freescale.com>

The ahci_imx driver is only needed on Freescale i.MX platforms so
don't let it be built on other platforms, except for build test
purpose.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Richard Zhu <r65037@freescale.com>
---
 drivers/ata/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.15-rc0.orig/drivers/ata/Kconfig	2014-04-07 10:23:04.083158535 +0200
+++ linux-3.15-rc0/drivers/ata/Kconfig	2014-04-08 10:57:25.301066036 +0200
@@ -116,7 +116,7 @@ config AHCI_ST
 
 config AHCI_IMX
 	tristate "Freescale i.MX AHCI SATA support"
-	depends on MFD_SYSCON
+	depends on MFD_SYSCON && (ARCH_MXC || COMPILE_TEST)
 	help
 	  This option enables support for the Freescale i.MX SoC's
 	  onboard AHCI SATA.


-- 
Jean Delvare
SUSE L3 Support
