From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/10] ide-generic: is no longer needed on ppc32
Date: Mon, 7 Jul 2008 23:56:25 +0200
Message-ID: <200807072356.25250.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:12845 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758705AbYGGWAz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jul 2008 18:00:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1051975ywe.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jul 2008 15:00:55 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
this patch depends on arch/ppc/ removal (already in linux-next)

 drivers/ide/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -314,7 +314,7 @@ comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
 	tristate "generic/default IDE chipset support"
-	depends on ALPHA || X86 || IA64 || M32R || MIPS || PPC32
+	depends on ALPHA || X86 || IA64 || M32R || MIPS
 	help
 	  If unsure, say N.
 
