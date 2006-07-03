From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/11] sata_sil24: add suspend/sleep support
Date: Mon, 3 Jul 2006 16:07:27 +0900
Message-ID: <11519104471143-git-send-email-htejun@gmail.com>
References: <11519104451998-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:59460 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751087AbWGCHG5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Jul 2006 03:06:57 -0400
Received: by wx-out-0102.google.com with SMTP id t10so500111wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Jul 2006 00:06:57 -0700 (PDT)
In-Reply-To: <11519104451998-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add suspend/sleep support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

44ecebd2a8841e439bea118f9014f509ce05b553
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 16565e2..b8e590d 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -92,6 +92,7 @@ enum {
 	HOST_CTRL_STOP		= (1 << 18), /* latched PCI STOP */
 	HOST_CTRL_DEVSEL	= (1 << 19), /* latched PCI DEVSEL */
 	HOST_CTRL_REQ64		= (1 << 20), /* latched PCI REQ64 */
+	HOST_CTRL_GLOBAL_RST	= (1 << 31), /* global reset */
 
 	/*
 	 * Port registers
@@ -338,6 +339,7 @@ static int sil24_port_start(struct ata_p
 static void sil24_port_stop(struct ata_port *ap);
 static void sil24_host_stop(struct ata_host_set *host_set);
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
+static int sil24_pci_device_resume(struct pci_dev *pdev);
 
 static const struct pci_device_id sil24_pci_tbl[] = {
 	{ 0x1095, 0x3124, PCI_ANY_ID, PCI_ANY_ID, 0, 0, BID_SIL3124 },
@@ -353,6 +355,8 @@ static struct pci_driver sil24_pci_drive
 	.id_table		= sil24_pci_tbl,
 	.probe			= sil24_init_one,
 	.remove			= ata_pci_remove_one, /* safe? */
+	.suspend		= ata_pci_device_suspend,
+	.resume			= sil24_pci_device_resume,
 };
 
 static struct scsi_host_template sil24_sht = {
@@ -372,6 +376,8 @@ static struct scsi_host_template sil24_s
 	.slave_configure	= ata_scsi_slave_config,
 	.slave_destroy		= ata_scsi_slave_destroy,
 	.bios_param		= ata_std_bios_param,
+	.suspend		= ata_scsi_device_suspend,
+	.resume			= ata_scsi_device_resume,
 };
 
 static const struct ata_port_operations sil24_ops = {
@@ -1179,6 +1185,25 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+static int sil24_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	struct sil24_host_priv *hpriv = host_set->private_data;
+
+	ata_pci_device_do_resume(pdev);
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
+		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
+
+	sil24_init_controller(pdev, host_set->n_ports,
+			      host_set->ports[0]->flags,
+			      hpriv->host_base, hpriv->port_base);
+
+	ata_host_set_resume(host_set);
+
+	return 0;
+}
+
 static int __init sil24_init(void)
 {
 	return pci_module_init(&sil24_pci_driver);
-- 
1.3.2


