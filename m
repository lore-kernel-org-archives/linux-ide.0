From: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH v3 3/3] ARM: mvebu: update the SATA compatible string for Armada 370/XP
Date: Tue, 14 Jan 2014 20:10:27 +0100
Message-ID: <1389726631-8905-1-git-send-email-simon.guinot@sequanux.org>
References: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vm1.sequanux.org ([188.165.36.56]:50606 "EHLO vm1.sequanux.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbaANTKx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Jan 2014 14:10:53 -0500
In-Reply-To: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, stable@vger.kernel.org

This patch updates the Armada 370/XP SATA node with the new compatible
string "marvell,armada-370-sata".

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>
Cc: stable@vger.kernel.org # v3.6+
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
Changes since v2:
- Use compatible string "marvell,armada-370-sata" instead of
  "marvell,armada-370-xp-sata".

 arch/arm/boot/dts/armada-370-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 7f10f627ae5b..80ffacd128f8 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -152,7 +152,7 @@
 			};
 
 			sata@a0000 {
-				compatible = "marvell,orion-sata";
+				compatible = "marvell,armada-370-sata";
 				reg = <0xa0000 0x5000>;
 				interrupts = <55>;
 				clocks = <&gateclk 15>, <&gateclk 30>;
-- 
1.8.5.2

