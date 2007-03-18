From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/2] ahci: implement ata_save/restore_initial_config()
Date: Sun, 18 Mar 2007 22:15:33 +0900
Message-ID: <20070318131533.GC6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:31331 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXCRNPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 09:15:39 -0400
Received: by nz-out-0506.google.com with SMTP id s1so487303nze
        for <linux-ide@vger.kernel.org>; Sun, 18 Mar 2007 06:15:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

There are several registers which describe how the controller is
configured.  These registers are sometimes implemented as r/w
registers which are configured by firmware and get cleared on
controller reset or after suspend/resume cycle.  ahci saved and
restored those values inside ahci_reset_controller() which is a bit
messy and doesn't work over suspend/resume cycle.

This patch implements ahci_save/restore_initial_config().  The save
function is called during driver initialization and saves cap and
port_map to hpriv.  The restore function is called after the
controller is reset to restore the initial values.

Sometimes the initial firmware values are inconsistent and need to be
fixed up.  This is handled by ahci_save_initial_config().  For this,
there are two versions of saved registers.  One to write back to the
hardware register, the other to use during driver operation.  This is
necessary to keep ahci's behavior unchanged (write back fixed up
port_map while keeping cap as-is).

This patch makes ahci save the register values once before the first
controller reset, not after it's been reset.  Also, the same stored
values are used written back after each reset, so the register values
are properly recovered after suspend/resume cycle.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this is the save/restore separation patch as suggested.

 drivers/ata/ahci.c |   95 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 23 deletions(-)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -186,8 +186,10 @@ struct ahci_sg {
 };
 
 struct ahci_host_priv {
-	u32			cap;	/* cache of HOST_CAP register */
-	u32			port_map; /* cache of HOST_PORTS_IMPL reg */
+	u32			cap;		/* cap to use */
+	u32			port_map;	/* port map to use */
+	u32			saved_cap;	/* saved initial cap */
+	u32			saved_port_map;	/* saved initial port_map */
 };
 
 struct ahci_port_priv {
@@ -463,6 +465,65 @@ static inline void __iomem *ahci_port_ba
 	return base + 0x100 + (port * 0x80);
 }
 
+/**
+ *	ahci_save_initial_config - Save and fixup initial config values
+ *	@probe_ent: probe_ent of target device
+ *
+ *	Some registers containing configuration info might be setup by
+ *	BIOS and might be cleared on reset.  This function saves the
+ *	initial values of those registers into @hpriv such that they
+ *	can be restored after controller reset.
+ *
+ *	If inconsistent, config values are fixed up by this function.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ahci_save_initial_config(struct ata_probe_ent *probe_ent)
+{
+	struct ahci_host_priv *hpriv = probe_ent->private_data;
+	void __iomem *mmio = probe_ent->iomap[AHCI_PCI_BAR];
+	u32 cap, port_map;
+
+	/* Values prefixed with saved_ are written back to host after
+	 * reset.  Values without are used for driver operation.
+	 */
+	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
+	hpriv->saved_port_map = port_map = readl(mmio + HOST_PORTS_IMPL);
+
+	/* fixup zero port_map */
+	if (!port_map) {
+		port_map = (1 << ahci_nr_ports(hpriv->cap)) - 1;
+		dev_printk(KERN_WARNING, probe_ent->dev,
+			   "PORTS_IMPL is zero, forcing 0x%x\n", port_map);
+
+		/* write the fixed up value to the PI register */
+		hpriv->saved_port_map = port_map;
+	}
+
+	/* record values to use during operation */
+	hpriv->cap = cap;
+	hpriv->port_map = port_map;
+}
+
+/**
+ *	ahci_restore_initial_config - Restore initial config
+ *	@mmio: MMIO base for the host
+ *	@hpriv: host private data
+ *
+ *	Restore initial config stored by ahci_save_initial_config().
+ *
+ *	LOCKING:
+ *	None.
+ */
+static void ahci_restore_initial_config(void __iomem *mmio,
+					struct ahci_host_priv *hpriv)
+{
+	writel(hpriv->saved_cap, mmio + HOST_CAP);
+	writel(hpriv->saved_port_map, mmio + HOST_PORTS_IMPL);
+	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
+}
+
 static u32 ahci_scr_read (struct ata_port *ap, unsigned int sc_reg_in)
 {
 	unsigned int sc_reg;
@@ -639,12 +700,10 @@ static int ahci_deinit_port(void __iomem
 	return 0;
 }
 
-static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev)
+static int ahci_reset_controller(void __iomem *mmio, struct pci_dev *pdev,
+				 struct ahci_host_priv *hpriv)
 {
-	u32 cap_save, impl_save, tmp;
-
-	cap_save = readl(mmio + HOST_CAP);
-	impl_save = readl(mmio + HOST_PORTS_IMPL);
+	u32 tmp;
 
 	/* global controller reset */
 	tmp = readl(mmio + HOST_CTL);
@@ -669,18 +728,8 @@ static int ahci_reset_controller(void __
 	writel(HOST_AHCI_EN, mmio + HOST_CTL);
 	(void) readl(mmio + HOST_CTL);	/* flush */
 
-	/* These write-once registers are normally cleared on reset.
-	 * Restore BIOS values... which we HOPE were present before
-	 * reset.
-	 */
-	if (!impl_save) {
-		impl_save = (1 << ahci_nr_ports(cap_save)) - 1;
-		dev_printk(KERN_WARNING, &pdev->dev,
-			   "PORTS_IMPL is zero, forcing 0x%x\n", impl_save);
-	}
-	writel(cap_save, mmio + HOST_CAP);
-	writel(impl_save, mmio + HOST_PORTS_IMPL);
-	(void) readl(mmio + HOST_PORTS_IMPL);	/* flush */
+	/* some registers might be cleared on reset.  restore initial values */
+	ahci_restore_initial_config(mmio, hpriv);
 
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
 		u16 tmp16;
@@ -1415,7 +1464,7 @@ static int ahci_pci_device_resume(struct
 		return rc;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
-		rc = ahci_reset_controller(mmio, pdev);
+		rc = ahci_reset_controller(mmio, pdev, hpriv);
 		if (rc)
 			return rc;
 
@@ -1526,12 +1575,10 @@ static int ahci_host_init(struct ata_pro
 	unsigned int i, cap_n_ports, using_dac;
 	int rc;
 
-	rc = ahci_reset_controller(mmio, pdev);
+	rc = ahci_reset_controller(mmio, pdev, hpriv);
 	if (rc)
 		return rc;
 
-	hpriv->cap = readl(mmio + HOST_CAP);
-	hpriv->port_map = readl(mmio + HOST_PORTS_IMPL);
 	cap_n_ports = ahci_nr_ports(hpriv->cap);
 
 	VPRINTK("cap 0x%x  port_map 0x%x  n_ports %d\n",
@@ -1722,6 +1769,8 @@ static int ahci_init_one(struct pci_dev 
 	probe_ent->private_data = hpriv;
 
 	/* initialize adapter */
+	ahci_save_initial_config(probe_ent);
+
 	rc = ahci_host_init(probe_ent);
 	if (rc)
 		return rc;
