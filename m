From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] drivers: ide: Kconfig: let IDE_H8300 depends on H8300H_AKI3068NET
 or H8300H_H8MAX
Date: Thu, 29 Aug 2013 17:42:35 +0800
Message-ID: <521F178B.7080407@asianux.com>
References: <521EC55A.9030905@asianux.com> <521ED249.6080001@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:21834 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab3H2Jnk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Aug 2013 05:43:40 -0400
In-Reply-To: <521ED249.6080001@asianux.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, David Miller <davem@davemloft.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

According to the code in "arch/h8300/Kbuild.ide", IDE_H8300 need depend
on "H8300H_AKI3068NET || H8300H_H8MAX", or can not pass compiling with
allmodconfig for h8300.

The related error:

  drivers/ide/ide-h8300.c: In function 'hw_setup':
  drivers/ide/ide-h8300.c:73:27: error: 'CONFIG_H8300_IDE_BASE' undeclared (first use in this function)
  drivers/ide/ide-h8300.c:73:27: note: each undeclared identifier is reported only once for each function it appears in
  drivers/ide/ide-h8300.c:74:26: error: 'CONFIG_H8300_IDE_ALT' undeclared (first use in this function)
  drivers/ide/ide-h8300.c:75:23: error: 'CONFIG_H8300_IDE_IRQ' undeclared (first use in this function)
  drivers/ide/ide-h8300.c: In function 'h8300_ide_init':
  drivers/ide/ide-h8300.c:90:7: error: 'CONFIG_H8300_IDE_BASE' undeclared (first use in this function)
  drivers/ide/ide-h8300.c:92:7: error: 'CONFIG_H8300_IDE_ALT' undeclared (first use in this function)
  drivers/ide/ide-h8300.c: At top level:
  drivers/ide/ide-h8300.c:109:16: error: expected declaration specifiers or '...' before string constant


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/ide/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 02906ca..f79b49f 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -724,7 +724,7 @@ config BLK_DEV_IDE_RAPIDE
 
 config IDE_H8300
 	tristate "H8300 IDE support"
-	depends on H8300
+	depends on H8300H_AKI3068NET || H8300H_H8MAX
 	default y
 	help
 	  Enables the H8300 IDE driver.
-- 
1.7.7.6
