From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] remove CONFIG_IDEDMA_PCI_WIP
Date: Wed, 4 Feb 2004 02:35:42 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402040235.42640.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:56029 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264437AbUBDBbV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2004 20:31:21 -0500
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


[PATCH] remove CONFIG_IDEDMA_PCI_WIP

Fix CONFIG_HPT34X_AUTODMA to depend directly on CONFIG_EXPERIMENTAL
and finally remove CONFIG_IDEDMA_PCI_WIP.

 linux-2.6.2-rc3-bk3-root/arch/alpha/defconfig                 |    1 
 linux-2.6.2-rc3-bk3-root/arch/arm/configs/iq80321_defconfig   |    1 
 linux-2.6.2-rc3-bk3-root/arch/arm/configs/netwinder_defconfig |    1 
 linux-2.6.2-rc3-bk3-root/arch/i386/defconfig                  |    1 
 linux-2.6.2-rc3-bk3-root/arch/ia64/configs/generic_defconfig  |    1 
 linux-2.6.2-rc3-bk3-root/arch/ia64/configs/sn2_defconfig      |    1 
 linux-2.6.2-rc3-bk3-root/arch/ia64/defconfig                  |    1 
 linux-2.6.2-rc3-bk3-root/arch/mips/defconfig-lasat200         |    1 
 linux-2.6.2-rc3-bk3-root/arch/ppc/configs/common_defconfig    |    1 
 linux-2.6.2-rc3-bk3-root/arch/ppc/configs/pmac_defconfig      |    1 
 linux-2.6.2-rc3-bk3-root/arch/ppc/defconfig                   |    1 
 linux-2.6.2-rc3-bk3-root/arch/sparc64/defconfig               |    1 
 linux-2.6.2-rc3-bk3-root/arch/x86_64/defconfig                |    1 
 linux-2.6.2-rc3-bk3-root/drivers/ide/Kconfig                  |   14 +---------
 14 files changed, 2 insertions(+), 25 deletions(-)

diff -puN arch/alpha/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/alpha/defconfig
--- linux-2.6.2-rc3-bk3/arch/alpha/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:45:57.635462808 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/alpha/defconfig	2004-02-04 01:46:02.909661008 +0100
@@ -155,7 +155,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
diff -puN arch/arm/configs/iq80321_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/arm/configs/iq80321_defconfig
--- linux-2.6.2-rc3-bk3/arch/arm/configs/iq80321_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:49:23.846114024 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/arm/configs/iq80321_defconfig	2004-02-04 01:49:42.927213256 +0100
@@ -441,7 +441,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/arm/configs/netwinder_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/arm/configs/netwinder_defconfig
--- linux-2.6.2-rc3-bk3/arch/arm/configs/netwinder_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:49:13.997611224 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/arm/configs/netwinder_defconfig	2004-02-04 01:49:36.174239864 +0100
@@ -439,7 +439,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/i386/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/i386/defconfig
--- linux-2.6.2-rc3-bk3/arch/i386/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:47:58.320115952 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/i386/defconfig	2004-02-04 01:48:04.903115184 +0100
@@ -274,7 +274,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ia64/configs/generic_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ia64/configs/generic_defconfig
--- linux-2.6.2-rc3-bk3/arch/ia64/configs/generic_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:47:25.238145176 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ia64/configs/generic_defconfig	2004-02-04 01:47:33.532884184 +0100
@@ -191,7 +191,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ia64/configs/sn2_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ia64/configs/sn2_defconfig
--- linux-2.6.2-rc3-bk3/arch/ia64/configs/sn2_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:47:20.866809720 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ia64/configs/sn2_defconfig	2004-02-04 01:47:37.030352488 +0100
@@ -170,7 +170,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ia64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ia64/defconfig
--- linux-2.6.2-rc3-bk3/arch/ia64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:46:50.696396320 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ia64/defconfig	2004-02-04 01:46:59.326084408 +0100
@@ -188,7 +188,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/mips/defconfig-lasat200~CONFIG_IDEDMA_PCI_WIP_cleanup arch/mips/defconfig-lasat200
--- linux-2.6.2-rc3-bk3/arch/mips/defconfig-lasat200~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:46:25.297257576 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/mips/defconfig-lasat200	2004-02-04 01:46:36.529550008 +0100
@@ -254,7 +254,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ppc/configs/common_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ppc/configs/common_defconfig
--- linux-2.6.2-rc3-bk3/arch/ppc/configs/common_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:48:40.960633608 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ppc/configs/common_defconfig	2004-02-04 01:48:53.836676152 +0100
@@ -210,7 +210,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ppc/configs/pmac_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ppc/configs/pmac_defconfig
--- linux-2.6.2-rc3-bk3/arch/ppc/configs/pmac_defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:48:44.436105256 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ppc/configs/pmac_defconfig	2004-02-04 01:48:58.916903840 +0100
@@ -217,7 +217,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/ppc/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/ppc/defconfig
--- linux-2.6.2-rc3-bk3/arch/ppc/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:48:19.273930488 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/ppc/defconfig	2004-02-04 01:48:26.437841408 +0100
@@ -218,7 +218,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN arch/sparc64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/sparc64/defconfig
--- linux-2.6.2-rc3-bk3/arch/sparc64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:45:28.861837064 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/sparc64/defconfig	2004-02-04 01:45:37.420535944 +0100
@@ -242,7 +242,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_IDEDMA_ONLYDISK=y
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
diff -puN arch/x86_64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup arch/x86_64/defconfig
--- linux-2.6.2-rc3-bk3/arch/x86_64/defconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:44:39.027413048 +0100
+++ linux-2.6.2-rc3-bk3-root/arch/x86_64/defconfig	2004-02-04 01:44:58.528448440 +0100
@@ -191,7 +191,6 @@ CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-# CONFIG_IDEDMA_PCI_WIP is not set
 CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -puN drivers/ide/Kconfig~CONFIG_IDEDMA_PCI_WIP_cleanup drivers/ide/Kconfig
--- linux-2.6.2-rc3-bk3/drivers/ide/Kconfig~CONFIG_IDEDMA_PCI_WIP_cleanup	2004-02-04 01:39:30.896256104 +0100
+++ linux-2.6.2-rc3-bk3-root/drivers/ide/Kconfig	2004-02-04 01:40:45.188961896 +0100
@@ -511,16 +511,6 @@ config IDEDMA_ONLYDISK
 
 	  Generally say N here.
 
-config IDEDMA_PCI_WIP
-	bool "ATA Work(s) In Progress (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
-	help
-	  If you enable this you will be able to use and test highly
-	  developmental projects. If you say N, the configurator will
-	  simply skip those options.
-
-	  It is SAFEST to say N to this question.
-
 config BLK_DEV_ADMA
 	bool
 	depends on PCI && BLK_DEV_IDEPCI
@@ -619,8 +609,8 @@ config BLK_DEV_HPT34X
 	  DVD II drives, by the manufacturer.
 
 config HPT34X_AUTODMA
-	bool "HPT34X AUTODMA support (WIP)"
-	depends on BLK_DEV_HPT34X && IDEDMA_PCI_WIP
+	bool "HPT34X AUTODMA support (EXPERIMENTAL)"
+	depends on BLK_DEV_HPT34X && EXPERIMENTAL
 	help
 	  This is a dangerous thing to attempt currently! Please read the
 	  comments at the top of <file:drivers/ide/pci/hpt34x.c>.  If you say Y

_

