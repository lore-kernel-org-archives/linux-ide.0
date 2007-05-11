From: akpm@linux-foundation.org
Subject: [patch 2/2] Use menuconfig objects: IDE
Date: Thu, 10 May 2007 22:50:30 -0700
Message-ID: <200705110550.l4B5oUu8007726@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:41138 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754848AbXEKFvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 May 2007 01:51:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, jengelh@linux01.gwdg.de, jengelh@gmx.de

From: Jan Engelhardt <jengelh@linux01.gwdg.de>

Use menuconfigs instead of menus, so the whole menu can be disabled at once
instead of going through all options.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ide/Kconfig |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff -puN drivers/ide/Kconfig~use-menuconfig-objects-ide drivers/ide/Kconfig
--- a/drivers/ide/Kconfig~use-menuconfig-objects-ide
+++ a/drivers/ide/Kconfig
@@ -4,13 +4,10 @@
 # Andre Hedrick <andre@linux-ide.org>
 #
 
-if BLOCK
-
-menu "ATA/ATAPI/MFM/RLL support"
-	depends on HAS_IOMEM
-
-config IDE
+menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
+	depends on BLOCK
+	depends on HAS_IOMEM
 	---help---
 	  If you say Y here, your kernel will be able to manage low cost mass
 	  storage units such as ATA/(E)IDE and ATAPI units. The most common
@@ -1099,8 +1096,4 @@ config BLK_DEV_HD_ONLY
 config BLK_DEV_HD
 	def_bool BLK_DEV_HD_IDE || BLK_DEV_HD_ONLY
 
-endif
-
-endmenu
-
-endif
+endif # IDE
_
