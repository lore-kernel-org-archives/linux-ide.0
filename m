From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/11] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Sat, 5 May 2007 23:50:38 +0900
Message-ID: <11783766381026-git-send-email-htejun@gmail.com>
References: <11783766373569-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:25647 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933996AbXEEQpE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 May 2007 12:45:04 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1153754nzf
        for <linux-ide@vger.kernel.org>; Sat, 05 May 2007 09:45:03 -0700 (PDT)
In-Reply-To: <11783766373569-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Whether a controller needs IDE or SATA ACPI hierarchy is determined by
the programming interface of the controller not by whether the
controller is SATA or PATA, or it supports slave device or not.  This
patch adds ATA_FLAG_ACPI_SATA port flags which tells libata-acpi that
the port needs SATA ACPI nodes, and sets the flag for ahci and
sata_sil24.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    3 ++-
 drivers/ata/libata-acpi.c |   10 +++++-----
 drivers/ata/sata_sil24.c  |    3 ++-
 include/linux/libata.h    |    1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 34c5534..7f739e8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -173,7 +173,8 @@ enum {
 
 	AHCI_FLAG_COMMON		= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 					  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-					  ATA_FLAG_SKIP_D2H_BSY,
+					  ATA_FLAG_SKIP_D2H_BSY |
+					  ATA_FLAG_ACPI_SATA,
 };
 
 struct ahci_cmd_hdr {
diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ed4138e..0223673 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -321,7 +321,7 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 
 	/* Don't continue if device has no _ADR method.
 	 * _GTF is intended for known motherboard devices. */
-	if (!(ap->cbl == ATA_CBL_SATA)) {
+	if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
 		err = pata_get_dev_handle(gdev, &dev_handle, &pcidevfn);
 		if (err < 0) {
 			if (ata_msg_probe(ap))
@@ -343,7 +343,7 @@ static int do_drive_get_GTF(struct ata_device *dev, unsigned int *gtf_length,
 
 	/* Get this drive's _ADR info. if not already known. */
 	if (!dev->obj_handle) {
-		if (!(ap->cbl == ATA_CBL_SATA)) {
+		if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
 			/* get child objects of dev_handle == channel objects,
 	 		 * + _their_ children == drive objects */
 			/* channel is ap->port_no */
@@ -528,7 +528,7 @@ static int do_drive_set_taskfiles(struct ata_device *dev,
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (libata_noacpi || !(ap->cbl == ATA_CBL_SATA))
+	if (libata_noacpi || !(ap->flags & ATA_FLAG_ACPI_SATA))
 		return 0;
 
 	if (!ata_dev_enabled(dev) || (ap->flags & ATA_FLAG_DISABLED))
@@ -578,7 +578,7 @@ int ata_acpi_exec_tfs(struct ata_port *ap)
 	 * we should not run GTF on PATA devices since some
 	 * PATA require execution of GTM/STM before GTF.
 	 */
-	if (!(ap->cbl == ATA_CBL_SATA))
+	if (!(ap->flags & ATA_FLAG_ACPI_SATA))
 		return 0;
 
 	for (ix = 0; ix < ATA_MAX_DEVICES; ix++) {
@@ -641,7 +641,7 @@ int ata_acpi_push_id(struct ata_device *dev)
 			       __FUNCTION__, dev->devno, ap->port_no);
 
 	/* Don't continue if not a SATA device. */
-	if (!(ap->cbl == ATA_CBL_SATA)) {
+	if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
 		if (ata_msg_probe(ap))
 			ata_dev_printk(dev, KERN_DEBUG,
 				"%s: Not a SATA device\n", __FUNCTION__);
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index e6223ba..a499369 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -237,7 +237,8 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_NO_LEGACY |
 				  ATA_FLAG_MMIO | ATA_FLAG_PIO_DMA |
-				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY,
+				  ATA_FLAG_NCQ | ATA_FLAG_SKIP_D2H_BSY |
+				  ATA_FLAG_ACPI_SATA,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8a577c2..a26bb7f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -174,6 +174,7 @@ enum {
 	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
 	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
+	ATA_FLAG_ACPI_SATA	= (1 << 17), /* need native SATA ACPI layout */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
-- 
1.5.0.3


