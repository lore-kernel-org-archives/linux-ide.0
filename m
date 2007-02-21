From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fix remaining ap->id
Date: Wed, 21 Feb 2007 16:36:33 +0900
Message-ID: <20070221073633.GW1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:42716 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161034AbXBUHgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Feb 2007 02:36:36 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2161911nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Feb 2007 23:36:35 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Merge order left libata-acpi and pata_scc with remainling usage of
ap->id.  Kill superflous id printing and substitute the remaining ones
with ap->print_id.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b4e8be5..1bdf7a2 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -294,9 +294,8 @@ static int do_drive_get_GTF(struct ata_port *ap, int ix,
 		return 0;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG,
-			"%s: ENTER: ap->id: %d, port#: %d\n",
-			__FUNCTION__, ap->id, ap->port_no);
+		ata_dev_printk(atadev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
+			       __FUNCTION__, ap->port_no);
 
 	if (!ata_dev_enabled(atadev) || (ap->flags & ATA_FLAG_DISABLED)) {
 		if (ata_msg_probe(ap))
@@ -521,9 +520,8 @@ static int do_drive_set_taskfiles(struct ata_port *ap,
 	struct taskfile_array	*gtf;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG,
-			"%s: ENTER: ap->id: %d, port#: %d\n",
-			__FUNCTION__, ap->id, ap->port_no);
+		ata_dev_printk(atadev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
+			       __FUNCTION__, ap->port_no);
 
 	if (noacpi || !(ap->cbl == ATA_CBL_SATA))
 		return 0;
@@ -627,9 +625,8 @@ int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 		return 0;
 
 	if (ata_msg_probe(ap))
-		ata_dev_printk(atadev, KERN_DEBUG,
-			"%s: ap->id: %d, ix = %d, port#: %d\n",
-			__FUNCTION__, ap->id, ix, ap->port_no);
+		ata_dev_printk(atadev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
+			       __FUNCTION__, ix, ap->port_no);
 
 	/* Don't continue if not a SATA device. */
 	if (!(ap->cbl == ATA_CBL_SATA)) {
@@ -685,9 +682,8 @@ int ata_acpi_push_id(struct ata_port *ap, unsigned int ix)
 	if (err < 0) {
 		if (ata_msg_probe(ap))
 			ata_dev_printk(atadev, KERN_DEBUG,
-				"ata%u(%u): %s _SDD error: status = 0x%x\n",
-				ap->id, ap->device->devno,
-				__FUNCTION__, status);
+				       "%s _SDD error: status = 0x%x\n",
+				       __FUNCTION__, status);
 	}
 
 	/* always return success */
diff --git a/drivers/ata/pata_scc.c b/drivers/ata/pata_scc.c
index 049a3a2..de04042 100644
--- a/drivers/ata/pata_scc.c
+++ b/drivers/ata/pata_scc.c
@@ -366,7 +366,7 @@ static void scc_tf_read (struct ata_port *ap, struct ata_taskfile *tf)
 static void scc_exec_command (struct ata_port *ap,
 			      const struct ata_taskfile *tf)
 {
-	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
 
 	out_be32(ap->ioaddr.command_addr, tf->command);
 	ata_pause(ap);
@@ -542,7 +542,7 @@ static unsigned int scc_bus_softreset (struct ata_port *ap,
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
+	DPRINTK("ata%u: bus reset via SRST\n", ap->print_id);
 
 	/* software reset.  causes dev0 to be selected */
 	out_be32(ioaddr->ctl_addr, ap->ctl);
