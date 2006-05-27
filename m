From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] Re: 2.6.17-rc5-git1: regression: resume from suspend(RAM) fails: libata issue
Date: Sat, 27 May 2006 14:23:39 -0400
Message-ID: <200605271423.40037.liml@rtr.ca>
References: <1148634262.2310.7.camel@forrest26.sh.intel.com> <Pine.LNX.4.64.0605262028460.5623@g5.osdl.org> <4477CEF5.9000908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:24740 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964924AbWE0SXj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 May 2006 14:23:39 -0400
In-Reply-To: <4477CEF5.9000908@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>, "zhao, forrest" <forrest.zhao@intel.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

On Saturday 27 May 2006 00:00, Jeff Garzik wrote:
> Although I didn't even bother to compile-test it, here is the 
> recommended solution, as described multiple times...

..

That patch has ZERO (positive) effect on my machine.
It still crashes miserably with a zillion "read errors" on resume
(drive not accessible).

The original "bad layering" patch still works perfectly in it's place.
Repeated below for Linus's benefit.

Signed-off-by: Mark Lord <lkml@rtr.ca>
---
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
+	struct ata_port *ap = (struct ata_port *) &sdev->host->hostdata[0];
+	struct ata_device *dev = &ap->device[sdev->id];
+	u8 status;
+
+	status = ata_busy_wait(ap, ATA_BUSY, 200000);
+	if (status & ATA_BUSY) {
+		printk(KERN_ERR "libata port failed to resume "
+				"in 2 secs)\n");
+		return 1;
+	}
+	return ata_device_resume(ap, dev);
+}
+
 #define AHCI_PCI_BAR 5
 #define AHCI_GLOBAL_CTL 0x04
 #define AHCI_ENABLE (1 << 31)
