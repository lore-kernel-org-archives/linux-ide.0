From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: pata_legacy: Merge winbond support
Date: Sat, 19 Jan 2008 15:47:23 +0000
Message-ID: <20080119154723.40e0f58b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38285 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761019AbYASPtV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jan 2008 10:49:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

This puts winbond VLB in with the other ISA/VLB support and means we can
lose pata_winbond.c. With all the VLB/ISA probe in one space (and out of
the core libata) this makes legacy probing work sanely.

Also switch to devm_ for resource handling on the ports post probe

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_legacy.c linux-2.6.24-rc8-mm1/drivers/ata/pata_legacy.c
--- linux.vanilla-2.6.24-rc8-mm1/drivers/ata/pata_legacy.c	2008-01-19 14:47:56.000000000 +0000
+++ linux-2.6.24-rc8-mm1/drivers/ata/pata_legacy.c	2008-01-19 15:18:06.000000000 +0000
@@ -28,7 +28,6 @@
  *
  *  Unsupported but docs exist:
  *	Appian/Adaptec AIC25VL01/Cirrus Logic PD7220
- *	Winbond W83759A
  *
  *  This driver handles legacy (that is "ISA/VLB side") IDE ports found
  *  on PC class systems. There are three hybrid devices that are exceptions
@@ -36,7 +35,7 @@
  *  the MPIIX where the tuning is PCI side but the IDE is "ISA side".
  *
  *  Specific support is included for the ht6560a/ht6560b/opti82c611a/
- *  opti82c465mv/promise 20230c/20630
+ *  opti82c465mv/promise 20230c/20630/winbond83759A
  *
  *  Use the autospeed and pio_mask options with:
  *	Appian ADI/2 aka CLPD7220 or AIC25VL01.
@@ -47,9 +46,6 @@
  *  For now use autospeed and pio_mask as above with the W83759A. This may
  *  change.
  *
- *  TODO
- *	Merge existing pata_qdi driver
- *
  */
 
 #include <linux/kernel.h>
@@ -64,7 +60,7 @@
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_legacy"
-#define DRV_VERSION "0.5.5"
+#define DRV_VERSION "0.6.5"
 
 #define NR_HOST 6
 
@@ -92,6 +88,7 @@
 	QDI6500 = 7,
 	QDI6580 = 8,
 	QDI6580DP = 9,		/* Dual channel mode is different */
+	W83759A = 10,
 
 	UNKNOWN = -1
 };
@@ -111,7 +108,8 @@
 	struct ata_port_operations *ops;
 	unsigned int pio_mask;
 	unsigned int flags;
-	int (*setup)(struct legacy_probe *probe, struct legacy_data *data);
+	int (*setup)(struct platform_device *, struct legacy_probe *probe, 
+		struct legacy_data *data);
 };
 
 static int legacy_port[NR_HOST] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
@@ -128,6 +126,8 @@
 static int opti82c611a;		/* Opti82c611A on primary 1, sec 2, both 3 */
 static int opti82c46x;		/* Opti 82c465MV present(pri/sec autodetect) */
 static int qdi;			/* Set to probe QDI controllers */
+static int winbond;		/* Set to probe Winbond controllers, 
+					give I/O port if non stdanard */
 static int autospeed;		/* Chip present which snoops speed changes */
 static int pio_mask = 0x1F;	/* PIO range for autospeed devices */
 static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */
@@ -891,9 +891,7 @@
 	return ata_qc_issue_prot(qc);
 }
 
-/* For the 6580 can we flip the FIFO on/off at this point ? */
-
-static unsigned int qdi_data_xfer(struct ata_device *adev, unsigned char *buf,
+static unsigned int vlb32_data_xfer(struct ata_device *adev, unsigned char *buf,
 					unsigned int buflen, int rw)
 {
 	struct ata_port *ap = adev->link->ap;
@@ -922,6 +920,15 @@
 		return ata_data_xfer(adev, buf, buflen, rw);
 }
 
+static int qdi_port(struct platform_device *dev, 
+			struct legacy_probe *lp, struct legacy_data *ld)
+{
+	if (devm_request_region(&dev->dev, lp->private, 4, "qdi") == NULL)
+		return -EBUSY;
+	ld->timing = lp->private;
+	return 0;
+}
+
 static struct ata_port_operations qdi6500_port_ops = {
 	.set_piomode	= qdi6500_set_piomode,
 
@@ -940,7 +947,7 @@
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
 
-	.data_xfer	= qdi_data_xfer,
+	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
@@ -967,7 +974,7 @@
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= ata_qc_issue_prot,
 
-	.data_xfer	= qdi_data_xfer,
+	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
@@ -994,7 +1001,7 @@
 	.qc_prep 	= ata_qc_prep,
 	.qc_issue	= qdi_qc_issue_prot,
 
-	.data_xfer	= qdi_data_xfer,
+	.data_xfer	= vlb32_data_xfer,
 
 	.irq_handler	= ata_interrupt,
 	.irq_clear	= ata_bmdma_irq_clear,
@@ -1003,6 +1010,97 @@
 	.port_start	= ata_sff_port_start,
 };
 
+static DEFINE_SPINLOCK(winbond_lock);
+
+static void winbond_writecfg(unsigned long port, u8 reg, u8 val)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&winbond_lock, flags);
+	outb(reg, port + 0x01);
+	outb(val, port + 0x02);
+	spin_unlock_irqrestore(&winbond_lock, flags);
+}
+
+static u8 winbond_readcfg(unsigned long port, u8 reg)
+{
+	u8 val;
+
+	unsigned long flags;
+	spin_lock_irqsave(&winbond_lock, flags);
+	outb(reg, port + 0x01);
+	val = inb(port + 0x02);
+	spin_unlock_irqrestore(&winbond_lock, flags);
+
+	return val;
+}
+
+static void winbond_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct ata_timing t;
+	struct legacy_data *winbond = ap->host->private_data;
+	int active, recovery;
+	u8 reg;
+	int timing = 0x88 + (ap->port_no * 4) + (adev->devno * 2);
+
+	reg = winbond_readcfg(winbond->timing, 0x81);
+
+	/* Get the timing data in cycles */
+	if (reg & 0x40)		/* Fast VLB bus, assume 50MHz */
+		ata_timing_compute(adev, adev->pio_mode, &t, 20000, 1000);
+	else
+		ata_timing_compute(adev, adev->pio_mode, &t, 30303, 1000);
+
+	active = (FIT(t.active, 3, 17) - 1) & 0x0F;
+	recovery = (FIT(t.recover, 1, 15) + 1) & 0x0F;
+	timing = (active << 4) | recovery;
+	winbond_writecfg(winbond->timing, timing, reg);
+
+	/* Load the setup timing */
+
+	reg = 0x35;
+	if (adev->class != ATA_DEV_ATA)
+		reg |= 0x08;	/* FIFO off */
+	if (!ata_pio_need_iordy(adev))
+		reg |= 0x02;	/* IORDY off */
+	reg |= (FIT(t.setup, 0, 3) << 6);
+	winbond_writecfg(winbond->timing, timing + 1, reg);
+}
+
+static int winbond_port(struct platform_device *dev, 
+			struct legacy_probe *lp, struct legacy_data *ld)
+{
+	if (devm_request_region(&dev->dev, lp->private, 4, "winbond") == NULL)
+		return -EBUSY;
+	ld->timing = lp->private;
+	return 0;
+}
+
+static struct ata_port_operations winbond_port_ops = {
+	.set_piomode	= winbond_set_piomode,
+
+	.tf_load	= ata_tf_load,
+	.tf_read	= ata_tf_read,
+	.check_status 	= ata_check_status,
+	.exec_command	= ata_exec_command,
+	.dev_select 	= ata_std_dev_select,
+
+	.freeze		= ata_bmdma_freeze,
+	.thaw		= ata_bmdma_thaw,
+	.error_handler	= ata_bmdma_error_handler,
+	.post_internal_cmd = ata_bmdma_post_internal_cmd,
+	.cable_detect	= ata_cable_40wire,
+
+	.qc_prep 	= ata_qc_prep,
+	.qc_issue	= ata_qc_issue_prot,
+
+	.data_xfer	= vlb32_data_xfer,
+
+	.irq_clear	= ata_bmdma_irq_clear,
+	.irq_on		= ata_irq_on,
+
+	.port_start	= ata_sff_port_start,
+};
+
 static struct legacy_controller controllers[] = {
 	{"BIOS",	&legacy_port_ops, 	0x1F,
 						ATA_FLAG_NO_IORDY,	NULL },
@@ -1019,11 +1117,13 @@
 	{"OPTI82C46X",	&opti82c46x_port_ops,	0x0F,
 						0	       ,	NULL },
 	{"QDI6500",	&qdi6500_port_ops,	0x07,
-						ATA_FLAG_NO_IORDY,	NULL },
+					ATA_FLAG_NO_IORDY,	qdi_port },
 	{"QDI6580",	&qdi6580_port_ops,	0x1F,
-						0	       ,	NULL },
+					0	       ,	qdi_port },
 	{"QDI6580DP",	&qdi6580dp_port_ops,	0x1F,
-						0	       ,	NULL }
+					0	       ,	qdi_port },
+	{"W83759A",	&winbond_port_ops,	0x1F,
+					0	       ,	winbond_port }
 };
 
 /**
@@ -1034,10 +1134,26 @@
  *	check if the controller appears to be driveless at this point.
  */
 
-static int probe_chip_type(struct legacy_probe *probe)
+static __init int probe_chip_type(struct legacy_probe *probe)
 {
 	int mask = 1 << probe->slot;
 
+	if (winbond && (probe->port == 0x1F0 || probe->port == 0x170)) {
+		u8 reg = winbond_readcfg(winbond, 0x81);
+		reg |= 0x80;	/* jumpered mode off */
+		winbond_writecfg(winbond, 0x81, reg);
+		reg = winbond_readcfg(winbond, 0x83);
+		reg |= 0xF0;	/* local control */
+		winbond_writecfg(winbond, 0x83, reg);
+		reg = winbond_readcfg(winbond, 0x85);
+		reg |= 0xF0;	/* programmable timing */
+		winbond_writecfg(winbond, 0x85, reg);
+
+		reg = winbond_readcfg(winbond, 0x81);
+
+		if (reg & mask)
+			return W83759A;
+	}
 	if (probe->port == 0x1F0) {
 		unsigned long flags;
 		local_irq_save(flags);
@@ -1127,7 +1243,7 @@
 	if (!io_addr || !ctrl_addr)
 		goto fail;
 	if (controller->setup)
-		if (controller->setup(probe, ld) < 0)
+		if (controller->setup(pdev, probe, ld) < 0)
 			goto fail;
 	host = ata_host_alloc(&pdev->dev, 1);
 	if (!host)
@@ -1141,7 +1257,7 @@
 	ap->ioaddr.altstatus_addr = ctrl_addr;
 	ap->ioaddr.ctl_addr = ctrl_addr;
 	ata_std_ports(&ap->ioaddr);
-	ap->private_data = ld;
+	ap->host->private_data = ld;
 
 	ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", io, io + 0x0206);
 
@@ -1164,9 +1280,6 @@
 fail:
 	if (host)
 		ata_host_detach(host);
-	/* FIXME: use devm for this */
-	if (ld->timing)
-		release_region(ld->timing, 2);
 	platform_device_unregister(pdev);
 	return ret;
 }
@@ -1184,7 +1297,7 @@
  *	is the right driver anyway.
  */
 
-static void legacy_check_special_cases(struct pci_dev *p, int *primary,
+static void __init legacy_check_special_cases(struct pci_dev *p, int *primary,
 								int *secondary)
 {
 	/* Cyrix CS5510 pre SFF MWDMA ATA on the bridge */
@@ -1249,11 +1362,9 @@
 	/* Check card type */
 	if ((r & 0xF0) == 0xC0) {
 		/* QD6500: single channel */
-		if (r & 8) {
+		if (r & 8)
 			/* Disabled ? */
-			release_region(port, 2);
 			return;
-		}
 		legacy_probe_add(ide_port[r & 0x01], 14 + (r & 0x01),
 								QDI6500, port);
 	}
@@ -1273,6 +1384,7 @@
 			/* port + 0x02, r & 0x04 */
 			legacy_probe_add(0x170, 15, QDI6580DP, port + 2);
 		}
+		release_region(port + 2, 2);
 	}
 }
 
@@ -1315,11 +1427,9 @@
 			r = inb(port + 1);
 			udelay(1);
 			/* Check port agrees with port set */
-			if ((r & 2) >> 1 != i) {
-				release_region(port, 2);
-				continue;
-			}
-			qdi65_identify_port(r, res, port);
+			if ((r & 2) >> 1 == i)
+				qdi65_identify_port(r, res, port);
+			release_region(port, 2);
 		}
 	}
 }
@@ -1364,6 +1474,9 @@
 		   legacy ports */
 		pci_present = 1;
 	}
+	
+	if (winbond == 1)
+		winbond = 0x130;	/* Default port, alt is 1B0 */
 
 	if (primary == 0 || all)
 		legacy_probe_add(0x1F0, 14, UNKNOWN, 0);
@@ -1383,7 +1496,6 @@
 	if (qdi)
 		probe_qdi_vlb();
 
-
 	for (i = 0; i < NR_HOST; i++, pl++) {
 		if (pl->port == 0)
 			continue;
@@ -1406,8 +1518,6 @@
 		struct legacy_data *ld = &legacy_data[i];
 		ata_host_detach(legacy_host[i]);
 		platform_device_unregister(ld->platform_dev);
-		if (ld->timing)
-			release_region(ld->timing, 2);
 	}
 }
 
