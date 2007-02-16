From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] use winbond libata instead of ide driver for pseries CD drives
Date: Fri, 16 Feb 2007 10:20:46 +0100
Message-ID: <20070216092046.GA2572@aepfle.de>
References: <20070210203512.GA25586@aepfle.de> <20070210203614.GA25602@aepfle.de> <45D4E82B.7020403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53338 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423463AbXBPJUi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Feb 2007 04:20:38 -0500
Content-Disposition: inline
In-Reply-To: <45D4E82B.7020403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Paul Mackeras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org


Change the default for the built-in IDE on p610/p615/p630 from
ide to libata. libata has better error handling and the drive can
recover when hald does its CD media polling.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/configs/ppc64_defconfig   |    4 ++--
 arch/powerpc/configs/pseries_defconfig |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
===================================================================
--- linux-2.6.20.orig/arch/powerpc/configs/ppc64_defconfig
+++ linux-2.6.20/arch/powerpc/configs/ppc64_defconfig
@@ -500,7 +500,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
-CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -646,7 +646,7 @@ CONFIG_SATA_SVW=y
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
-# CONFIG_PATA_WINBOND is not set
+CONFIG_PATA_WINBOND=y
 
 #
 # Multi-device support (RAID and LVM)
Index: linux-2.6.20/arch/powerpc/configs/pseries_defconfig
===================================================================
--- linux-2.6.20.orig/arch/powerpc/configs/pseries_defconfig
+++ linux-2.6.20/arch/powerpc/configs/pseries_defconfig
@@ -483,7 +483,7 @@ CONFIG_BLK_DEV_AMD74XX=y
 # CONFIG_BLK_DEV_PDC202XX_NEW is not set
 # CONFIG_BLK_DEV_SVWKS is not set
 # CONFIG_BLK_DEV_SIIMAGE is not set
-CONFIG_BLK_DEV_SL82C105=y
+# CONFIG_BLK_DEV_SL82C105 is not set
 # CONFIG_BLK_DEV_SLC90E66 is not set
 # CONFIG_BLK_DEV_TRM290 is not set
 # CONFIG_BLK_DEV_VIA82CXXX is not set
@@ -628,7 +628,7 @@ CONFIG_ATA=y
 # CONFIG_PATA_SIL680 is not set
 # CONFIG_PATA_SIS is not set
 # CONFIG_PATA_VIA is not set
-# CONFIG_PATA_WINBOND is not set
+CONFIG_PATA_WINBOND=y
 
 #
 # Multi-device support (RAID and LVM)
