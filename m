From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Subject: [PATCH] drivers/ata/Kconfig: PATA_SCC depends on wrong platform
Date: Thu, 15 Mar 2007 14:32:58 +0900
Message-ID: <200703150530.l2F5Uwel024855@toshiba.co.jp>
Mime-Version: 1.0
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:37191 "EHLO
	inet-tsb5.toshiba.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965345AbXCOFbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 01:31:05 -0400
Received: from tsb-wall.toshiba.co.jp ([133.199.160.134])
	by inet-tsb5.toshiba.co.jp  with ESMTP id l2F5Uxe6006922
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 14:30:59 +0900 (JST)
Received: (from root@localhost)
	by tsb-wall.toshiba.co.jp  id l2F5V0c1002450
	for linux-ide@vger.kernel.org; Thu, 15 Mar 2007 14:31:00 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp1.toshiba.co.jp  with ESMTP id l2F5UxLB001801
	for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 14:30:59 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

PATA_SCC depends on PPC_CELLEB. (not PPC_IBM_CELL_BLADE)

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

diff -Nrpu -X linux-2.6.21-rc3/Documentation/dontdiff linux-2.6.21-rc3/drivers/ata/Kconfig linux-2.6.21-rc3.mod/drivers/ata/Kconfig
--- linux-2.6.21-rc3/drivers/ata/Kconfig	2007-03-07 13:41:20.000000000 +0900
+++ linux-2.6.21-rc3.mod/drivers/ata/Kconfig	2007-03-15 23:04:14.000000000 +0900
@@ -564,7 +564,7 @@ config PATA_IXP4XX_CF
 
 config PATA_SCC
 	tristate "Toshiba's Cell Reference Set IDE support"
-	depends on PCI && PPC_IBM_CELL_BLADE
+	depends on PCI && PPC_CELLEB
 	help
 	  This option enables support for the built-in IDE controller on
 	  Toshiba Cell Reference Board.

