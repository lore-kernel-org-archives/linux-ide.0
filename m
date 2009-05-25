From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 2/3] ide: preserve HPA by default
Date: Mon, 25 May 2009 23:44:57 +0200
Message-ID: <200905252344.57797.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:49834 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbZEYVsJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 May 2009 17:48:09 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Add CONFIG_IDE_PRESERVE_HPA config option (enabled by default)
to streamline the transition.

The config option help text is heavily based on Alan's
feedback about the issue.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 Documentation/kernel-parameters.txt |    4 ++--
 drivers/ide/Kconfig                 |   22 ++++++++++++++++++++++
 drivers/ide/ide.c                   |    4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

Index: b/Documentation/kernel-parameters.txt
===================================================================
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -843,8 +843,8 @@ and is between 256 and 4096 characters. 
 			[HW] (E)IDE subsystem
 			Ignore HPA limit
 			Format: { "0" | "1" }
-			0 -- keep BIOS limits
-			1 -- ignore limits, using full disk (default)
+			0 -- keep BIOS limits (default)
+			1 -- ignore limits, using full disk
 
 	ide-pci-generic.all-generic-ide [HW] (E)IDE subsystem
 			Claim all unknown PCI IDE storage controllers.
Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -91,6 +91,28 @@ config BLK_DEV_IDE_SATA
 
 	  If unsure, say N.
 
+config IDE_PRESERVE_HPA
+	bool "Preserve Host Protected Area (please read help)"
+	default y
+	help
+	  From the majority of modern users perspectives ignoring the HPA
+	  breaks vendor RAID formats, GPT partitions or risks corrupting
+	  firmware.
+
+	  Unfortunately the original (kernel versions < 2.6.30) behavior
+	  (ignoring HPA, using full disk capacity) was introduced at the
+	  time when the main HPA use was with the jumper (or software)
+	  to make the drive look small enough for the BIOS to allow boot
+	  with big drives.
+
+	  To allow the maximum compatibility with the existing setups
+	  (using HPA and partitioned with HPA disabled) the default HPA
+	  behavior can be also later adjusted using "ignore_hpa" module
+	  parameter (i.e. "ide_core.ignore_hpa=1").
+
+	  Say Y unless you have such setup and for some reason cannot
+	  use "ignore_hpa" module parameter.
+
 config IDE_GD
 	tristate "generic ATA/ATAPI disk support"
 	default y
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -166,7 +166,11 @@ struct bus_type ide_bus_type = {
 
 EXPORT_SYMBOL_GPL(ide_bus_type);
 
+#ifdef CONFIG_IDE_PRESERVE_HPA
+int ide_ignore_hpa = 0;
+#else
 int ide_ignore_hpa = 1;
+#endif
 EXPORT_SYMBOL_GPL(ide_ignore_hpa);
 
 module_param_named(ignore_hpa, ide_ignore_hpa, int, 0);
