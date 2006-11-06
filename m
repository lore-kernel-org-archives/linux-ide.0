From: "daniel@wolstenholme.net" <daniel@wolstenholme.net>
Subject: Re: [PATCH] sata_vsc: Add MSI support to sata_vsc driver (resubmit)
 (fixed attachment)
Date: Mon, 6 Nov 2006 15:46:06 +0000 (UTC)
Message-ID: <16348455.1162827966244.JavaMail.?@fh1037.dia.cp.net>
Reply-To: "daniel@wolstenholme.net" <daniel@wolstenholme.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_13178_7155711.1162827966233"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1472.sc1.he.tucows.com ([64.97.157.172]:44185 "EHLO
	n007.sc1.cp.net") by vger.kernel.org with ESMTP id S1753218AbWKFPqH
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Nov 2006 10:46:07 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org

------=_Part_13178_7155711.1162827966233
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>Wolstenholme, Daniel E wrote:
>> Ok, hopefully I can get the attachment right here.
>> 
>> Here's a resubmission of my MSI patch for the sata_vsc driver.
>> 
>> I've added a new vsc_sata_host_priv data structure (basically copied
>> from the sata_mv driver) which has an hp_flags bitfield with a bit to
>> indicate whether MSI is being used. This is used in the new
>> vsc_sata_host_stop() routine to call
>> pci_disable_msi() if MSI is on, pci_intx() if not.
>> 
>> Signed-off-by: Daniel Wolstenholme <daniel.e.wolstenholme@intel.com>
>
>ACK the patch technical content.
>
>Unfortunately, the patch was corrupted, and tabs were converted to 
>spaces, which makes it impossible to apply the patch.

Ok,
I'm going to try my personal webmail account now.  Sorry about all the 
trouble.

Dan


------=_Part_13178_7155711.1162827966233
Content-Type: APPLICATION/OCTET-STREAM; name=patch.sata_vsc
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=patch.sata_vsc; size=3205

diff -uprN a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c	2006-09-19 20:42:06.000000000 -0700
+++ b/drivers/scsi/sata_vsc.c	2006-10-16 12:11:43.000000000 -0700
@@ -94,8 +94,14 @@ enum {
 			      VSC_SATA_INT_ERROR_P    | VSC_SATA_INT_ERROR_R | \
 			      VSC_SATA_INT_ERROR_E    | VSC_SATA_INT_ERROR_M | \
 			      VSC_SATA_INT_PHY_CHANGE),
+
+	/* Host private flags (hp_flags) */
+	VSC_SATA_HP_FLAG_MSI	= (1 << 0),
 };
 
+struct vsc_sata_host_priv {
+	u32			hp_flags;
+};
 
 #define is_vsc_sata_int_err(port_idx, int_status) \
 	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
@@ -118,6 +124,19 @@ static void vsc_sata_scr_write (struct a
 }
 
 
+static void vsc_sata_host_stop(struct ata_host_set *host_set)
+{
+	struct vsc_sata_host_priv *hpriv = host_set->private_data;
+	struct pci_dev *pdev = to_pci_dev(host_set->dev);
+
+	if (hpriv->hp_flags & VSC_SATA_HP_FLAG_MSI)
+		pci_disable_msi(pdev);
+	else
+		pci_intx(pdev, 0);
+	kfree (hpriv);
+	ata_pci_host_stop(host_set);
+}
+
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *mask_addr;
@@ -308,7 +327,7 @@ static const struct ata_port_operations 
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= vsc_sata_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -337,6 +356,7 @@ static int __devinit vsc_sata_init_one (
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
+	struct vsc_sata_host_priv *hpriv;
 	unsigned long base;
 	int pci_dev_busy = 0;
 	void __iomem *mmio_base;
@@ -378,6 +398,7 @@ static int __devinit vsc_sata_init_one (
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -389,19 +410,33 @@ static int __devinit vsc_sata_init_one (
 	}
 	base = (unsigned long) mmio_base;
 
+	hpriv = kmalloc(sizeof(*hpriv), GFP_KERNEL);
+	if (!hpriv) {
+		rc = -ENOMEM;
+		goto err_out_iounmap;
+	}
+	memset(hpriv, 0, sizeof(*hpriv));
+
 	/*
 	 * Due to a bug in the chip, the default cache line size can't be used
 	 */
 	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
 
+	if (pci_enable_msi(pdev) == 0) {
+		hpriv->hp_flags |= VSC_SATA_HP_FLAG_MSI;
+		pci_intx(pdev, 0);
+	}
+	else
+		probe_ent->irq_flags = IRQF_SHARED;
+
 	probe_ent->sht = &vsc_sata_sht;
 	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				ATA_FLAG_MMIO;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
+	probe_ent->private_data = hpriv;
 
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
 	 * if we don't fill these
@@ -428,10 +463,12 @@ static int __devinit vsc_sata_init_one (
 
 	/* FIXME: check ata_device_add return value */
 	ata_device_add(probe_ent);
-	kfree(probe_ent);
 
+	kfree(probe_ent);
 	return 0;
 
+err_out_iounmap:
+	pci_iounmap(pdev, mmio_base);
 err_out_free_ent:
 	kfree(probe_ent);
 err_out_regions:

------=_Part_13178_7155711.1162827966233--

