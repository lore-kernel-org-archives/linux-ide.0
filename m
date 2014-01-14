From: Simon Guinot <simon.guinot@sequanux.org>
Subject: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 15:50:06 +0100
Message-ID: <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
Sender: stable-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, stable@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Lior Amsalem <alior@marvell.com>

On Armada 370/XP SoCs, once a disk is removed from a SATA port, then the
re-plug events are not detected by the sata_mv driver. This patch fixes
the issue by updating the PHY speed in the LP_PHY_CTL register (0x58)
according to the SControl speed.

Note that this fix is only applied if the compatible string
"marvell,armada-370-xp-sata" is found in the SATA DT node.

Signed-off-by: Lior Amsalem <alior@marvell.com>
Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: stable@vger.kernel.org
---
Changes since v1:
- Only fix the LP_PHY_CTL register (0x58) if the compatible string
  "marvell,armada-370-xp-sata" is found in the SATA DT node.
- Update the commit message.

 drivers/ata/sata_mv.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index df35c521a141..780bcc808b51 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -304,6 +304,7 @@ enum {
 	MV5_LTMODE		= 0x30,
 	MV5_PHY_CTL		= 0x0C,
 	SATA_IFCFG		= 0x050,
+	LP_PHY_CTL		= 0x058,
 
 	MV_M2_PREAMP_MASK	= 0x7e0,
 
@@ -431,6 +432,7 @@ enum {
 	MV_HP_CUT_THROUGH	= (1 << 10),	/* can use EDMA cut-through */
 	MV_HP_FLAG_SOC		= (1 << 11),	/* SystemOnChip, no PCI */
 	MV_HP_QUIRK_LED_BLINK_EN = (1 << 12),	/* is led blinking enabled? */
+	MV_HP_FIX_LP_PHY_CTL	= (1 << 13),	/* fix speed in LP_PHY_CTL ? */
 
 	/* Port private flags (pp_flags) */
 	MV_PP_FLAG_EDMA_EN	= (1 << 0),	/* is EDMA engine enabled? */
@@ -1358,6 +1360,7 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
 
 	if (ofs != 0xffffffffU) {
 		void __iomem *addr = mv_ap_base(link->ap) + ofs;
+		struct mv_host_priv *hpriv = link->ap->host->private_data;
 		if (sc_reg_in == SCR_CONTROL) {
 			/*
 			 * Workaround for 88SX60x1 FEr SATA#26:
@@ -1374,6 +1377,18 @@ static int mv_scr_write(struct ata_link *link, unsigned int sc_reg_in, u32 val)
 			 */
 			if ((val & 0xf) == 1 || (readl(addr) & 0xf) == 1)
 				val |= 0xf000;
+
+			if (hpriv->hp_flags & MV_HP_FIX_LP_PHY_CTL) {
+				void __iomem *lp_phy_addr =
+					mv_ap_base(link->ap) + LP_PHY_CTL;
+				/*
+				 * Set PHY speed according to SControl speed.
+				 */
+				if ((val & 0xf0) == 0x10)
+					writelfl(0x7, lp_phy_addr);
+				else
+					writelfl(0x227, lp_phy_addr);
+			}
 		}
 		writelfl(val, addr);
 		return 0;
@@ -4110,6 +4125,15 @@ static int mv_platform_probe(struct platform_device *pdev)
 	if (rc)
 		goto err;
 
+	/*
+	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
+	 * updated in the LP_PHY_CTL register.
+	 */
+	if (pdev->dev.of_node &&
+		of_device_is_compatible(pdev->dev.of_node,
+					"marvell,armada-370-xp-sata"))
+		hpriv->hp_flags |= MV_HP_FIX_LP_PHY_CTL;
+
 	/* initialize adapter */
 	rc = mv_init_host(host);
 	if (rc)
-- 
1.8.5.2
