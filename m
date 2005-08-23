From: Jeff Garzik <jgarzik@pobox.com>
Subject: [git patch] 2.6.x libata release prep (bump version, etc.)
Date: Tue, 23 Aug 2005 03:31:29 -0400
Message-ID: <430AD0D1.6060404@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080909010305080207000709"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:5770 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750729AbVHWHbl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Aug 2005 03:31:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080909010305080207000709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to receive the changes described in the attached diffstat/changelog/patch.


--------------080909010305080207000709
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

 drivers/scsi/ahci.c         |    1 +
 drivers/scsi/ata_piix.c     |    2 +-
 drivers/scsi/libata-core.c  |   25 -------------------------
 drivers/scsi/libata.h       |    2 +-
 drivers/scsi/sata_promise.c |    2 +-
 5 files changed, 4 insertions(+), 28 deletions(-)



commit 6885433c25aaca2cb13ee52a94be156163d6aa23
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Tue Aug 23 02:53:51 2005 -0400

    libata: release prep (bump versions, etc.)
    
    - bump versions where necessary
    - remove two duplicated+outdated doc comments
    - add MODULE_VERSION() to AHCI driver



diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1105,6 +1105,7 @@ MODULE_AUTHOR("Jeff Garzik");
 MODULE_DESCRIPTION("AHCI SATA low-level driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, ahci_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
 
 module_init(ahci_init);
 module_exit(ahci_exit);
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -32,7 +32,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"ata_piix"
-#define DRV_VERSION	"1.03"
+#define DRV_VERSION	"1.04"
 
 enum {
 	PIIX_IOCFG		= 0x54, /* IDE I/O configuration register */
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2268,19 +2268,6 @@ void ata_qc_prep(struct ata_queued_cmd *
  *	spin_lock_irqsave(host_set lock)
  */
 
-
-
-/**
- *	ata_sg_init_one - Prepare a one-entry scatter-gather list.
- *	@qc:  Queued command
- *	@buf:  transfer buffer
- *	@buflen:  length of buf
- *
- *	Builds a single-entry scatter-gather list to initiate a
- *	transfer utilizing the specified buffer.
- *
- *	LOCKING:
- */
 void ata_sg_init_one(struct ata_queued_cmd *qc, void *buf, unsigned int buflen)
 {
 	struct scatterlist *sg;
@@ -2312,18 +2299,6 @@ void ata_sg_init_one(struct ata_queued_c
  *	spin_lock_irqsave(host_set lock)
  */
 
-
-/**
- *	ata_sg_init - Assign a scatter gather list to a queued command
- *	@qc:  Queued command
- *	@sg:  Scatter-gather list
- *	@n_elem:  length of sg list
- *
- *	Attaches a scatter-gather list to a queued command.
- *
- *	LOCKING:
- */
-
 void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem)
 {
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -26,7 +26,7 @@
 #define __LIBATA_H__
 
 #define DRV_NAME	"libata"
-#define DRV_VERSION	"1.11"	/* must be exactly four chars */
+#define DRV_VERSION	"1.12"	/* must be exactly four chars */
 
 struct ata_scsi_args {
 	u16			*id;
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -40,7 +40,7 @@
 #include "sata_promise.h"
 
 #define DRV_NAME	"sata_promise"
-#define DRV_VERSION	"1.01"
+#define DRV_VERSION	"1.02"
 
 
 enum {

--------------080909010305080207000709--
