From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] ahci: ahci: implement workaround for ASUS P5W-DH Deluxe
	ahci_broken_hardreset(), take #2
Date: Thu, 25 Oct 2007 14:59:16 +0900
Message-ID: <20071025055916.GG11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:43215 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846AbXJYF7X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 01:59:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so385086rvb
        for <linux-ide@vger.kernel.org>; Wed, 24 Oct 2007 22:59:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

P5W-DH Deluxe has ICH9 which doesn't have PMP support but SIMG 4726
hardwired to the second port of AHCI controller at PCI device 1f.2.
The 4726 doesn't work as PMP but as a storage processor which can do
hardware RAID on downstream ports.

When no device is attached to the downstream port of the 4726, pseudo
ATA device for configuration appears.  Unfortunately, ATA emulation on
the device is very lousy and causes long hang during boot.

This patch implements workaround for the board.  If the mainboard is
P5W-DH Deluxe (matched using DMI), only hardreset is used on the
second port of AHCI controller @ 1f.2 and the hardreset doesn't depend
on receiving the first FIS and just proceed to IDENTIFY.

This workaround fixes bugzilla #8923.

  http://bugzilla.kernel.org/show_bug.cgi?id=8923

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Okay, here's improved version.  p5wdh hardreset is sufficiently
different from vt8251, so it now has its own hardreset and ops.  It
now also has two secs + 150ms delay after hardreset so that devices
which are slow to respond after hardreset don't fail.  Most devices
will respond in time unless it's spinning up.  Spin up is handled by
reset retrials.  Also, it sets BSY before initiating BSY and performs
CLO afterward if BSY isn't cleared during the wait.

Change from the first take are minor but make the workaoround fit the
problem better.  Tested on a setup which behaves the same way as
P5W-DH (non-PMP capable ICH AHCI + SIMG 4726) with some number of
harddrives and ATAPI devices.  Everything including hotplug works
fine.

 drivers/ata/ahci.c |  144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

Index: work/drivers/ata/ahci.c
===================================================================
--- work.orig/drivers/ata/ahci.c
+++ work/drivers/ata/ahci.c
@@ -41,6 +41,7 @@
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>
@@ -241,6 +242,7 @@ static void ahci_pmp_attach(struct ata_p
 static void ahci_pmp_detach(struct ata_port *ap);
 static void ahci_error_handler(struct ata_port *ap);
 static void ahci_vt8251_error_handler(struct ata_port *ap);
+static void ahci_p5wdh_error_handler(struct ata_port *ap);
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc);
 static int ahci_port_resume(struct ata_port *ap);
 static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl);
@@ -339,6 +341,40 @@ static const struct ata_port_operations 
 	.port_stop		= ahci_port_stop,
 };
 
+static const struct ata_port_operations ahci_p5wdh_ops = {
+	.check_status		= ahci_check_status,
+	.check_altstatus	= ahci_check_status,
+	.dev_select		= ata_noop_dev_select,
+
+	.tf_read		= ahci_tf_read,
+
+	.qc_defer		= sata_pmp_qc_defer_cmd_switch,
+	.qc_prep		= ahci_qc_prep,
+	.qc_issue		= ahci_qc_issue,
+
+	.irq_clear		= ahci_irq_clear,
+
+	.scr_read		= ahci_scr_read,
+	.scr_write		= ahci_scr_write,
+
+	.freeze			= ahci_freeze,
+	.thaw			= ahci_thaw,
+
+	.error_handler		= ahci_p5wdh_error_handler,
+	.post_internal_cmd	= ahci_post_internal_cmd,
+
+	.pmp_attach		= ahci_pmp_attach,
+	.pmp_detach		= ahci_pmp_detach,
+
+#ifdef CONFIG_PM
+	.port_suspend		= ahci_port_suspend,
+	.port_resume		= ahci_port_resume,
+#endif
+
+	.port_start		= ahci_port_start,
+	.port_stop		= ahci_port_stop,
+};
+
 #define AHCI_HFLAGS(flags)	.private_data	= (void *)(flags)
 
 static const struct ata_port_info ahci_port_info[] = {
@@ -1213,6 +1249,53 @@ static int ahci_vt8251_hardreset(struct 
 	return rc ?: -EAGAIN;
 }
 
+static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
+				unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+	struct ata_taskfile tf;
+	int rc;
+
+	ahci_stop_engine(ap);
+
+	/* clear D2H reception area to properly wait for D2H FIS */
+	ata_tf_init(link->device, &tf);
+	tf.command = 0x80;
+	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
+
+	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
+				 deadline);
+
+	ahci_start_engine(ap);
+
+	if (rc || ata_link_offline(link))
+		return rc;
+
+	/* spec mandates ">= 2ms" before checking status */
+	msleep(150);
+
+	/* The pseudo configuration device on SIMG4726 attached to
+	 * ASUS P5W-DH Deluxe doesn't send signature FIS after
+	 * hardreset if no device is attached to the first downstream
+	 * port && the pseudo device locks up on SRST w/ PMP==0.  To
+	 * work around this, wait for !BSY only briefly.  If BSY isn't
+	 * cleared, perform CLO and proceed to IDENTIFY (achieved by
+	 * ATA_LFLAG_NO_SRST and ATA_LFLAG_ASSUME_ATA).
+	 *
+	 * Wait for two seconds.  Devices attached to downstream port
+	 * which can't process the following IDENTIFY after this will
+	 * have to be reset again.  For most cases, this should
+	 * suffice while making probing snappish enough.
+	 */
+	rc = ata_wait_ready(ap, jiffies + 2 * HZ);
+	if (rc)
+		ahci_kick_engine(ap, 0);
+
+	return 0;
+}
+
 static void ahci_postreset(struct ata_link *link, unsigned int *class)
 {
 	struct ata_port *ap = link->ap;
@@ -1670,6 +1753,19 @@ static void ahci_vt8251_error_handler(st
 		  ahci_postreset);
 }
 
+static void ahci_p5wdh_error_handler(struct ata_port *ap)
+{
+	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
+		/* restart engine */
+		ahci_stop_engine(ap);
+		ahci_start_engine(ap);
+	}
+
+	/* perform recovery */
+	ata_do_eh(ap, ata_std_prereset, ahci_softreset, ahci_p5wdh_hardreset,
+		  ahci_postreset);
+}
+
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
@@ -1955,6 +2051,51 @@ static void ahci_print_info(struct ata_h
 		);
 }
 
+/* On ASUS P5W DH Deluxe, the second port of PCI device 00:1f.2 is
+ * hardwired to on-board SIMG 4726.  The chipset is ICH8 and doesn't
+ * support PMP and the 4726 either directly exports the device
+ * attached to the first downstream port or acts as a hardware storage
+ * controller and emulate a single ATA device (can be RAID 0/1 or some
+ * other configuration).
+ *
+ * When there's no device attached to the first downstream port of the
+ * 4726, "Config Disk" appears, which is a pseudo ATA device to
+ * configure the 4726.  However, ATA emulation of the device is very
+ * lame.  It doesn't send signature D2H Reg FIS after the initial
+ * hardreset, pukes on SRST w/ PMP==0 and has bunch of other issues.
+ *
+ * The following function works around the problem by always using
+ * hardreset on the port and not depending on receiving signature FIS
+ * afterward.  If signature FIS isn't received soon, ATA class is
+ * assumed without follow-up softreset.
+ */
+static void ahci_p5wdh_workaround(struct ata_host *host)
+{
+	static struct dmi_system_id sysids[] = {
+		{
+			.ident = "P5W DH Deluxe",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR,
+					  "ASUSTEK COMPUTER INC"),
+				DMI_MATCH(DMI_PRODUCT_NAME, "P5W DH Deluxe"),
+			},
+		},
+		{ }
+	};
+	struct pci_dev *pdev = to_pci_dev(host->dev);
+
+	if (pdev->bus->number == 0 && pdev->devfn == PCI_DEVFN(0x1f, 2) &&
+	    dmi_check_system(sysids)) {
+		struct ata_port *ap = host->ports[1];
+
+		dev_printk(KERN_INFO, &pdev->dev, "enabling ASUS P5W DH "
+			   "Deluxe on-board SIMG4726 workaround\n");
+
+		ap->ops = &ahci_p5wdh_ops;
+		ap->link.flags |= ATA_LFLAG_NO_SRST | ATA_LFLAG_ASSUME_ATA;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version;
@@ -2024,6 +2165,9 @@ static int ahci_init_one(struct pci_dev 
 			ap->ops = &ata_dummy_port_ops;
 	}
 
+	/* apply workaround for ASUS P5W DH Deluxe mainboard */
+	ahci_p5wdh_workaround(host);
+
 	/* initialize adapter */
 	rc = ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
 	if (rc)
