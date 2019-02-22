From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/5] irqchip/irq-mvebu-icu: Move the double SATA ports
 interrupt hack
Date: Fri, 22 Feb 2019 15:53:54 +0100
Message-ID: <20190222145356.23072-4-miquel.raynal@bootlin.com>
References: <20190222145356.23072-1-miquel.raynal@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190222145356.23072-1-miquel.raynal@bootlin.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
Cc: devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

When writing the driver, a hack was introduced to configure both SATA
interrupts regardless of the port in use to overcome a limitation in
the SATA core. Now that this limitation has been addressed, let's
clean this driver section and move the hack into the (historically)
responsible SATA driver: ahci_platform.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/ata/ahci_platform.c     | 174 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-mvebu-icu.c |  18 ----
 2 files changed, 174 insertions(+), 18 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index cf1e0e18a7a9..4401a137e6d5 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -17,6 +17,7 @@
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/ahci_platform.h>
@@ -26,6 +27,9 @@
 
 #define DRV_NAME "ahci"
 
+#define ICU_SATA0_ICU_ID 109
+#define ICU_SATA1_ICU_ID 107
+
 static const struct ata_port_info ahci_port_info = {
 	.flags		= AHCI_FLAG_COMMON,
 	.pio_mask	= ATA_PIO4,
@@ -44,6 +48,170 @@ static struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
 
+/*
+ * The Armada CP110 SATA unit (on A7k/A8k SoCs) has 2 ports, and a dedicated ICU
+ * entry per port. In the past, the AHCI SATA driver only supported one
+ * interrupt per SATA unit. To solve this, the 2 SATA wired interrupts in the
+ * South-Bridge got configured as 1 GIC interrupt in the North-Bridge,
+ * regardless of the number of SATA ports actually enabled/in use.
+ *
+ * Since then, this limitation has been addressed and the hack described
+ * above has been removed from the ICU driver. However, for compatibility
+ * it is needed to support DT with just one interrupt and no SATA ports.
+ * Instead of hacking everywhere in the ahci/libahci code, this quirk has been
+ * written to manually create the SATA port sub-nodes if they are missing,
+ * assign them the right port numbers through the "reg" properties and their
+ * respective "interrupts".
+ */
+static int ahci_armada_8k_quirk(struct device *dev)
+{
+	struct device_node *dn = dev->of_node;
+	struct property *interrupt = of_find_property(dn, "interrupts", NULL);
+	struct device_node *ports;
+	struct property *regs, *ints;
+	int rc, i;
+
+	if (!(of_device_is_compatible(dn, "marvell,armada-8k-ahci") &&
+	      !of_get_child_count(dn)))
+		return 0;
+
+	if (!of_node_get(dn))
+		return -EINVAL;
+
+	/* Verify the main SATA node "interrupts" property validity */
+	if (!interrupt) {
+		rc = -EINVAL;
+		goto put_dn;
+	}
+
+	/* Create the two sub-nodes */
+	ports = kzalloc(2 * sizeof(*ports), GFP_KERNEL);
+	if (!ports) {
+		rc = -ENOMEM;
+		goto put_dn;
+	}
+
+	for (i = 0; i < 2; i++) {
+		of_node_set_flag(&ports[i], OF_DYNAMIC);
+		of_node_init(&ports[i]);
+		ports[i].parent = dn;
+	}
+
+	ports[0].full_name = kstrdup("sata-port@0", GFP_KERNEL);
+	ports[1].full_name = kstrdup("sata-port@1", GFP_KERNEL);
+	if (!ports[0].full_name || !ports[1].full_name) {
+		rc = -ENOMEM;
+		goto free_ports_names;
+	}
+
+	/* Create the two "reg" and "interrupts" property for the sub-nodes */
+	regs = kzalloc(2 * sizeof(*regs), GFP_KERNEL);
+	ints = kzalloc(2 * sizeof(*ints), GFP_KERNEL);
+	if (!regs || !ints) {
+		rc = -ENOMEM;
+		goto free_props;
+	}
+
+	for (i = 0; i < 2; i++) {
+		regs[i].name = kstrdup("reg", GFP_KERNEL);
+		regs[i].length = sizeof(u32);
+		regs[i].value = kmalloc(sizeof(regs[i].length), GFP_KERNEL);
+
+		ints[i].name = kstrdup("interrupts", GFP_KERNEL);
+		ints[i].length = interrupt->length;
+		ints[i].value = kmemdup(interrupt->value, interrupt->length,
+					GFP_KERNEL);
+
+		if (!regs[i].name || !regs[i].value ||
+		    !ints[i].name || !ints[i].value) {
+			rc = -ENOMEM;
+			goto free_props_allocs;
+		}
+	}
+
+	/* Force the values of the ICU interrupts for both ports.
+	 * In the past, "interrupts" properties had three values:
+	 * 1/ ICU interrupt type, 2/ interrupt ID, 3/ interrupt type
+	 * Now there are only two:
+	 * 1/ interrupt ID, 2/ interrupt type
+	 * In both case we want to access the penultimate.
+	 */
+	for (i = 0; i < 2; i++) {
+		u32 *reg, *icu_int;
+		u8 *value;
+
+		reg = regs[i].value;
+		*reg = cpu_to_be32(i);
+
+		value = ints[i].value;
+		value = &value[ints[i].length - (2 * sizeof(u32))];
+		icu_int = (u32 *)value;
+		if (!i)
+			*icu_int = cpu_to_be32(ICU_SATA0_ICU_ID);
+		else
+			*icu_int = cpu_to_be32(ICU_SATA1_ICU_ID);
+	}
+
+	for (i = 0; i < 2; i++) {
+		ports[i].properties = &regs[i];
+		regs[i].next = &ints[i];
+		ints[i].next = NULL;
+	}
+
+	/* Create the two sub-nodes by attaching them */
+	rc = of_attach_node(&ports[0]);
+	if (rc) {
+		dev_err(dev, "Compat: cannot attach port0 (err %d)\n", rc);
+		goto free_props_allocs;
+	}
+
+	rc = of_attach_node(&ports[1]);
+	if (rc) {
+		dev_err(dev, "Compat: cannot attach port1 (err %d)\n", rc);
+		goto detach_port0;
+	}
+
+	/* Delete the "interrupts" property from the SATA host node */
+	rc = of_remove_property(dn, interrupt);
+	if (rc) {
+		dev_err(dev, "Compat: cannot delete SATA host interrupt\n");
+		goto detach_ports;
+	}
+
+	of_node_put(dn);
+
+	return 0;
+
+detach_ports:
+	of_detach_node(&ports[1]);
+
+detach_port0:
+	of_detach_node(&ports[0]);
+
+free_props_allocs:
+	for (i = 0; i < 2; i++) {
+		kfree(regs[i].name);
+		kfree(regs[i].value);
+		kfree(ints[i].name);
+		kfree(ints[i].value);
+	}
+
+free_props:
+	kfree(regs);
+	kfree(ints);
+
+free_ports_names:
+	for (i = 0; i < 2; i++)
+		kfree(ports[i].full_name);
+
+	kfree(ports);
+
+put_dn:
+	of_node_put(dn);
+
+	return rc;
+	}
+
 static int ahci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -51,6 +219,12 @@ static int ahci_probe(struct platform_device *pdev)
 	const struct ata_port_info *port;
 	int rc;
 
+	rc = ahci_armada_8k_quirk(dev);
+	if (rc) {
+		dev_err(dev, "Problem with CP110 backward compatibility\n");
+		return rc;
+	}
+
 	hpriv = ahci_platform_get_resources(pdev,
 					    AHCI_PLATFORM_GET_RESETS);
 	if (IS_ERR(hpriv))
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 547045d89c4b..f3b43f63fe2e 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -38,8 +38,6 @@
 
 /* ICU definitions */
 #define ICU_MAX_IRQS		207
-#define ICU_SATA0_ICU_ID	109
-#define ICU_SATA1_ICU_ID	107
 
 struct mvebu_icu_subset_data {
 	unsigned int icu_group;
@@ -111,22 +109,6 @@ static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
 	}
 
 	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq == ICU_SATA0_ICU_ID || d->hwirq == ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
 }
 
 static struct irq_chip mvebu_icu_nsr_chip = {
-- 
2.19.1
