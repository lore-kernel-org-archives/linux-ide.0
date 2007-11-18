From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/21] ide: move CONFIG_IDE_ETRAX to drivers/ide/Kconfig
Date: Sun, 18 Nov 2007 23:17:04 +0100
Message-ID: <200711182317.04300.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbXKRWge (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:34 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:34 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>


* Move ETRAX_IDE and friends from arch/cris/arch-{v10,v32}/drivers/Kconfig
  to drivers/ide/Kconfig.

* Don't force selecting ide-disk and ide-cd device drivers
  (please handle this through defconfig if necessary).

* Make ETRAX_IDE depend on BROKEN for the time being
  (it doesn't even compile currently).

Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 arch/cris/arch-v10/drivers/Kconfig |   39 -------------------------------------
 arch/cris/arch-v32/drivers/Kconfig |   12 -----------
 drivers/ide/Kconfig                |   35 +++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 51 deletions(-)

Index: b/arch/cris/arch-v10/drivers/Kconfig
===================================================================
--- a/arch/cris/arch-v10/drivers/Kconfig
+++ b/arch/cris/arch-v10/drivers/Kconfig
@@ -542,45 +542,6 @@ config ETRAX_RS485_DISABLE_RECEIVER
 	  loopback.  Not all products are able to do this in software only.
 	  Axis 2400/2401 must disable receiver.
 
-config ETRAX_IDE
-	bool "ATA/IDE support"
-	select IDE
-	select BLK_DEV_IDE
-	select BLK_DEV_IDEDISK
-	select BLK_DEV_IDECD
-	select BLK_DEV_IDEDMA
-	select IDE_GENERIC
-	help
-	  Enable this to get support for ATA/IDE.
-	  You can't use parallel ports or SCSI ports
-	  at the same time.
-
-
-config ETRAX_IDE_DELAY
-	int "Delay for drives to regain consciousness"
-	depends on ETRAX_IDE
-	default 15
-	help
-	  Number of seconds to wait for IDE drives to spin up after an IDE
-	  reset.
-choice
-	prompt "IDE reset pin"
-	depends on ETRAX_IDE
-	default ETRAX_IDE_PB7_RESET
-
-config ETRAX_IDE_PB7_RESET
-	bool "Port_PB_Bit_7"
-	help
-	  IDE reset on pin 7 on port B
-
-config ETRAX_IDE_G27_RESET
-	bool "Port_G_Bit_27"
-	help
-	  IDE reset on pin 27 on port G
-
-endchoice
-
-
 config ETRAX_USB_HOST
 	bool "USB host"
 	select USB
Index: b/arch/cris/arch-v32/drivers/Kconfig
===================================================================
--- a/arch/cris/arch-v32/drivers/Kconfig
+++ b/arch/cris/arch-v32/drivers/Kconfig
@@ -582,18 +582,6 @@ config ETRAX_PE_CHANGEABLE_BITS
 	  that a user can change the value on using ioctl's.
 	  Bit set = changeable.
 
-config ETRAX_IDE
-	bool "ATA/IDE support"
-	depends on ETRAX_ARCH_V32
-	select IDE
-	select BLK_DEV_IDE
-	select BLK_DEV_IDEDISK
-	select BLK_DEV_IDECD
-	select BLK_DEV_IDEDMA
-	select IDE_GENERIC
-	help
-	  Enables the ETRAX IDE driver.
-
 config ETRAX_CARDBUS
         bool "Cardbus support"
         depends on ETRAX_ARCH_V32
Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -870,6 +870,41 @@ config BLK_DEV_IDE_BAST
 	  Say Y here if you want to support the onboard IDE channels on the
 	  Simtec BAST or the Thorcom VR1000
 
+config ETRAX_IDE
+	bool "ETRAX IDE support"
+	depends on CRIS && BROKEN
+	select BLK_DEV_IDEDMA
+	select IDE_GENERIC
+	help
+	  Enables the ETRAX IDE driver.
+
+	  You can't use parallel ports or SCSI ports at the same time.
+
+config ETRAX_IDE_DELAY
+	int "Delay for drives to regain consciousness"
+	depends on ETRAX_IDE && ETRAX_ARCH_V10
+	default 15
+	help
+	  Number of seconds to wait for IDE drives to spin up after an IDE
+	  reset.
+
+choice
+	prompt "IDE reset pin"
+	depends on ETRAX_IDE && ETRAX_ARCH_V10
+	default ETRAX_IDE_PB7_RESET
+
+config ETRAX_IDE_PB7_RESET
+	bool "Port_PB_Bit_7"
+	help
+	  IDE reset on pin 7 on port B
+
+config ETRAX_IDE_G27_RESET
+	bool "Port_G_Bit_27"
+	help
+	  IDE reset on pin 27 on port G
+
+endchoice
+
 config IDE_H8300
 	bool "H8300 IDE support"
 	depends on H8300
