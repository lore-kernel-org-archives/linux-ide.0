From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ide: Fix CS5520 and CS5530 dependencies
Date: Tue, 11 Mar 2014 12:44:54 +0100
Message-ID: <20140311124454.1238167f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52788 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504AbaCKLo5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2014 07:44:57 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

As far as I know, the CS5520 and CS5530 chipsets were only used with
32-bit x86 Geode processors, so I think their drivers are only needed
on this architecture, except for build testing purpose.

While we're here, simplify the dependencies for the CS5535 driver.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
As suggested by Alan.

 drivers/ide/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/ide/Kconfig	2014-03-11 11:28:03.447069092 +0100
+++ linux-3.14-rc6/drivers/ide/Kconfig	2014-03-11 12:14:40.576766722 +0100
@@ -416,6 +416,7 @@ config BLK_DEV_CY82C693
 
 config BLK_DEV_CS5520
 	tristate "Cyrix CS5510/20 MediaGX chipset support (VERY EXPERIMENTAL)"
+	depends on X86_32 || COMPILE_TEST
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for PIO tuning and virtual DMA on the Cyrix MediaGX
@@ -426,6 +427,7 @@ config BLK_DEV_CS5520
 
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
+	depends on X86_32 || COMPILE_TEST
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for UDMA on the Cyrix MediaGX 5530 chipset. This
@@ -435,7 +437,7 @@ config BLK_DEV_CS5530
 
 config BLK_DEV_CS5535
 	tristate "AMD CS5535 chipset support"
-	depends on X86 && !X86_64
+	depends on X86_32
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for UDMA on the NSC/AMD CS5535 companion chipset.


-- 
Jean Delvare
SUSE L3 Support
