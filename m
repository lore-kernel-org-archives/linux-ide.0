From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide/Kconfig: fix BLK_DEV_OFFBOARD dependencies
Date: Sat, 27 Oct 2007 18:18:12 +0200
Message-ID: <200710271818.12536.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:7158 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbXJ0QMO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Oct 2007 12:12:14 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1087790fkz
        for <linux-ide@vger.kernel.org>; Sat, 27 Oct 2007 09:12:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This config option is effective only for host drivers that use
IDE_HFLAG_OFF_BOARD host flag (aec62xx, generic, hpt34x, hpt366,
pdc202xx_new, pdc202xx_old and tc86c001).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -382,9 +382,10 @@ config BLK_DEV_IDEPCI
 config IDEPCI_PCIBUS_ORDER
 	def_bool BLK_DEV_IDE=y && BLK_DEV_IDEPCI
 
+# TODO: split it on per host driver config options (or module parameters)
 config BLK_DEV_OFFBOARD
 	bool "Boot off-board chipsets first support"
-	depends on BLK_DEV_IDEPCI
+	depends on BLK_DEV_IDEPCI && (BLK_DEV_AEC62XX || BLK_DEV_GENERIC || BLK_DEV_HPT34X || BLK_DEV_HPT366 || BLK_DEV_PDC202XX_NEW || BLK_DEV_PDC202XX_OLD || BLK_DEV_TC86C001)
 	help
 	  Normally, IDE controllers built into the motherboard (on-board
 	  controllers) are assigned to ide0 and ide1 while those on add-in PCI
