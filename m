From: Mikael Pettersson <mikpe@it.uu.se>
Subject: [RFC] sata_promise: handle TX2plus PATA locally
Date: Sun, 7 Jan 2007 19:32:17 +0100 (MET)
Message-ID: <200701071832.l07IWHa2027464@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:46994 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964823AbXAGScd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Jan 2007 13:32:33 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

This is an RFC on a simpler and less intrusive way of setting
up port flags on the mixed SATA/PATA Promise TX2plus chips.

The #promise-sata-pata branch requires libata core to be updated
with a per-port flags array in the ata_probe_ent structure. I
guess you don't approve of that solution.

This alternative patch is based on the observation that ap->flags
isn't really used until after ->port_start() has been invoked.
So this patch places the "exceptional" per-port flags array in
the driver's private host structure, and uses it in ->port_start()
to finalise the flags.

This patch also eliminates #promise-sata-pata's redundant code
formatting changes, and eliminates the redundant port_flags[]
assignments for the SATA-only TX4 chips.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc4/drivers/ata/sata_promise.c.~1~	2007-01-07 18:17:02.000000000 +0100
+++ linux-2.6.20-rc4/drivers/ata/sata_promise.c	2007-01-07 18:25:33.000000000 +0100
@@ -92,6 +92,7 @@ struct pdc_port_priv {
 
 struct pdc_host_priv {
 	unsigned long		flags;
+	unsigned long		port_flags[ATA_MAX_PORTS];
 };
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg);
@@ -183,7 +184,7 @@ static const struct ata_port_info pdc_po
 	/* board_2037x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -213,7 +214,7 @@ static const struct ata_port_info pdc_po
 	/* board_2057x */
 	{
 		.sht		= &pdc_ata_sht,
-		.flags		= PDC_COMMON_FLAGS | ATA_FLAG_SATA,
+		.flags		= PDC_COMMON_FLAGS,
 		.pio_mask	= 0x1f, /* pio0-4 */
 		.mwdma_mask	= 0x07, /* mwdma0-2 */
 		.udma_mask	= 0x7f, /* udma0-6 ; FIXME */
@@ -271,6 +272,11 @@ static int pdc_port_start(struct ata_por
 	struct pdc_port_priv *pp;
 	int rc;
 
+	/* fix up port flags and cable type for heterogeneous chips like TX2plus */
+	ap->flags |= hp->port_flags[ap->port_no];
+	if (ap->flags & ATA_FLAG_SATA)
+		ap->cbl = ATA_CBL_SATA;
+
 	rc = ata_port_start(ap);
 	if (rc)
 		return rc;
@@ -377,7 +383,7 @@ static void pdc_pata_phy_reset(struct at
 
 static u32 pdc_sata_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
-	if (sc_reg > SCR_CONTROL)
+	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
 		return 0xffffffffU;
 	return readl((void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -386,7 +392,7 @@ static u32 pdc_sata_scr_read (struct ata
 static void pdc_sata_scr_write (struct ata_port *ap, unsigned int sc_reg,
 			       u32 val)
 {
-	if (sc_reg > SCR_CONTROL)
+	if ((sc_reg > SCR_CONTROL) || (ap->flags & ATA_FLAG_SLAVE_POSS))
 		return;
 	writel(val, (void __iomem *) ap->ioaddr.scr_addr + (sc_reg * 4));
 }
@@ -740,6 +746,7 @@ static int pdc_ata_init_one (struct pci_
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
 	int rc;
+	u8 tmp;
 
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
@@ -820,7 +827,17 @@ static int pdc_ata_init_one (struct pci_
 		hp->flags |= PDC_FLAG_GEN_II;
 		/* Fall through */
 	case board_2037x:
-		probe_ent->n_ports = 2;
+		/* TX2plus boards also have a PATA port */
+		tmp = readb(mmio_base + PDC_FLASH_CTL+1);
+		if (!(tmp & 0x80)) {
+			probe_ent->n_ports = 3;
+			pdc_ata_setup_port(&probe_ent->port[2], base + 0x300);
+			hp->port_flags[2] = ATA_FLAG_SLAVE_POSS;
+			printk(KERN_INFO DRV_NAME " PATA port found\n");
+		} else
+			probe_ent->n_ports = 2;
+		hp->port_flags[0] = ATA_FLAG_SATA;
+		hp->port_flags[1] = ATA_FLAG_SATA;
 		break;
 	case board_20619:
 		probe_ent->n_ports = 4;
