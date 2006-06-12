From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] sata_sil24: add suspend/sleep support
Date: Tue, 13 Jun 2006 00:50:29 +0900
Message-ID: <11501274292709-git-send-email-htejun@gmail.com>
References: <11501274284082-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:56657 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752087AbWFLPul (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 11:50:41 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1663630nze
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 08:50:41 -0700 (PDT)
In-Reply-To: <11501274284082-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add suspend/sleep support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/sata_sil24.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

79fd0e52c2c53999865a61f160919a0a6308dbc8
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 7726e6e..8c438ba 100644
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
@@ -1179,6 +1183,21 @@ static int sil24_init_one(struct pci_dev
 	return rc;
 }
 
+static int sil24_pci_device_resume(struct pci_dev *pdev)
+{
+	struct ata_host_set *host_set = dev_get_drvdata(&pdev->dev);
+	struct sil24_host_priv *hpriv = host_set->private_data;
+
+	if (pdev->dev.power.power_state.event == PM_EVENT_SUSPEND)
+		writel(HOST_CTRL_GLOBAL_RST, hpriv->host_base + HOST_CTRL);
+
+	sil24_init_controller(pdev, host_set->n_ports,
+			      host_set->ports[0]->flags,
+			      hpriv->host_base, hpriv->port_base);
+
+	return ata_pci_device_resume(pdev);
+}
+
 static int __init sil24_init(void)
 {
 	return pci_module_init(&sil24_pci_driver);
-- 
1.3.2


