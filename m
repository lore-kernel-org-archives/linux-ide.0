From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 06/13] ata: Remove ARCH_KIRKWOOD and ARCH_DOVE dependency
Date: Sun, 29 Jun 2014 22:59:55 +0200
Message-ID: <1404075603-31838-9-git-send-email-andrew@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:38882 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753658AbaF2VFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Jun 2014 17:05:42 -0400
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, rmk+kernel@arm.linux.org.uk, Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Both mach-kirkwood and mach-dove have been removed, now that both SoCs
lives in mach-mvebu. ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 7671dbac6015..5991089492d0 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -289,8 +289,8 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
-	depends on PCI || ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
-		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
+	depends on PCI || ARCH_MV78XX0 || ARCH_MVEBU || ARCH_ORION5X || \
+		   COMPILE_TEST
 	select GENERIC_PHY
 	help
 	  This option enables support for the Marvell Serial ATA family.
-- 
2.0.0

