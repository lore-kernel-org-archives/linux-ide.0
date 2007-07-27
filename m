From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ide: make CONFIG_IDE_GENERIC default to N
Date: Fri, 27 Jul 2007 13:09:56 +0900
Message-ID: <46A97014.9030608@gmail.com>
References: <469E2F81.8080002@alcatel-lucent.com> <46A661C9.4010900@alcatel-lucent.com> <46A8393E.4040603@gmail.com> <200707262111.35691.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:16950 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXG0EKC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 00:10:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so74789rvb
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 21:10:01 -0700 (PDT)
In-Reply-To: <200707262111.35691.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "P.C.Chan" <pc.chan@alcatel-lucent.com>, linux-ide@vger.kernel.org

These days, CONFIG_IDE_GENERIC causes more confusion and
misconfiguration than it helps.  Especially so because libata is
linked after the generic driver.  Default to N.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ide/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index b1a9b81..8113909 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -304,9 +304,9 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
-	default y
+	default n
 	help
-	  If unsure, say Y.
+	  If unsure, say N.
 
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
