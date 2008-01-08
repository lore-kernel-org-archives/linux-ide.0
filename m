From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: implement libata.force_cbl parameter
Date: Tue, 08 Jan 2008 22:19:38 +0900
Message-ID: <4783786A.6040608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:9917 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbYAHNTv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 08:19:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so13194028wah.23
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 05:19:50 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Implement libata.force_cbl parameter to work around incorrect PATA
cable detection.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Sledgehammer for just-in-case.  Feel free to include or ignore.

 drivers/ata/libata-core.c |    4 ++++
 drivers/ata/libata-eh.c   |   20 +++++++++++++++++++-
 drivers/ata/libata.h      |    1 +
 3 files changed, 24 insertions(+), 1 deletion(-)

Index: linux-2.6.22-SL103_BRANCH/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.22-SL103_BRANCH.orig/drivers/ata/libata-core.c
+++ linux-2.6.22-SL103_BRANCH/drivers/ata/libata-core.c
@@ -110,6 +110,10 @@ int libata_noacpi = 1;
 module_param_named(noacpi, libata_noacpi, int, 0444);
 MODULE_PARM_DESC(noacpi, "Disables the use of ACPI in suspend/resume when set");
 
+int libata_force_cbl = 0;
+module_param_named(force_cbl, libata_force_cbl, int, 0644);
+MODULE_PARM_DESC(force_cbl, "force PATA cable type (0=keep, 40=40c, 80=80c)");
+
 MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("Library module for ATA devices");
 MODULE_LICENSE("GPL");
Index: linux-2.6.22-SL103_BRANCH/drivers/ata/libata-eh.c
===================================================================
--- linux-2.6.22-SL103_BRANCH.orig/drivers/ata/libata-eh.c
+++ linux-2.6.22-SL103_BRANCH/drivers/ata/libata-eh.c
@@ -2165,9 +2165,27 @@ static int ata_eh_revalidate_and_attach(
 
 	/* PDIAG- should have been released, ask cable type if post-reset */
 	if (ata_is_host_link(link) && ap->ops->cable_detect &&
-	    (ehc->i.flags & ATA_EHI_DID_RESET))
+	    (ehc->i.flags & ATA_EHI_DID_RESET)) {
 		ap->cbl = ap->ops->cable_detect(ap);
 
+		if (!(ap->flags & ATA_FLAG_SATA) && libata_force_cbl) {
+			switch (libata_force_cbl) {
+			case 40:
+				ata_port_printk(ap, KERN_INFO, "forcing 40c\n");
+				ap->cbl = ATA_CBL_PATA40;
+				break;
+			case 80:
+				ata_port_printk(ap, KERN_INFO, "forcing 80c\n");
+				ap->cbl = ATA_CBL_PATA80;
+				break;
+			default:
+				ata_port_printk(ap, KERN_WARNING,
+						"invalid force_cbl value %d\n",
+						libata_force_cbl);
+			}
+		}
+	}
+
 	/* Configure new devices forward such that user doesn't see
 	 * device detection messages backwards.
 	 */
Index: linux-2.6.22-SL103_BRANCH/drivers/ata/libata.h
===================================================================
--- linux-2.6.22-SL103_BRANCH.orig/drivers/ata/libata.h
+++ linux-2.6.22-SL103_BRANCH/drivers/ata/libata.h
@@ -59,6 +59,7 @@ extern int atapi_dmadir;
 extern int atapi_passthru16;
 extern int libata_fua;
 extern int libata_noacpi;
+extern int libata_force_cbl;
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
