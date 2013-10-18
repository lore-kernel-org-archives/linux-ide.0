From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch v2] sata, highbank: clear whole array in
 highbank_initialize_phys()
Date: Fri, 18 Oct 2013 11:44:09 +0300
Message-ID: <20131018084409.GA14256@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The original code used the wrong parameter to clear tx_atten[].  It
passed the number of elements instead of sizeof() the array to memset.

The other potential issue was that cphy_base[] wasn't cleared.  I'm not
sure if that was a real problem or not, but I have cleared it in my
patch.

Instead of using memset(), this patch uses empty initializers as a
cleanup.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: used {} initialization instead of memset.  I also just went ahead
    and cleared cphy_base[].

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 7f5e5d9..ea3b3dc 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -343,13 +343,11 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
 {
 	struct device_node *sata_node = dev->of_node;
 	int phy_count = 0, phy, port = 0, i;
-	void __iomem *cphy_base[CPHY_PHY_COUNT];
-	struct device_node *phy_nodes[CPHY_PHY_COUNT];
-	u32 tx_atten[CPHY_PORT_COUNT];
+	void __iomem *cphy_base[CPHY_PHY_COUNT] = {};
+	struct device_node *phy_nodes[CPHY_PHY_COUNT] = {};
+	u32 tx_atten[CPHY_PORT_COUNT] = {};
 
 	memset(port_data, 0, sizeof(struct phy_lane_info) * CPHY_PORT_COUNT);
-	memset(phy_nodes, 0, sizeof(struct device_node*) * CPHY_PHY_COUNT);
-	memset(tx_atten, 0xff, CPHY_PORT_COUNT);
 
 	do {
 		u32 tmp;
