From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Suspend w/ sata_promise
Date: Mon, 24 Nov 2008 13:10:04 +0100
Message-ID: <18730.39324.527421.503774@harpo.it.uu.se>
References: <49202CB0.60507@gc-web.de>
	<18720.18615.938839.921189@harpo.it.uu.se>
	<492060D9.20808@gc-web.de>
	<18723.52001.559166.255589@harpo.it.uu.se>
	<18728.13696.418178.143954@harpo.it.uu.se>
	<4928569C.9080805@gc-web.de>
	<18729.54297.692199.41534@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:47810 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbYKXMKK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Nov 2008 07:10:10 -0500
In-Reply-To: <18729.54297.692199.41534@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

Mikael Pettersson writes:
 > Alexander Clausen writes:
 >  > Mikael Pettersson wrote:
 >  > >  > 
 >  > >  > Based on several other libata sata drivers I think handling suspend in
 >  > >  > sata_promise may be as simple as hooking ata_pci_device_{suspend,resume},
 >  > >  > which is what the patch below does. If this doesn't work then the most
 >  > >  > likely solution is to augment the ->resume op with a Promise-specific
 >  > >  > controller reset (again similar to several other sata drivers).
 >  > >  > 
 >  > >  > Care to give it a try? The patch is against 2.6.28-rc5 but should also
 >  > >  > work in 2.6.27.
 >  > > 
 >  > > Alexander, have you had a chance to test this? Preferably together
 >  > > with Tejun's hardreset improvement patch posted recently.
 >  > > <http://marc.info/?l=linux-ide&m=122724338905689&w=2>
 >  > > 
 >  > > With both this and Tejun's hardreset patch applied my Promise test
 >  > > machine survives several suspend/resume cycles without problems.
 >  > 
 >  > Did not work here. I applied both patches to 2.6.27.6, seems to behave exactly as before.
 >  > dmesg attached.
 > 
 > Are you absolutely certain both patches were applied and the driver rebuilt?
 > I'm asking because I would have expected to see
 > 
 > [...] sata_promise 0000:00:0d.0: restoring config space at offset 0x1 (...)
 > 
 > but your kernel log does not contain anything like that. Both machines
 > I tested on today consistently included this message after the patch was
 > applied, but did not when the patch wasn't applied.
 > 
 > I did note some temporary errors (that sata_promise recovered from) on
 > one machine after resuming from suspend to ram that did not occur when
 > using standby. I'll update the patch to include a controller reinit in
 > the ->resume op, which should hopefully fix that.

Here's an updated suspend patch for sata_promise. It will now
do a HW re-init of the controller and its ports on resume,
which should help e.g. S2R when all state may have been lost.

Depending on machine, suspend type (standby or mem), and disk
I do get different results, some cases come up very cleanly
while others have some transient failures; however in my tests
libata EH always recovers.

Only tested on 2nd gen controllers as my 1st gen is at another site.

If this still doesn't work, try changing the #if 0 in pdc_pci_device_resume()
to #if 1, that will make it issue a HW reset to all ATA engines before
reinitialising them (shouldn't be needed, which is why it's disabled).

/Mikael

--- linux-2.6.28-rc6/drivers/ata/sata_promise.c.~1~	2008-11-21 20:28:08.000000000 +0100
+++ linux-2.6.28-rc6/drivers/ata/sata_promise.c	2008-11-24 01:26:12.000000000 +0100
@@ -56,6 +56,7 @@ enum {
 	/* host register offsets (from host->iomap[PDC_MMIO_BAR]) */
 	PDC_INT_SEQMASK		= 0x40,	/* Mask of asserted SEQ INTs */
 	PDC_FLASH_CTL		= 0x44, /* Flash control register */
+	PDC_PCI_CTL		= 0x48, /* PCI control/status reg */
 	PDC_SATA_PLUG_CSR	= 0x6C, /* SATA Plug control/status reg */
 	PDC2_SATA_PLUG_CSR	= 0x60, /* SATAII Plug control/status reg */
 	PDC_TBG_MODE		= 0x41C, /* TBG mode (not SATAII) */
@@ -161,6 +162,10 @@ static void pdc_error_handler(struct ata
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 static int pdc_pata_cable_detect(struct ata_port *ap);
 static int pdc_sata_cable_detect(struct ata_port *ap);
+#ifdef CONFIG_PM
+static int pdc_pci_device_resume(struct pci_dev *pdev);
+static int pdc_sata_port_resume(struct ata_port *ap);
+#endif
 
 static struct scsi_host_template pdc_ata_sht = {
 	ATA_BASE_SHT(DRV_NAME),
@@ -190,6 +195,9 @@ static struct ata_port_operations pdc_sa
 	.scr_read		= pdc_sata_scr_read,
 	.scr_write		= pdc_sata_scr_write,
 	.port_start		= pdc_sata_port_start,
+#ifdef CONFIG_PM
+	.port_resume		= pdc_sata_port_resume,
+#endif
 	.hardreset		= pdc_sata_hardreset,
 };
 
@@ -308,6 +316,10 @@ static struct pci_driver pdc_ata_pci_dri
 	.id_table		= pdc_ata_pci_tbl,
 	.probe			= pdc_ata_init_one,
 	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= pdc_pci_device_resume,
+#endif
 };
 
 static int pdc_common_port_start(struct ata_port *ap)
@@ -333,14 +345,8 @@ static int pdc_common_port_start(struct 
 	return 0;
 }
 
-static int pdc_sata_port_start(struct ata_port *ap)
+static void pdc_sata_init_port(struct ata_port *ap)
 {
-	int rc;
-
-	rc = pdc_common_port_start(ap);
-	if (rc)
-		return rc;
-
 	/* fix up PHYMODE4 align timing */
 	if (ap->flags & PDC_FLAG_GEN_II) {
 		void __iomem *sata_mmio = ap->ioaddr.scr_addr;
@@ -350,6 +356,17 @@ static int pdc_sata_port_start(struct at
 		tmp = (tmp & ~3) | 1;	/* set bits 1:0 = 0:1 */
 		writel(tmp, sata_mmio + PDC_PHYMODE4);
 	}
+}
+
+static int pdc_sata_port_start(struct ata_port *ap)
+{
+	int rc;
+
+	rc = pdc_common_port_start(ap);
+	if (rc)
+		return rc;
+
+	pdc_sata_init_port(ap);
 
 	return 0;
 }
@@ -1056,6 +1073,46 @@ static void pdc_host_init(struct ata_hos
 	writel(tmp, host_mmio + PDC_SLEW_CTL);
 }
 
+#ifdef CONFIG_PM
+static int pdc_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+#if 0
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND) {
+		void __iomem *host_mmio = host->iomap[PDC_MMIO_BAR];
+		void __iomem *pcictl_b1_mmio = host_mmio + PDC_PCI_CTL + 1;
+		u8 tmp;
+
+		tmp = readb(pcictl_b1_mmio);
+		tmp &= 0x0F;
+		writeb(tmp, pcictl_b1_mmio);
+		readb(pcictl_b1_mmio); /* flush */
+		tmp |= 0xF0;
+		writeb(tmp, pcictl_b1_mmio);
+		readb(pcictl_b1_mmio); /* flush */
+	}
+#endif
+
+	pdc_host_init(host);
+
+	ata_host_resume(host);
+
+	return 0;
+}
+
+static int pdc_sata_port_resume(struct ata_port *ap)
+{
+	pdc_sata_init_port(ap);
+	return 0;
+}
+#endif
+
 static int pdc_ata_init_one(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
