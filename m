From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 2/3] ata: ahci-platform: Add ports-implemented DT bindings.
Date: Fri,  1 Apr 2016 08:52:57 +0100
Message-ID: <1459497178-31090-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jmaggard10@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-ide@vger.kernel.org

On some SOCs PORTS_IMPL register value is never programmed by the
firmware and left at zero value. Which means that no sata ports are
available for software. AHCI driver used to cope up with this by
fabricating the port_map if the PORTS_IMPL register is read zero,
but recent patch broke this workaround as zero value was valid for
NVMe disks.

This patch adds ports-implemented DT bindings as workaround for this issue
in a way that DT can can override the PORTS_IMPL register in cases where
the firmware did not program it already.

Fixes: 566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3)
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andy Gross <andy.gross@linaro.org>
---
 Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 ++++
 drivers/ata/ahci_platform.c                             | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 30df832..87adfb2 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -32,6 +32,10 @@ Optional properties:
 - target-supply     : regulator for SATA target power
 - phys              : reference to the SATA PHY node
 - phy-names         : must be "sata-phy"
+- ports-implemented : Mask that indicates which ports that the HBA supports
+		      are available for software to use. Useful if PORTS_IMPL
+		      is not programmed by the BIOS, which is true with
+		      some embedded SOC's.
 
 Required properties when using sub-nodes:
 - #address-cells    : number of cells to encode an address
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 4044233..62a04c8 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -51,6 +51,9 @@ static int ahci_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	of_property_read_u32(dev->of_node,
+			     "ports-implemented", &hpriv->force_port_map);
+
 	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
 		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
 
-- 
2.5.0
