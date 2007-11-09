From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] BLK_DEV_IDECD help: remove outdated note
Date: Fri, 9 Nov 2007 07:01:53 +0100
Message-ID: <20071109060153.GN26163@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52837 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbXKIGCQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Nov 2007 01:02:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

LILO version 16 was released on 26-02-1995 (sic), so telling people to 
not use older versions no longer has any value.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
b79ad8a00e9bc0008b42eafd5863d758109d0594 
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index d1e8df1..e445fe6 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -203,10 +203,6 @@ config BLK_DEV_IDECD
 	  CD-ROM drive, you can say N to all other CD-ROM options, but be sure
 	  to say Y or M to "ISO 9660 CD-ROM file system support".
 
-	  Note that older versions of LILO (LInux LOader) cannot properly deal
-	  with IDE/ATAPI CD-ROMs, so install LILO 16 or higher, available from
-	  <http://lilo.go.dyndns.org/>.
-
 	  To compile this driver as a module, choose M here: the
 	  module will be called ide-cd.
 

