From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH 1/2] scc_pata: dependency fix
Date: Fri, 16 Mar 2007 11:05:27 +0900
Message-ID: <200703160203.l2G23QNH008038@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:55006 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbXCPCD3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 22:03:29 -0400
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l2G23R0s009540
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 11:03:27 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l2G23RCC003995
	for linux-ide@vger.kernel.org; Fri, 16 Mar 2007 11:03:27 +0900 (JST)
Received: from mx2.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l2G23Q0D011356
	for <linux-ide@vger.kernel.org>; Fri, 16 Mar 2007 11:03:26 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, torvalds@linux-foundation.org
Cc: Al Viro <viro@ftp.linux.org.uk>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

This patch fixes:
* the dependency of scc_pata on BLK_DEV_IDEDMA_PCI
* incorrect link to ide-core
* move scc_pata from ide/ppc to ide/pci

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ide/Kconfig linux-2.6.21-rc3.mod/drivers/ide/Kconfig
--- linux-2.6.21-rc3/drivers/ide/Kconfig	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ide/Kconfig	2007-03-16 18:49:04.000000000 +0900
@@ -769,6 +769,14 @@ config BLK_DEV_TC86C001
 	help
 	This driver adds support for Toshiba TC86C001 GOKU-S chip.
 
+config BLK_DEV_CELLEB
+	tristate "Toshiba's Cell Reference Set IDE support"
+	depends on PPC_CELLEB
+	help
+	  This driver provides support for the built-in IDE controller on
+	  Toshiba Cell Reference Board.
+	  If unsure, say Y.
+
 endif
 
 config BLK_DEV_IDE_PMAC
@@ -800,14 +808,6 @@ config BLK_DEV_IDEDMA_PMAC
 	  to transfer data to and from memory.  Saying Y is safe and improves
 	  performance.
 
-config BLK_DEV_IDE_CELLEB
-	bool "Toshiba's Cell Reference Set IDE support"
-	depends on PPC_CELLEB
-	help
-	  This driver provides support for the built-in IDE controller on
-	  Toshiba Cell Reference Board.
-	  If unsure, say Y.
-
 config BLK_DEV_IDE_SWARM
 	tristate "IDE for Sibyte evaluation boards"
 	depends on SIBYTE_SB1xxx_SOC
diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ide/Makefile linux-2.6.21-rc3.mod/drivers/ide/Makefile
--- linux-2.6.21-rc3/drivers/ide/Makefile	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ide/Makefile	2007-03-16 18:48:02.000000000 +0900
@@ -37,7 +37,6 @@ ide-core-$(CONFIG_BLK_DEV_Q40IDE)	+= leg
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
-ide-core-$(CONFIG_BLK_DEV_IDE_CELLEB)	+= ppc/scc_pata.o
 
 # built-in only drivers from h8300/
 ide-core-$(CONFIG_H8300)		+= h8300/ide-h8300.o
diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ide/pci/Makefile linux-2.6.21-rc3.mod/drivers/ide/pci/Makefile
--- linux-2.6.21-rc3/drivers/ide/pci/Makefile	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ide/pci/Makefile	2007-03-16 18:49:05.000000000 +0900
@@ -3,6 +3,7 @@ obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62x
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
 obj-$(CONFIG_BLK_DEV_ATIIXP)		+= atiixp.o
+obj-$(CONFIG_BLK_DEV_CELLEB)		+= scc_pata.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
