From: Andrew Lunn <andrew@lunn.ch>
Subject: [Patch v3] 2/7] ata: Remove ARCH_KIRKWOOD dependency
Date: Sat, 30 Aug 2014 18:46:07 +0200
Message-ID: <1409417172-6846-3-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42004 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbaH3Qwe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Aug 2014 12:52:34 -0400
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e1b92788c225..cd4cccbfd2ab 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -299,7 +299,7 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
-	depends on PCI || ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
+	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
 	help
-- 
2.1.0

