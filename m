From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Subject: [PATCH 9/13] ATA ACPI: check SATA/PATA more carefully
Date: Wed, 22 Feb 2006 14:00:08 -0800
Message-ID: <20060222140008.3832951a.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr17.intel.com ([134.134.136.16]:52885 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751484AbWBVWK6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Feb 2006 17:10:58 -0500
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com

From: Randy Dunlap <randy_d_dunlap@linux.intel.com>

Use 'legacy_mode' to check for SATA vs. PATA mode.

Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 drivers/scsi/libata-acpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2616-rc4-ata.orig/drivers/scsi/libata-acpi.c
+++ linux-2616-rc4-ata/drivers/scsi/libata-acpi.c
@@ -437,7 +437,7 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	/* Don't continue if device has no _ADR method.
 	 * _GTF is intended for known motherboard devices. */
-	if (ata_id_is_ata(atadev->id)) {
+	if (ap->legacy_mode) {
 		err = pata_get_dev_handle(dev, &dev_handle, &pcidevfn);
 		if (err < 0) {
 			if (ata_msg_probe(ap))
@@ -459,7 +459,7 @@ int do_drive_get_GTF(struct ata_port *ap
 
 	/* Get this drive's _ADR info. if not already known. */
 	if (!atadev->obj_handle) {
-		if (ata_id_is_ata(atadev->id)) {
+		if (ap->legacy_mode) {
 			/* get child objects of dev_handle == channel objects,
 	 		 * + _their_ children == drive objects */
 			/* channel is ap->hard_port_no */
@@ -655,7 +655,7 @@ int do_drive_set_taskfiles(struct ata_po
 
 	if (noacpi)
 		return 0;
-	if (!ata_id_is_sata(atadev->id)) {
+	if (ap->legacy_mode) {
 		printk(KERN_DEBUG "%s: skipping non-SATA drive\n",
 			__FUNCTION__);
 		return 0;
