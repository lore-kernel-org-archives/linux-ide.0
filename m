From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: make CONFIG_IDE_GENERIC default to N
Date: Sat, 28 Jul 2007 16:34:43 +0900
Message-ID: <46AAF193.1050203@gmail.com>
References: <469E2F81.8080002@alcatel-lucent.com> <46A661C9.4010900@alcatel-lucent.com> <46A8393E.4040603@gmail.com> <200707262111.35691.bzolnier@gmail.com> <46A97014.9030608@gmail.com> <46A9E797.5010708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:64419 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759238AbXG1Hes (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Jul 2007 03:34:48 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1163113wah
        for <linux-ide@vger.kernel.org>; Sat, 28 Jul 2007 00:34:47 -0700 (PDT)
In-Reply-To: <46A9E797.5010708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, "P.C.Chan" <pc.chan@alcatel-lucent.com>, linux-ide@vger.kernel.org

These days, CONFIG_IDE_GENERIC causes more confusion and
misconfiguration than it helps.  Especially so because libata is
linked after the generic driver.  Default to N.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Aye, aye.

 drivers/ide/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index b1a9b81..0a801c6 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -304,9 +304,8 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
-	default y
 	help
-	  If unsure, say Y.
+	  If unsure, say N.
 
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
