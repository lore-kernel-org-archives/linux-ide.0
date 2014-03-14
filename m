From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ide: Fix SC1200 dependencies
Date: Fri, 14 Mar 2014 17:54:31 +0100
Message-ID: <20140314175431.60e30b07@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35876 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066AbaCNQye (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 12:54:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>

The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
its drivers are only needed on this architecture, except for build
testing purpose.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/ide/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.14-rc6.orig/drivers/ide/Kconfig	2014-03-11 12:14:40.576766722 +0100
+++ linux-3.14-rc6/drivers/ide/Kconfig	2014-03-14 17:51:31.224490902 +0100
@@ -488,6 +488,7 @@ config BLK_DEV_JMICRON
 
 config BLK_DEV_SC1200
 	tristate "National SCx200 chipset support"
+	depends on X86_32 || COMPILE_TEST
 	select BLK_DEV_IDEDMA_PCI
 	help
 	  This driver adds support for the on-board IDE controller on the


-- 
Jean Delvare
SUSE L3 Support
