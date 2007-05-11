From: akpm@linux-foundation.org
Subject: [patch 13/20] Use menuconfig objects: libata
Date: Thu, 10 May 2007 22:48:54 -0700
Message-ID: <200705110548.l4B5ms5x007651@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:53849 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758097AbXEKFtT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:49:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, jengelh@linux01.gwdg.de, jengelh@gmx.de

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

Use menuconfigs instead of menus, so the whole menu can be disabled at once
instead of going through all options.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/Kconfig |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/ata/Kconfig~use-menuconfig-objects-libata drivers/ata/Kconfig
--- a/drivers/ata/Kconfig~use-menuconfig-objects-libata
+++ a/drivers/ata/Kconfig
@@ -2,11 +2,9 @@
 # SATA/PATA driver configuration
 #
 
-menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+menuconfig ATA
+	tristate "Serial ATA (prod) and Parallel ATA (experimental) drivers"
 	depends on HAS_IOMEM
-
-config ATA
-	tristate "ATA device support"
 	depends on BLOCK
 	depends on !(M32R || M68K) || BROKEN
 	depends on !SUN4 || BROKEN
@@ -594,6 +592,4 @@ config PATA_SCC
 
 	  If unsure, say N.
 
-endif
-endmenu
-
+endif # ATA
_
