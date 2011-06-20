From: Yuan-Hsin Chen <yuanlmm@gmail.com>
Subject: [PATCH v4] ahci: move ahci_sb600_softreset to libahci.c and rename it
Date: Mon, 20 Jun 2011 16:06:41 +0800
Message-ID: <1308557202-1895-1-git-send-email-yuanlmm@gmail.com>
References: <20110617120704.GH2611@htj.dyndns.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110617120704.GH2611@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, sshtylyov@mvista.com, Yuan-Hsin Chen <yhchen@faraday-tech.com>
List-Id: linux-ide@vger.kernel.org

From: Yuan-Hsin Chen <yhchen@faraday-tech.com>

ahci_sb600_softreset was in ahci.c. This function is used
to fix soft reset failure and renames as ahci_pmp_retry_srst_softreset
in libahci.c.
---
 drivers/ata/ahci.c    |   54 +---------------------------------------------
 drivers/ata/ahci.h    |    1 +
 drivers/ata/libahci.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 71afe03..2de36b6 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -79,8 +79,6 @@ enum board_ids {
 };
 
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
-static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
-			  unsigned long deadline);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline);
 static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
@@ -106,8 +104,7 @@ static struct ata_port_operations ahci_p5wdh_ops = {
 
 static struct ata_port_operations ahci_sb600_ops = {
 	.inherits		= &ahci_ops,
-	.softreset		= ahci_sb600_softreset,
-	.pmp_softreset		= ahci_sb600_softreset,
+	.softreset		= ahci_pmp_retry_srst_softreset,
 };
 
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
@@ -502,55 +499,6 @@ static void ahci_pci_init_controller(struct ata_host *host)
 	ahci_init_controller(host);
 }
 
-static int ahci_sb600_check_ready(struct ata_link *link)
-{
-	void __iomem *port_mmio = ahci_port_base(link->ap);
-	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
-	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
-
-	/*
-	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
-	 * which can save timeout delay.
-	 */
-	if (irq_status & PORT_IRQ_BAD_PMP)
-		return -EIO;
-
-	return ata_check_ready(status);
-}
-
-static int ahci_sb600_softreset(struct ata_link *link, unsigned int *class,
-				unsigned long deadline)
-{
-	struct ata_port *ap = link->ap;
-	void __iomem *port_mmio = ahci_port_base(ap);
-	int pmp = sata_srst_pmp(link);
-	int rc;
-	u32 irq_sts;
-
-	DPRINTK("ENTER\n");
-
-	rc = ahci_do_softreset(link, class, pmp, deadline,
-			       ahci_sb600_check_ready);
-
-	/*
-	 * Soft reset fails on some ATI chips with IPMS set when PMP
-	 * is enabled but SATA HDD/ODD is connected to SATA port,
-	 * do soft reset again to port 0.
-	 */
-	if (rc == -EIO) {
-		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
-		if (irq_sts & PORT_IRQ_BAD_PMP) {
-			ata_link_printk(link, KERN_WARNING,
-					"applying SB600 PMP SRST workaround "
-					"and retrying\n");
-			rc = ahci_do_softreset(link, class, 0, deadline,
-					       ahci_check_ready);
-		}
-	}
-
-	return rc;
-}
-
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 				 unsigned long deadline)
 {
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 12c5282..b175000 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -312,6 +312,7 @@ extern struct device_attribute *ahci_sdev_attrs[];
 	.sdev_attrs		= ahci_sdev_attrs
 
 extern struct ata_port_operations ahci_ops;
+extern struct ata_port_operations ahci_pmp_retry_srst_ops;
 
 void ahci_fill_cmd_slot(struct ahci_port_priv *pp, unsigned int tag,
 			u32 opts);
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index d38c40f..0fd5a30 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -82,6 +82,8 @@ static void ahci_pmp_attach(struct ata_port *ap);
 static void ahci_pmp_detach(struct ata_port *ap);
 static int ahci_softreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline);
+static int ahci_pmp_retry_srst_softreset(struct ata_link *link, unsigned int *class,
+			  unsigned long deadline);
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline);
 static void ahci_postreset(struct ata_link *link, unsigned int *class);
@@ -141,6 +143,12 @@ struct device_attribute *ahci_sdev_attrs[] = {
 };
 EXPORT_SYMBOL_GPL(ahci_sdev_attrs);
 
+struct ata_port_operations ahci_pmp_retry_srst_ops = {
+	.inherits		= &ahci_ops,
+	.softreset		= ahci_pmp_retry_srst_softreset,
+};
+EXPORT_SYMBOL_GPL(ahci_pmp_retry_srst_ops);
+
 struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
@@ -1329,6 +1337,55 @@ static int ahci_softreset(struct ata_link *link, unsigned int *class,
 }
 EXPORT_SYMBOL_GPL(ahci_do_softreset);
 
+static int ahci_pmp_check_ready(struct ata_link *link)
+{
+	void __iomem *port_mmio = ahci_port_base(link->ap);
+	u8 status = readl(port_mmio + PORT_TFDATA) & 0xFF;
+	u32 irq_status = readl(port_mmio + PORT_IRQ_STAT);
+
+	/*
+	 * There is no need to check TFDATA if BAD PMP is found due to HW bug,
+	 * which can save timeout delay.
+	 */
+	if (irq_status & PORT_IRQ_BAD_PMP)
+		return -EIO;
+
+	return ata_check_ready(status);
+}
+
+static int ahci_pmp_retry_srst_softreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	int pmp = sata_srst_pmp(link);
+	int rc;
+	u32 irq_sts;
+
+	DPRINTK("ENTER\n");
+
+	rc = ahci_do_softreset(link, class, pmp, deadline,
+			       ahci_pmp_check_ready);
+
+	/*
+	 * Soft reset fails with IPMS set when PMP is enabled but
+	 * SATA HDD/ODD is connected to SATA port, do soft reset
+	 * again to port 0.
+	 */
+	if (rc == -EIO) {
+		irq_sts = readl(port_mmio + PORT_IRQ_STAT);
+		if (irq_sts & PORT_IRQ_BAD_PMP) {
+			ata_link_printk(link, KERN_WARNING,
+					"applying PMP SRST workaround "
+					"and retrying\n");
+			rc = ahci_do_softreset(link, class, 0, deadline,
+					       ahci_check_ready);
+		}
+	}
+
+	return rc;
+}
+
 static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 			  unsigned long deadline)
 {
-- 
1.7.3.1
