From: "daniel@wolstenholme.net" <daniel@wolstenholme.net>
Subject: Re: libata-dev.git rebased
Date: Wed, 13 Dec 2006 19:21:02 +0000 (UTC)
Message-ID: <17348032.1166037662009.JavaMail.?@fh1064.dia.cp.net>
Reply-To: daniel@wolstenholme.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6109_24998654.1166037662003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpout1483.sc1.he.tucows.com ([64.97.157.183]:34285 "EHLO
	n007.sc1.cp.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965098AbWLMTvv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Dec 2006 14:51:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: dan.j.williams@gmail.com, linux-ide@vger.kernel.org, akpm@osdl.org, htejun@gmail.com

------=_Part_6109_24998654.1166037662003
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jeff,

Here's my rebased patch.  Let me know if there's a problem with it.

Thanks,
Dan

>On 12/1/06, Jeff Garzik <jeff@garzik.org> wrote:
>> I just rebased all branches of libata-dev.git, and there was a bit of
>> fallout:
>>
>> 1) Dan, I'll have to ask you to resend your sata_vsc MSI patch yet
>> again, this time against 2.6.19.  Since it was against
>> drivers/scsi/sata_vsc.c, that caused some cross-directory-move related
>> problems.
>I've copied Dan Wolstenholme.
>
>Regards,
>Dan Williams


------=_Part_6109_24998654.1166037662003
Content-Type: APPLICATION/OCTET-STREAM; name=patch.sata_vsc.2.6.19
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=patch.sata_vsc.2.6.19; size=3204

diff -uprN a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
--- a/drivers/ata/sata_vsc.c	2006-11-29 14:57:37.000000000 -0700
+++ b/drivers/ata/sata_vsc.c	2006-12-05 12:34:44.000000000 -0700
@@ -94,8 +94,14 @@ enum {
 			      VSC_SATA_INT_ERROR_P    | VSC_SATA_INT_ERROR_R | \
 			      VSC_SATA_INT_ERROR_E    | VSC_SATA_INT_ERROR_M | \
 			      VSC_SATA_INT_PHY_CHANGE),
+
+	/* Host private flags (hp_flags) */
+	VSC_SATA_HP_FLAG_MSI    = (1 << 0),
 };
 
+struct vsc_sata_host_priv {
+	u32	hp_flags;
+};
 
 #define is_vsc_sata_int_err(port_idx, int_status) \
 	 (int_status & (VSC_SATA_INT_ERROR << (8 * port_idx)))
@@ -118,6 +124,20 @@ static void vsc_sata_scr_write (struct a
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
+
 static void vsc_intr_mask_update(struct ata_port *ap, u8 ctl)
 {
 	void __iomem *mask_addr;
@@ -307,7 +327,7 @@ static const struct ata_port_operations 
 	.scr_write		= vsc_sata_scr_write,
 	.port_start		= ata_port_start,
 	.port_stop		= ata_port_stop,
-	.host_stop		= ata_pci_host_stop,
+	.host_stop		= vsc_sata_host_stop,
 };
 
 static void __devinit vsc_sata_setup_port(struct ata_ioports *port, unsigned long base)
@@ -336,6 +356,7 @@ static int __devinit vsc_sata_init_one (
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent = NULL;
+	struct vsc_sata_host_priv *hpriv;
 	unsigned long base;
 	int pci_dev_busy = 0;
 	void __iomem *mmio_base;
@@ -377,6 +398,7 @@ static int __devinit vsc_sata_init_one (
 		rc = -ENOMEM;
 		goto err_out_regions;
 	}
+
 	memset(probe_ent, 0, sizeof(*probe_ent));
 	probe_ent->dev = pci_dev_to_dev(pdev);
 	INIT_LIST_HEAD(&probe_ent->node);
@@ -388,19 +410,33 @@ static int __devinit vsc_sata_init_one (
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
 	probe_ent->port_flags = ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				ATA_FLAG_MMIO;
 	probe_ent->port_ops = &vsc_sata_ops;
 	probe_ent->n_ports = 4;
 	probe_ent->irq = pdev->irq;
-	probe_ent->irq_flags = IRQF_SHARED;
 	probe_ent->mmio_base = mmio_base;
+	probe_ent->private_data = hpriv;
 
 	/* We don't care much about the PIO/UDMA masks, but the core won't like us
 	 * if we don't fill these
@@ -427,10 +463,12 @@ static int __devinit vsc_sata_init_one (
 
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

------=_Part_6109_24998654.1166037662003--

