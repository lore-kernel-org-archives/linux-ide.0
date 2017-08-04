From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4/9] ata: ceva: Disable Device Sleep capability
Date: Fri,  4 Aug 2017 15:18:13 +0200
Message-ID: <5083740a2e8372ed9022c2cb9c8f2ff0fd6cd7c8.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1501852693.git.michal.simek@xilinx.com>
References: <cover.1501852693.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Alexander Graf <agraf@suse.de>, Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

Since CEVA controller does not support Device Sleep capability,
we need to clear that feature by clearing the DEVSLP bit in word78
of IDENTIFY DEVICE data. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/ata/ahci_ceva.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index aa32c8a0f083..b63fab2507fa 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -81,8 +81,26 @@ struct ceva_ahci_priv {
 	int flags;
 };
 
+static unsigned int ceva_ahci_read_id(struct ata_device *dev,
+					struct ata_taskfile *tf, u16 *id)
+{
+	u32 err_mask;
+
+	err_mask = ata_do_dev_read_id(dev, tf, id);
+	if (err_mask)
+		return err_mask;
+	/*
+	 * Since CEVA controller does not support device sleep feature, we
+	 * need to clear DEVSLP (bit 8) in word78 of the IDENTIFY DEVICE data.
+	 */
+	id[ATA_ID_FEATURE_SUPP] &= cpu_to_le16(~(1 << 8));
+
+	return 0;
+}
+
 static struct ata_port_operations ahci_ceva_ops = {
 	.inherits = &ahci_platform_ops,
+	.read_id = ceva_ahci_read_id,
 };
 
 static const struct ata_port_info ahci_ceva_port_info = {
-- 
1.9.1
