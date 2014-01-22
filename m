From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] ATA: SATA_MV: Add missing Kconfig select statememnt
Date: Wed, 22 Jan 2014 20:56:33 +0100
Message-ID: <1390420593-27697-1-git-send-email-andrew@lunn.ch>
References: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:55805 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755865AbaAVT6W (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Jan 2014 14:58:22 -0500
In-Reply-To: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

SATA_MV depends on GENERIC_PHY. So if SATA_MV is built in, GENERIC_PHY
cannot be modular. Fixes build error found by kbuild test robot.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 4e737728aee2..868429a47be4 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -247,6 +247,7 @@ config SATA_HIGHBANK
 
 config SATA_MV
 	tristate "Marvell SATA support"
+	select GENERIC_PHY
 	help
 	  This option enables support for the Marvell Serial ATA family.
 	  Currently supports 88SX[56]0[48][01] PCI(-X) chips,
-- 
1.8.5.2

