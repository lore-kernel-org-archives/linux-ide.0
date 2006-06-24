From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/15] sata_sil: add suspend/sleep support
Date: Sat, 24 Jun 2006 20:30:20 +0900
Message-ID: <11511486202327-git-send-email-htejun@gmail.com>
References: <11511486183271-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:48166 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S933040AbWFXLaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Jun 2006 07:30:14 -0400
Received: by py-out-1112.google.com with SMTP id t32so931812pyc
        for <linux-ide@vger.kernel.org>; Sat, 24 Jun 2006 04:30:14 -0700 (PDT)
In-Reply-To: <11511486183271-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add suspend/sleep support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

f42d5b06e40d39a08132daaca396be63ed1e5fde
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 5c78fe8..d20e3c0 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -107,6 +107,7 @@ enum {
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil_pci_device_resume(struct pci_dev *pdev);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -158,6 +159,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil_pci_device_resume,
 };
 
 static struct scsi_host_template sil_sht = {
@@ -176,6 +179,8 @@ static struct scsi_host_template sil_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations sil_ops = {
@@ -678,6 +683,18 @@ err_out:
 	return rc;
 }
 
+static int sil_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	ata_pci_device_do_resume(pdev);
+	sil_init_controller(pdev, host_set->n_ports, host_set->ports[0]->flags,
+			    host_set->mmio_base);
+	ata_host_set_resume(host_set);
+
+	return 0;
+}
+
 static int __init sil_init(void)
 {
 	return pci_module_init(&sil_pci_driver);
-- 
1.3.2


