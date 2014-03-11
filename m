From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] ata: Fix CS55xx dependencies
Date: Tue, 11 Mar 2014 12:55:24 +0100
Message-ID: <20140311125524.673b62a3@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53032 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752853AbaCKLz1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 11 Mar 2014 07:55:27 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

As far as I know, the CS5520 and CS5530 chipsets were only used with
32-bit x86 Geode processors, so I think their drivers are only needed
on this architecture, except for build testing purpose.

While we're here, simplify the dependencies for the CS5535 driver.

The CS5536 was used with the Geode processors, but also on MIPS
Loongson/Lemote 2 systems, so let its driver be built for these two
architectures only, except for build testing purpose.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
---
As suggested by Alan.

 drivers/ata/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-3.14-rc6.orig/drivers/ata/Kconfig	2014-03-11 10:02:46.229292247 +0100
+++ linux-3.14-rc6/drivers/ata/Kconfig	2014-03-11 10:08:03.665076546 +0100
@@ -403,7 +403,7 @@ config PATA_CMD64X
 
 config PATA_CS5520
 	tristate "CS5510/5520 PATA support"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This option enables support for the Cyrix 5510/5520
 	  companion chip used with the MediaGX/Geode processor family.
@@ -412,7 +412,7 @@ config PATA_CS5520
 
 config PATA_CS5530
 	tristate "CS5530 PATA support"
-	depends on PCI
+	depends on PCI && (X86_32 || COMPILE_TEST)
 	help
 	  This option enables support for the Cyrix/NatSemi/AMD CS5530
 	  companion chip used with the MediaGX/Geode processor family.
@@ -421,7 +421,7 @@ config PATA_CS5530
 
 config PATA_CS5535
 	tristate "CS5535 PATA support (Experimental)"
-	depends on PCI && X86 && !X86_64
+	depends on PCI && X86_32
 	help
 	  This option enables support for the NatSemi/AMD CS5535
 	  companion chip used with the Geode processor family.
@@ -430,7 +430,7 @@ config PATA_CS5535
 
 config PATA_CS5536
 	tristate "CS5536 PATA support"
-	depends on PCI
+	depends on PCI && (X86_32 || MIPS || COMPILE_TEST)
 	help
 	  This option enables support for the AMD CS5536
 	  companion chip used with the Geode LX processor family.


-- 
Jean Delvare
SUSE L3 Support
