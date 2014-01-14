From: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH v2 3/3] ARM: mvebu: update the SATA compatible string for Armada 370/XP
Date: Tue, 14 Jan 2014 15:50:07 +0100
Message-ID: <1389711007-7239-4-git-send-email-simon.guinot@sequanux.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
Sender: stable-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

This patch updates the Armada 370/XP SATA node with the new compatible
string "marvell,armada-370-xp-sata".

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>
Cc: stable@vger.kernel.org
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7f10f627ae5b..b5def2416800 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -152,7 +152,7 @@
 			};
 
 			sata@a0000 {
-				compatible = "marvell,orion-sata";
+				compatible = "marvell,armada-370-xp-sata";
 				reg = <0xa0000 0x5000>;
 				interrupts = <55>;
 				clocks = <&gateclk 15>, <&gateclk 30>;
-- 
1.8.5.2
