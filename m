From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide: fix hidden dependencies on CONFIG_IDE_GENERIC
Date: Thu, 9 Aug 2007 22:12:48 +0200
Message-ID: <200708092212.49070.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:48944 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXHIUQC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Aug 2007 16:16:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so163750nfb
        for <linux-ide@vger.kernel.org>; Thu, 09 Aug 2007 13:16:01 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Some host drivers depend on CONFIG_IDE_GENERIC to do the probing but their
config options lack explicit dependencies on IDE_GENERIC.  In the long-term
these host drivers should be fixed to do the probing themselves but for now
fix them by making their config options select CONFIG_IDE_GENERIC.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/cris/arch-v10/drivers/Kconfig |    1 +
 arch/cris/arch-v32/drivers/Kconfig |    1 +
 drivers/ide/Kconfig                |    9 +++++++++
 3 files changed, 11 insertions(+)

Index: b/arch/cris/arch-v10/drivers/Kconfig
===================================================================
--- a/arch/cris/arch-v10/drivers/Kconfig
+++ b/arch/cris/arch-v10/drivers/Kconfig
@@ -548,6 +548,7 @@ config ETRAX_IDE
 	select BLK_DEV_IDEDISK
 	select BLK_DEV_IDECD
 	select BLK_DEV_IDEDMA
+	select IDE_GENERIC
 	help
 	  Enable this to get support for ATA/IDE.
 	  You can't use parallel ports or SCSI ports
Index: b/arch/cris/arch-v32/drivers/Kconfig
===================================================================
--- a/arch/cris/arch-v32/drivers/Kconfig
+++ b/arch/cris/arch-v32/drivers/Kconfig
@@ -592,6 +592,7 @@ config ETRAX_IDE
 	select BLK_DEV_IDEDISK
 	select BLK_DEV_IDECD
 	select BLK_DEV_IDEDMA
+	select IDE_GENERIC
 	help
 	  Enables the ETRAX IDE driver.
 
Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -304,6 +304,7 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
+	default H8300
 	help
 	  If unsure, say N.
 
@@ -352,6 +353,7 @@ config BLK_DEV_CMD640_ENHANCED
 config BLK_DEV_IDEPNP
 	bool "PNP EIDE support"
 	depends on PNP
+	select IDE_GENERIC
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
 	  would like the kernel to automatically detect and activate
@@ -858,6 +860,7 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
 
 config IDE_ARM
 	def_bool ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
+	select IDE_GENERIC
 
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
@@ -891,6 +894,7 @@ config BLK_DEV_IDE_BAST
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
 	depends on AMIGA
+	select IDE_GENERIC
 	help
 	  This is the IDE driver for the Amiga Gayle IDE interface. It supports
 	  both the `A1200 style' and `A4000 style' of the Gayle IDE interface,
@@ -922,6 +926,7 @@ config BLK_DEV_IDEDOUBLER
 config BLK_DEV_BUDDHA
 	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
 	depends on ZORRO && EXPERIMENTAL
+	select IDE_GENERIC
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha, 
 	  Catweasel and X-Surf expansion boards.  It supports up to two interfaces 
@@ -934,6 +939,7 @@ config BLK_DEV_BUDDHA
 config BLK_DEV_FALCON_IDE
 	bool "Falcon IDE interface support"
 	depends on ATARI
+	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (hard
@@ -943,6 +949,7 @@ config BLK_DEV_FALCON_IDE
 config BLK_DEV_MAC_IDE
 	bool "Macintosh Quadra/Powerbook IDE interface support"
 	depends on MAC
+	select IDE_GENERIC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
@@ -956,6 +963,7 @@ config BLK_DEV_MAC_IDE
 config BLK_DEV_Q40IDE
 	bool "Q40/Q60 IDE interface support"
 	depends on Q40
+	select IDE_GENERIC
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
 	  normally be on; disable it only if you are running a custom hard
@@ -964,6 +972,7 @@ config BLK_DEV_Q40IDE
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
 	depends on 8xx && IDE=y && BLK_DEV_IDE=y
+	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
 	  Please see 'Type of MPC8xx IDE interface' for details.
