From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: [PATCH] Add ata_piix's own resume function
Date: Fri, 26 May 2006 17:04:21 +0800
Message-ID: <1148634262.2310.7.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62587 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751351AbWEZJQN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 May 2006 05:16:13 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Jens Axboe <axboe@suse.de>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

For ata_piix resume operation, it first waits for BUSY bit clear,
then calls ata_device_resume().


The patch is against #upstream 957d2df1801865eb1e63864bc63b970aa9c460ba

Thanks,
Forrest

Signed-off-by: Forrest Zhao <forrest.zhao@intel.com>
---

 drivers/scsi/ata_piix.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

55116b42caac4c48b2b85228e5b961d71266de22
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 1db007f..405f039 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -90,6 +90,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
@@ -151,6 +152,7 @@ static int piix_pata_probe_reset(struct 
 static int piix_sata_probe_reset(struct ata_port *ap, unsigned int *classes);
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev);
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev);
+static int piix_scsi_device_resume(struct scsi_device *sdev);
 
 static unsigned int in_module_init = 1;
 
@@ -220,7 +222,7 @@ static struct scsi_host_template piix_sh
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.resume			= ata_scsi_device_resume,
+	.resume			= piix_scsi_device_resume,
 	.suspend		= ata_scsi_device_suspend,
 };
 
@@ -710,6 +712,21 @@ static void piix_set_dmamode (struct ata
 	}
 }
 
+int piix_scsi_device_resume(struct scsi_device *sdev)
+{
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+	struct ata_device *dev = &ap->device[sdev->id];
+	u8 status;
+
+	status = ata_busy_wait(ap, ATA_BUSY, 200000);
+	if (status & ATA_BUSY) {
+		ata_port_printk(ap, KERN_ERR, "port failed to resume "
+				"in 2 secs)\n");
+		return 1;
+	}
+	return ata_device_resume(dev);
+}
+
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
-- 
1.2.6
