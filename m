From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/21] ide/Kconfig: fix mpc8xx host driver dependencies
Date: Sun, 18 Nov 2007 23:15:19 +0100
Message-ID: <200711182315.19408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:48819 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbXKRWgc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:32 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873018ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:32 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org


Only LWMON, IVMS8, IVML24 and TQM8xxL platforms have the needed
defines (IDE0_BASE_OFFSET and friends) in the platform header file.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -951,7 +951,7 @@ config BLK_DEV_Q40IDE
 
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
-	depends on 8xx && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
+	depends on 8xx && (LWMON || IVMS8 || IVML24 || TQM8xxL) && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
 	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
