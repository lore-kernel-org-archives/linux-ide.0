From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 06/12] ata: Remove ARCH_KIRKWOOD dependency
Date: Thu, 10 Jul 2014 23:36:26 +0200
Message-ID: <1405028192-9623-7-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45817 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbaGJVm6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Jul 2014 17:42:58 -0400
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 7671dbac6015..4749aeb54bc1 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -289,7 +289,7 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
-	depends on PCI || ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
+	depends on PCI || ARCH_DOVE || ARCH_MV78XX0 || \
 		   ARCH_MVEBU || ARCH_ORION5X || COMPILE_TEST
 	select GENERIC_PHY
 	help
-- 
2.0.1

