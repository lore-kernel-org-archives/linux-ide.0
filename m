From: Tejun Heo <htejun@gmail.com>
Subject: Re: via boot up hang during probing for no sata disks
Date: Wed, 16 Aug 2006 14:12:28 +0900
Message-ID: <20060816051228.GH6371@htj.dyndns.org>
References: <200608141533.35448.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:4766 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750786AbWHPFMf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 16 Aug 2006 01:12:35 -0400
Received: by py-out-1112.google.com with SMTP id z74so319467pyg
        for <linux-ide@vger.kernel.org>; Tue, 15 Aug 2006 22:12:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200608141533.35448.ak@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org

On Mon, Aug 14, 2006 at 03:33:35PM +0200, Andi Kleen wrote:
> 
> One of my test machines hangs at boot when booting 2.6.18rc4.
> 
> It seems to busy loop somewhere because the CPU fans spin up.
> 
> The machine doesn't have any disks (just two PATAPI CD-ROMs) 
> and boots over the network.
> 
> The SATA drivers are compiled into the kernel (x86-64 defconfig)
> 
> Strangely it seems to only hang with the 64bit kernel -- when
> I boot a 32bit kernel it usually comes up. It is likely some timing
> issue because booting with initcall_debug also seems to make 
> the problem go away. I verified with a printk and without initcall_debug
> that the hang still happens in svia_init.

Hello, Andi.

Can you try the following patch?

diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
index 03baec2..efa865d 100644
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -74,6 +74,8 @@ enum {
 static int svia_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static u32 svia_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void svia_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
+static void vt6420_error_handler(struct ata_port *ap);
+static void vt6421_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
@@ -107,7 +109,7 @@ static struct scsi_host_template svia_sh
 	.bios_param		= ata_std_bios_param,
 };
 
-static const struct ata_port_operations svia_sata_ops = {
+static const struct ata_port_operations vt6420_sata_ops = {
 	.port_disable		= ata_port_disable,
 
 	.tf_load		= ata_tf_load,
@@ -127,7 +129,7 @@ static const struct ata_port_operations 
 
 	.freeze			= ata_bmdma_freeze,
 	.thaw			= ata_bmdma_thaw,
-	.error_handler		= ata_bmdma_error_handler,
+	.error_handler		= vt6420_error_handler,
 	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
 
 	.irq_handler		= ata_interrupt,
@@ -141,13 +143,47 @@ static const struct ata_port_operations 
 	.host_stop		= ata_host_stop,
 };
 
-static struct ata_port_info svia_port_info = {
+static const struct ata_port_operations vt6421_sata_ops = {
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
+	.error_handler		= vt6421_error_handler,
+	.post_internal_cmd	= ata_bmdma_post_internal_cmd,
+
+	.irq_handler		= ata_interrupt,
+	.irq_clear		= ata_bmdma_irq_clear,
+
+	.scr_read		= svia_scr_read,
+	.scr_write		= svia_scr_write,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+	.host_stop		= ata_host_stop,
+};
+
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
@@ -170,6 +206,48 @@ static void svia_scr_write (struct ata_p
 	outl(val, ap->ioaddr.scr_addr + (4 * sc_reg));
 }
 
+static int vt6420_prereset(struct ata_port *ap)
+{
+	struct ata_eh_context *ehc = &ap->eh_context;
+	unsigned long timeout = jiffies + (HZ * 5);
+	u32 sstatus;
+
+	/* if we're about to do hardreset, nothing more to do */
+	if (ehc->i.action & ATA_EH_HARDRESET)
+		return 0;
+
+	/* Resume phy.  SCR registers in vt6420 are super-fragile and
+	 * can cause system lock up depending on how it's accessed.
+	 * Use the old resume sequence from __sata_phy_reset().
+	 */
+	sata_scr_write_flush(ap, SCR_CONTROL, 0x300);
+
+	/* wait for phy to become ready, if necessary */
+	do {
+		msleep(200);
+		sata_scr_read(ap, SCR_STATUS, &sstatus);
+		if ((sstatus & 0xf) != 1)
+			break;
+	} while (time_before(jiffies, timeout));
+
+	/* wait for !BSY */
+	ata_busy_sleep(ap, ATA_TMOUT_BOOT_QUICK, ATA_TMOUT_BOOT);
+
+	return 0;
+}
+
+static void vt6420_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, vt6420_prereset, ata_std_softreset,
+				  sata_std_hardreset, ata_std_postreset);
+}
+
+static void vt6421_error_handler(struct ata_port *ap)
+{
+	return ata_bmdma_drive_eh(ap, ata_std_prereset, NULL,
+				  sata_std_hardreset, ata_std_postreset);
+}
+
 static const unsigned int svia_bar_sizes[] = {
 	8, 4, 8, 4, 16, 256
 };
@@ -210,7 +288,7 @@ static void vt6421_init_addrs(struct ata
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi = &svia_port_info;
+	struct ata_port_info *ppi = &vt6420_port_info;
 
 	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
@@ -239,7 +317,7 @@ static struct ata_probe_ent *vt6421_init
 
 	probe_ent->sht		= &svia_sht;
 	probe_ent->host_flags	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY;
-	probe_ent->port_ops	= &svia_sata_ops;
+	probe_ent->port_ops	= &vt6421_sata_ops;
 	probe_ent->n_ports	= N_PORTS;
 	probe_ent->irq		= pdev->irq;
 	probe_ent->irq_flags	= IRQF_SHARED;
