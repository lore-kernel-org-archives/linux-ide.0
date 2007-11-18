From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 19/21] cmd640: fix dependency on IDE_GENERIC
Date: Sun, 18 Nov 2007 23:33:03 +0100
Message-ID: <200711182333.03403.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:49100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbXKRWgw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 17:36:52 -0500
Received: by ug-out-1314.google.com with SMTP id z38so873063ugc
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 14:36:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Make BLK_DEV_CMD640 select IDE_GENERIC.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -327,6 +327,7 @@ config BLK_DEV_PLATFORM
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
 	depends on X86
+	select IDE_GENERIC
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually in combination with a "Neptune" or
