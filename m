From: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] mpc8xx: Only build mpc8xx on arch/ppc
Date: Wed, 22 Aug 2007 23:07:20 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0708222304500.7960@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38947 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbXHWEHR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 23 Aug 2007 00:07:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-ide@vger.kernel.org

Currently the mpc8xx ide driver will only work on arch/ppc so only
allow it to be built there.  Also, killed a minor include that isn't
actually used by the driver.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/ide/Kconfig      |    2 +-
 drivers/ide/ppc/mpc8xx.c |    1 -
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 7adb61b..24ad104 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -946,7 +946,7 @@ config BLK_DEV_Q40IDE

 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
-	depends on 8xx && IDE=y && BLK_DEV_IDE=y
+	depends on 8xx && IDE=y && BLK_DEV_IDE=y && !PPC_MERGE
 	select IDE_GENERIC
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
diff --git a/drivers/ide/ppc/mpc8xx.c b/drivers/ide/ppc/mpc8xx.c
index 8859fe2..dab79af 100644
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -32,7 +32,6 @@
 #include <asm/mpc8xx.h>
 #include <asm/mmu.h>
 #include <asm/processor.h>
-#include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/ide.h>
-- 
1.5.2.4

