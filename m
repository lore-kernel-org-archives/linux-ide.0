From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] ata: sata_mv: add proper definitions for LP_PHY_CTL register values
Date: Thu, 19 Mar 2015 14:36:37 +0100
Message-ID: <1426772197-17908-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59170 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751362AbbCSNhA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2015 09:37:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Simon Guinot <simon.guinot@sequanux.org>, Christophe Vu-Brugier <cvubrugier@lacie.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Commit 9013d64e661fc ("ata: sata_mv: fix disk hotplug for Armada
370/XP SoCs") added some manipulation of the LP_PHY_CTL register, but
using magic values. This commit changes the code to use proper
definitions for the LP_PHY_CTL register, which allows to document what
the different bits are doing.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/ata/sata_mv.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f8c33e3..0281785 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -306,6 +306,11 @@ enum {
 	MV5_PHY_CTL		= 0x0C,
 	SATA_IFCFG		= 0x050,
 	LP_PHY_CTL		= 0x058,
+	LP_PHY_CTL_PIN_PU_PLL   = (1 << 0),
+	LP_PHY_CTL_PIN_PU_RX    = (1 << 1),
+	LP_PHY_CTL_PIN_PU_TX    = (1 << 2),
+	LP_PHY_CTL_GEN_TX_3G    = (1 << 5),
+	LP_PHY_CTL_GEN_RX_3G    = (1 << 9),
 
 	MV_M2_PREAMP_MASK	= 0x7e0,
 
@@ -1391,10 +1396,17 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
 				/*
 				 * Set PHY speed according to SControl speed.
 				 */
-				if ((val & 0xf0) == 0x10)
-					writelfl(0x7, lp_phy_addr);
-				else
-					writelfl(0x227, lp_phy_addr);
+				u32 lp_phy_val =
+					LP_PHY_CTL_PIN_PU_PLL |
+					LP_PHY_CTL_PIN_PU_RX  |
+					LP_PHY_CTL_PIN_PU_TX;
+
+				if ((val & 0xf0) != 0x10)
+					lp_phy_val |=
+						LP_PHY_CTL_GEN_TX_3G |
+						LP_PHY_CTL_GEN_RX_3G;
+
+				writelfl(lp_phy_val, lp_phy_addr);
 			}
 		}
 		writelfl(val, addr);
-- 
2.1.0

