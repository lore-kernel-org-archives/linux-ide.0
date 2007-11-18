From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/21] ide: add CONFIG_IDE_H8300 config option
Date: Sun, 18 Nov 2007 23:15:52 +0100
Message-ID: <200711182315.52981.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48323 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbXKRWgd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:33 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873016ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Add a separate config option for ide-8300 host driver instead of depending
on CONFIG_H8300.

This change is a preparation for the future changes and also allows ide-h8300
to be disabled if needed.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig  |    9 ++++++++-
 drivers/ide/Makefile |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -313,7 +313,6 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
-	default H8300
 	help
 	  If unsure, say N.
 
@@ -871,6 +870,14 @@ config BLK_DEV_IDE_BAST
 	  Say Y here if you want to support the onboard IDE channels on the
 	  Simtec BAST or the Thorcom VR1000
 
+config IDE_H8300
+	bool "H8300 IDE support"
+	depends on H8300
+	select IDE_GENERIC
+	default y
+	help
+	  Enables the H8300 IDE driver.
+
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -39,7 +39,7 @@ ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+=
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
 
 # built-in only drivers from h8300/
-ide-core-$(CONFIG_H8300)		+= h8300/ide-h8300.o
+ide-core-$(CONFIG_IDE_H8300)		+= h8300/ide-h8300.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
