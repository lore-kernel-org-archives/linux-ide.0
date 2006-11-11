From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch] libata: change order of _SDD/_GTF execution (resend #3)
Date: Fri, 10 Nov 2006 16:14:47 -0800
Message-ID: <20061110161447.b4599cbd.kristen.c.accardi@intel.com>
References: <20060928182211.076258000@localhost.localdomain>
	<20060928112912.d2ae0d8f.kristen.c.accardi@intel.com>
	<20060929021353.GB22082@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42773 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1946858AbWKKAO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Nov 2006 19:14:59 -0500
In-Reply-To: <20060929021353.GB22082@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, akpm@osdl.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@xenotime.net, mjg59@srcf.ucam.org

Make the sdd call come before gtf.  _SDD is used to provide
input to the _GTF file, so it should be executed first.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

---
 drivers/ata/libata-core.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

--- 2.6-mm.orig/drivers/ata/libata-core.c
+++ 2.6-mm/drivers/ata/libata-core.c
@@ -1411,6 +1411,16 @@ int ata_dev_configure(struct ata_device 
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER, host %u, dev %u\n",
 			       __FUNCTION__, ap->id, dev->devno);
 
+	/* set _SDD */
+	rc = ata_acpi_push_id(ap, dev->devno);
+	if (rc) {
+		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
+			rc);
+	}
+
+	/* retrieve and execute the ATA task file of _GTF */
+	ata_acpi_exec_tfs(ap);
+
 	/* print device capabilities */
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG,
@@ -1568,14 +1578,6 @@ int ata_dev_configure(struct ata_device 
 	if (ap->ops->dev_config)
 		ap->ops->dev_config(ap, dev);
 
-	/* set _SDD */
-	rc = ata_acpi_push_id(ap, dev->devno);
-	if (rc) {
-		ata_dev_printk(dev, KERN_WARNING, "failed to set _SDD(%d)\n",
-			rc);
-		goto err_out_nosup;
-	}
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: EXIT, drv_stat = 0x%x\n",
 			__FUNCTION__, ata_chk_status(ap));
@@ -1621,9 +1623,6 @@ int ata_bus_probe(struct ata_port *ap)
 	/* reset and determine device classes */
 	ap->ops->phy_reset(ap);
 
-	/* retrieve and execute the ATA task file of _GTF */
-	ata_acpi_exec_tfs(ap);
-
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		dev = &ap->device[i];
 
