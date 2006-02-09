From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patches] libata fixes
Date: Thu, 9 Feb 2006 13:47:36 -0500
Message-ID: <20060209184736.GA8409@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57524 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750701AbWBISri (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 9 Feb 2006 13:47:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


The following changes add module parameters to two SATA drivers.  The
first, sata_mv, fixes the driver so that it works for a larger set of
users (MSI is too immature to use by default).  The second gives the
user an option to work around various bios/system[/driver?] problems
that are occasionally reported.

[the sata_mv change is a resend, it didn't get pulled the first time]

Both are definitely -rc material.

Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the following updates:

 drivers/scsi/sata_mv.c  |   11 ++++++++++-
 drivers/scsi/sata_sil.c |   10 ++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

Jeff Garzik:
      [libata sata_sil] implement 'slow_down' module parameter
      [libata sata_mv] do not enable PCI MSI by default

diff --git a/drivers/scsi/sata_mv.c b/drivers/scsi/sata_mv.c
index cd54244..6fddf17 100644
--- a/drivers/scsi/sata_mv.c
+++ b/drivers/scsi/sata_mv.c
@@ -510,6 +510,12 @@ static const struct mv_hw_ops mv6xxx_ops
 };
 
 /*
+ * module options
+ */
+static int msi;	      /* Use PCI msi; either zero (off, default) or non-zero */
+
+
+/*
  * Functions
  */
 
@@ -2191,7 +2197,7 @@ static int mv_init_one(struct pci_dev *p
 	}
 
 	/* Enable interrupts */
-	if (pci_enable_msi(pdev) == 0) {
+	if (msi && pci_enable_msi(pdev) == 0) {
 		hpriv->hp_flags |= MV_HP_FLAG_MSI;
 	} else {
 		pci_intx(pdev, 1);
@@ -2246,5 +2252,8 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, mv_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+module_param(msi, int, 0444);
+MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
+
 module_init(mv_init);
 module_exit(mv_exit);
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index b017f85..17f74d3 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -231,6 +231,10 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int slow_down = 0;
+module_param(slow_down, int, 0444);
+MODULE_PARM_DESC(slow_down, "Sledgehammer used to work around random problems, by limiting commands to 15 sectors (0=off, 1=on)");
+
 
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
@@ -354,8 +358,10 @@ static void sil_dev_config(struct ata_po
 		}
 
 	/* limit requests to 15 sectors */
-	if ((ap->flags & SIL_FLAG_MOD15WRITE) && (quirks & SIL_QUIRK_MOD15WRITE)) {
-		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix\n",
+	if (slow_down ||
+	    ((ap->flags & SIL_FLAG_MOD15WRITE) &&
+	     (quirks & SIL_QUIRK_MOD15WRITE))) {
+		printk(KERN_INFO "ata%u(%u): applying Seagate errata fix (mod15write workaround)\n",
 		       ap->id, dev->devno);
 		ap->host->max_sectors = 15;
 		ap->host->hostt->max_sectors = 15;
