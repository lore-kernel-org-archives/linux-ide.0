From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 5/5] ARM: defconfig: Enable generic phy in dove and kirkwood.
Date: Wed,  4 Dec 2013 18:16:04 +0100
Message-ID: <1386177364-10164-6-git-send-email-andrew@lunn.ch>
References: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:56833 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755864Ab3LDRQ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Dec 2013 12:16:29 -0500
In-Reply-To: <1386177364-10164-1-git-send-email-andrew@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, kishon@ti.com
Cc: devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

Now that there is a phy driver for sata, enable generic phy in the
kirkwood and dove defconfig.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
_
---
 arch/arm/configs/dove_defconfig     | 1 +
 arch/arm/configs/kirkwood_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 110105476848..fa03d7356168 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -100,6 +100,7 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_GENERIC_PHY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
index 0ae0eaebf6b2..fe4136ecfa4c 100644
--- a/arch/arm/configs/kirkwood_defconfig
+++ b/arch/arm/configs/kirkwood_defconfig
@@ -142,6 +142,7 @@ CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
+CONFIG_GENERIC_PHY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.8.5

