From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Update experimental tags to reflect reality better
Date: Thu, 20 Sep 2007 14:58:48 +0100
Message-ID: <20070920145848.763ac782@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47857 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753216AbXITNwN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 09:52:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/Kconfig linux-2.6.23rc6-mm1/drivers/ata/Kconfig
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/Kconfig	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/Kconfig	2007-09-19 15:54:54.893211536 +0100
@@ -201,8 +201,8 @@
 	  If unsure, say N.
 
 config PATA_ARTOP
-	tristate "ARTOP 6210/6260 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "ARTOP 6210/6260 PATA support"
+	depends on PCI
 	help
 	  This option enables support for ARTOP PATA controllers.
 
@@ -218,8 +218,8 @@
 	  If unsure, say N.
 
 config PATA_ATIIXP
-	tristate "ATI PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "ATI PATA support"
+	depends on PCI
 	help
 	  This option enables support for the ATI ATA interfaces
 	  found on the many ATI chipsets.
@@ -237,8 +237,8 @@
 	  If unsure, say N.
 
 config PATA_CMD64X
-	tristate "CMD64x PATA support (Very Experimental)"
-	depends on PCI&& EXPERIMENTAL
+	tristate "CMD64x PATA support"
+	depends on PCI
 	help
 	  This option enables support for the CMD64x series chips
 	  except for the CMD640.
@@ -300,8 +300,8 @@
 	  If unsure, say N.
 
 config PATA_HPT366
-	tristate "HPT 366/368 PATA support (Experimental)"
-	depends on PCI && EXPERIMENTAL
+	tristate "HPT 366/368 PATA support"
+	depends on PCI
 	help
 	  This option enables support for the HPT 366 and 368
 	  PATA controllers via the new ATA layer.
