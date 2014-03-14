From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ata: Fix SC1200 dependencies
Date: Fri, 14 Mar 2014 15:41:31 +0100
Message-ID: <20140314154131.75f5a2a0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33355 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753927AbaCNOld (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 10:41:33 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>

The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
its drivers are only needed on this architecture, except for build
testing purpose.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Tejun Heo <tj@kernel.org>
---
 drivers/ata/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/ata/Kconfig	2014-03-11 12:45:02.851927304 +0100
+++ linux-3.14-rc6/drivers/ata/Kconfig	2014-03-14 15:32:28.985406221 +0100
@@ -666,7 +666,7 @@ config PATA_RDC
 
 config PATA_SC1200
 	tristate "SC1200 PATA support"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This option enables support for the NatSemi/AMD SC1200 SoC
 	  companion chip used with the Geode processor family.


-- 
Jean Delvare
SUSE L3 Support
