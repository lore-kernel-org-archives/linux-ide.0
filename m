From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 6/8] sata_sil: add suspend/sleep support
Date: Wed, 28 Jun 2006 15:23:06 +0900
Message-ID: <11514757862619-git-send-email-htejun@gmail.com>
References: <11514757842728-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.235]:14514 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030459AbWF1GWx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Jun 2006 02:22:53 -0400
Received: by wr-out-0506.google.com with SMTP id i24so346493wra
        for <linux-ide@vger.kernel.org>; Tue, 27 Jun 2006 23:22:53 -0700 (PDT)
In-Reply-To: <11514757842728-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add suspend/sleep support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

0d50db138ae1cfbfb6e6ce67ce58a0e9215117ac
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 04f2cfe..e943fa8 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -109,6 +109,7 @@ enum {
 };
 
 static int sil_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil_pci_device_resume(struct pci_dev *pdev);
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev);
 static u32 sil_scr_read (struct ata_port *ap, unsigned int sc_reg);
 static void sil_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
@@ -160,6 +161,8 @@ static struct pci_driver sil_pci_driver 
 	.id_table		= sil_pci_tbl,
 	.probe			= sil_init_one,
 	.remove			= ata_pci_remove_one,
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil_pci_device_resume,
 };
 
 static struct scsi_host_template sil_sht = {
@@ -178,6 +181,8 @@ static struct scsi_host_template sil_sht
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations sil_ops = {
@@ -695,6 +700,18 @@ err_out:
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


