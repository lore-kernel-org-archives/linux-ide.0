From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 4/6] SATA ACPI: call new ACPI functions
Date: Fri, 2 Dec 2005 10:07:02 -0800
Message-ID: <20051202100702.5bd1e7d8.randy_d_dunlap@linux.intel.com>
References: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:31112 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750891AbVLBSOC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Dec 2005 13:14:02 -0500
In-Reply-To: <20051202100119.032b242e.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ide <linux-ide@vger.kernel.org>
Cc: axboe@suse.de, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Add calls to ACPI methods for SATA drives.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-core.c |    4 ++++
 drivers/scsi/libata.h      |    7 +++++++
 2 files changed, 11 insertions(+)

--- linux-2615-rc4.orig/drivers/scsi/libata-core.c
+++ linux-2615-rc4/drivers/scsi/libata-core.c
@@ -1345,6 +1345,8 @@ void ata_dev_config(struct ata_port *ap,
 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, &ap->device[i]);
+
+	do_drive_SDD(ap, i);
 }
 
 /**
@@ -1784,6 +1786,8 @@ static void ata_set_mode(struct ata_port
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
+	do_drive_update_taskfiles(ap);
+
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
--- linux-2615-rc4.orig/drivers/scsi/libata.h
+++ linux-2615-rc4/drivers/scsi/libata.h
@@ -53,6 +53,13 @@ extern int ata_task_ioctl(struct scsi_de
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
 
+/* ata_acpi.c */
+extern int do_drive_SDD(struct ata_port *ap, unsigned int ix);
+extern int do_drive_get_GTF(struct ata_port *ap, struct ata_device *atadev);
+extern int do_drive_set_taskfiles(struct ata_port *ap, struct ata_device *atadev);
+extern int do_drive_update_taskfiles(struct ata_port *ap);
+
+
 /* libata-scsi.c */
 extern void ata_scsi_scan_host(struct ata_port *ap);
 extern int ata_scsi_error(struct Scsi_Host *host);



---
