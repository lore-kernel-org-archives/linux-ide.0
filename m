From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 13/13] ATA ACPI: enable writing PATA taskfiles
Date: Wed, 22 Feb 2006 14:07:14 -0800
Message-ID: <20060222140714.46c572e7.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751511AbWBVWLd@vger.kernel.org>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
List-Id: linux-ide@vger.kernel.org

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Move 'noacpi' option handling to top of functions.
Enable writing taskfiles for PATA drives.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
@@ -303,13 +303,14 @@ int ata_acpi_push_id(struct ata_port *ap
 	struct acpi_object_list		input;
 	union acpi_object 		in_params[1];
 
+	if (noacpi)
+		return 0;
+
 	if (ap->legacy_mode) {
 		printk(KERN_DEBUG "%s: skipping for PATA mode\n",
 			__FUNCTION__);
 		return 0;
 	}
-	if (noacpi)
-		return 0;
 
 	if (ata_msg_probe(ap))
 		printk(KERN_DEBUG
@@ -655,11 +656,6 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (noacpi)
 		return 0;
-	if (ap->legacy_mode) {
-		printk(KERN_DEBUG "%s: skipping non-SATA drive\n",
-			__FUNCTION__);
-		return 0;
-	}
 
 	if (!ata_dev_present(atadev) ||
 	    (ap->flags & ATA_FLAG_PORT_DISABLED))
@@ -707,12 +703,12 @@ int ata_acpi_exec_tfs(struct ata_port *a
 	unsigned long	gtf_address;
 	unsigned long	obj_loc;
 
-	if (ata_msg_probe(ap))
-		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
-
 	if (noacpi)
 		return 0;
 
+	if (ata_msg_probe(ap))
+		printk(KERN_DEBUG "%s: ENTER:\n", __FUNCTION__);
+
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
 		if (ata_msg_probe(ap))
 			printk(KERN_DEBUG "%s: call get_GTF, ix=%d\n",
