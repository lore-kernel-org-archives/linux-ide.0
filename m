From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] sata, highbank: clear whole array in
 highbank_initialize_phys()
Date: Fri, 16 Aug 2013 10:33:36 +0300
Message-ID: <20130816073336.GA9881@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The problem is that we use "CPHY_PORT_COUNT" as the size of the
tx_atten[] array, but that's the number of elements and not the number
of bytes.  I've changed it to use sizeof(tx_atten) instead.

The other two calls to memset() were correct but I changed them as well
for consistency.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
We don't clear the cphy_base[] array.  I don't know the code well enough
to say if that is intentional or not.

diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 7f5e5d9..6abe2d5 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -347,9 +347,9 @@ static int highbank_initialize_phys(struct device *dev, void __iomem *addr)
 	struct device_node *phy_nodes[CPHY_PHY_COUNT];
 	u32 tx_atten[CPHY_PORT_COUNT];
 
-	memset(port_data, 0, sizeof(struct phy_lane_info) * CPHY_PORT_COUNT);
-	memset(phy_nodes, 0, sizeof(struct device_node*) * CPHY_PHY_COUNT);
-	memset(tx_atten, 0xff, CPHY_PORT_COUNT);
+	memset(port_data, 0, sizeof(port_data));
+	memset(phy_nodes, 0, sizeof(phy_nodes));
+	memset(tx_atten, 0xff, sizeof(tx_atten));
 
 	do {
 		u32 tmp;
