From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/10] sata_sil: add suspend/sleep support
Date: Tue, 13 Jun 2006 00:50:29 +0900
Message-ID: <11501274291922-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56440 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752079AbWFLPuj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:39 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1663627nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:39 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add suspend/sleep support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

cfac09b587dd3913ebf3f75766a57559e75de672
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 4bff260..bb63db2 100644
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
@@ -660,6 +663,16 @@ err_out:
 	return rc;
 }
 
+static int sil_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+
+	sil_init_controller(pdev, host_set->n_ports, host_set->ports[0]->flags,
+			    host_set->mmio_base);
+
+	return ata_pci_device_resume(pdev);
+}
+
 static int __init sil_init(void)
 {
 	return pci_module_init(&sil_pci_driver);
-- 
1.3.2


