From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 7/7] SATA ACPI debug-only output
Date: Tue, 13 Dec 2005 16:10:28 -0800
Message-ID: <20051213161028.7b459b23.randy_d_dunlap@linux.intel.com>
References: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:41145 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030369AbVLNAH6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Dec 2005 19:07:58 -0500
In-Reply-To: <20051213160110.193e3f61.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add some extra debug-only output.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/ata_acpi.c    |   17 ++++++++++++-----
 drivers/scsi/libata-core.c |    6 +++---
 2 files changed, 15 insertions(+), 8 deletions(-)

--- linux-2615-rc5g3.orig/drivers/scsi/ata_acpi.c
+++ linux-2615-rc5g3/drivers/scsi/ata_acpi.c
@@ -183,9 +183,10 @@ static int get_sata_adr(struct device *d
 	winfo->drivenum = drive;
 
 	status = acpi_get_devices(NULL, get_devices, winfo, NULL);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(status)) {
+		DEBPRINT("acpi_get_devices failed\n");
 		err = -ENODEV;
-	else {
+	} else {
 		*dev_adr = winfo->sata_adr;
 		atadev->obj_handle = winfo->obj_handle;
 		err = 0;
@@ -219,19 +220,25 @@ int do_drive_SDD(struct ata_port *ap, un
 		__FUNCTION__, ap->id, ix, ap->port_no, ap->hard_port_no);
 
 	/* Don't continue if not a SATA device. */
-	if (!ata_id_is_sata(atadev->id))
+	if (!ata_id_is_sata(atadev->id)) {
+		DEBPRINT("ata_id_is_sata is False\n");
 		goto out;
+	}
 
 	/* Don't continue if device has no _ADR method.
 	 * _SDD is intended for known motherboard devices. */
 	err = pci_acpi_get_dev_handle(dev, &handle, &pcidevfn);
-	if (err < 0)
+	if (err < 0) {
+		DEBPRINT("get_dev_handle failed\n");
 		goto out;
+	}
 	/* Get this drive's _ADR info. */
 	dev_adr = SATA_ADR_RSVD;
 	err = get_sata_adr(dev, handle, pcidevfn, ix, ap, atadev, &dev_adr);
-	if (err < 0 || dev_adr == SATA_ADR_RSVD || !atadev->obj_handle)
+	if (err < 0 || dev_adr == SATA_ADR_RSVD || !atadev->obj_handle) {
+		DEBPRINT("get_sata_adr failed\n");
 		goto out;
+	}
 
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
--- linux-2615-rc5g3.orig/drivers/scsi/libata-core.c
+++ linux-2615-rc5g3/drivers/scsi/libata-core.c
@@ -1185,11 +1185,11 @@ retry:
 
 	/* print device capabilities */
 	printk(KERN_DEBUG "ata%u: dev %u cfg "
-	       "49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x\n",
-	       ap->id, device, dev->id[49],
+	       "00:%04x 49:%04x 82:%04x 83:%04x 84:%04x 85:%04x 86:%04x 87:%04x 88:%04x 93:%04x\n",
+	       ap->id, device, dev->id[0], dev->id[49],
 	       dev->id[82], dev->id[83], dev->id[84],
 	       dev->id[85], dev->id[86], dev->id[87],
-	       dev->id[88]);
+	       dev->id[88], dev->id[93]);
 
 	/*
 	 * common ATA, ATAPI feature tests


---
