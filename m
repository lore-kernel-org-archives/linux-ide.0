From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] sata_via: use old SCR access pattern on vt6420
Date: Wed, 23 Aug 2006 01:00:27 +0900
Message-ID: <20060822160027.GC21866@htj.dyndns.org>
References: <200608141533.35448.ak@suse.de> <20060816051228.GH6371@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.207]:43635 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751403AbWHVQAe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Aug 2006 12:00:34 -0400
Received: by nz-out-0102.google.com with SMTP id 14so528582nzn
        for <linux-ide@vger.kernel.org>; Tue, 22 Aug 2006 09:00:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060816051228.GH6371@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

vt6420 has super-fragile SCR registers which can hang the whole
machine if accessed with the wrong timings.  This patch makes sata_via
use SCR registers only during probing and with the same timings as
before (pre new EH), which is proven to work.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---

Andi, can you please test this patch?  This adds two more SCR accesses
for link status printing (as in the pre EH code) and prevents all SCR
accesses once probing is complete.  This should work but I wanna make
sure.

Jeff, if Andi confirms, this one is good for #uptream-fixes.  It fixes
a apparent regression.  I'll post patches for vt6421 soon.

Thanks.

 drivers/scsi/sata_via.c |  117 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 5 deletions(-)

Index: work-c3/drivers/scsi/sata_via.c
===================================================================
--- work-c3.orig/drivers/scsi/sata_via.c
+++ work-c3/drivers/scsi/sata_via.c
@@ -74,6 +74,7 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
@@ -107,7 +108,38 @@ static struct scsi_host_template svia_sh
 	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations svia_sata_ops = {
+static const struct ata_port_operations vt6420_sata_ops = {
+	.port_disable		= ata_port_disable,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.check_status		= ata_check_status,
+	.exec_command		= ata_exec_command,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup            = ata_bmdma_setup,
+	.bmdma_start            = ata_bmdma_start,
+	.bmdma_stop		= ata_bmdma_stop,
+	.bmdma_status		= ata_bmdma_status,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+	.data_xfer		= ata_pio_data_xfer,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= vt6420_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
+static const struct ata_port_operations vt6421_sata_ops = {
 	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load,
@@ -141,13 +173,13 @@ static const struct ata_port_operations 
 	.host_stop		= ata_host_stop,
 };
 
-static struct ata_port_info svia_port_info = {
+static struct ata_port_info vt6420_port_info = {
 	.sht		= &svia_sht,
 	.host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY,
 	.pio_mask	= 0x1f,
 	.mwdma_mask	= 0x07,
 	.udma_mask	= 0x7f,
-	.port_ops	= &svia_sata_ops,
+	.port_ops	= &vt6420_sata_ops,
 };
 
 MODULE_AUTHOR("Jeff Garzik");
@@ -170,6 +202,81 @@ static void svia_scr_write (struct ata_p
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+/**
+ *	vt6420_prereset - prereset for vt6420
+ *	@ap: target ATA port
+ *
+ *	SCR registers on vt6420 are pieces of shit and may hang the
+ *	whole machine completely if accessed with the wrong timing.
+ *	To avoid such catastrophe, vt6420 doesn't provide generic SCR
+ *	access operations, but uses SStatus and SControl only during
+ *	boot probing in controlled way.
+ *
+ *	As the old (pre EH update) probing code is proven to work, we
+ *	strictly follow the access pattern.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int vt6420_prereset(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus, scontrol;
+	int online;
+
+	/* don't do any SCR stuff if we're not loading */
+	if (!ATA_PFLAG_LOADING)
+		goto skip_scr;
+
+	/* Resume phy.  This is the old resume sequence from
+	 * __sata_phy_reset().
+	 */
+	svia_scr_write(ap, SCR_CONTROL, 0x300);
+	svia_scr_read(ap, SCR_CONTROL); /* flush */
+
+	/* wait for phy to become ready, if necessary */
+	do {
+		msleep(200);
+		if ((svia_scr_read(ap, SCR_STATUS) & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* open code sata_print_link_status() */
+	sstatus = svia_scr_read(ap, SCR_STATUS);
+	scontrol = svia_scr_read(ap, SCR_CONTROL);
+
+	online = (sstatus & 0xf) == 0x3;
+
+	ata_port_printk(ap, KERN_INFO,
+			"SATA link %s 1.5 Gbps (SStatus %X SControl %X)\n",
+			online ? "up" : "down", sstatus, scontrol);
+
+	/* SStatus is read one more time */
+	svia_scr_read(ap, SCR_STATUS);
+
+	if (!online) {
+		/* tell EH to bail */
+		ehc->i.action &= ~ATA_EH_RESET_MASK;
+		return 0;
+	}
+
+ skip_scr:
+	/* wait for !BSY */
+	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+
+	return 0;
+}
+
+static void vt6420_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
+				  NULL, ata_std_postreset);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -210,7 +317,7 @@ static void vt6421_init_addrs(struct ata
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi = &svia_port_info;
+	struct ata_port_info *ppi = &vt6420_port_info;
 
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
@@ -239,7 +346,7 @@ static struct ata_probe_ent *vt6421_init
 
 	probe_ent->sht		= &svia_sht;
 	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops	= &svia_sata_ops;
+	probe_ent->port_ops	= &vt6421_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
 	probe_ent->irq_flags	= IRQF_SHARED;
