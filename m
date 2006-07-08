From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/12] libata-pmp: hook PMP support and enable it
Date: Sat, 8 Jul 2006 14:58:08 +0900
Message-ID: <11523382883775-git-send-email-htejun@gmail.com>
References: <11523382873130-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:43740 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964808AbWGHF5U (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Jul 2006 01:57:20 -0400
Received: by wx-out-0102.google.com with SMTP id t10so1206438wxc
        for <linux-ide@vger.kernel.org>; Fri, 07 Jul 2006 22:57:20 -0700 (PDT)
In-Reply-To: <11523382873130-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hook PMP support into libata and enable it.  Connect SCR and probing
functions, and update ata_dev_classify() to detect PMP.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   92 ++++++++++++++++++++++++++++++--------------
 drivers/scsi/libata-eh.c   |   15 +++++++
 2 files changed, 78 insertions(+), 29 deletions(-)

7f13e180e59b2eeed428688536c0b476a08f4b16
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c950435..7480b47 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -550,29 +550,46 @@ static unsigned int ata_devchk(struct at
  *	None.
  *
  *	RETURNS:
- *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, or %ATA_DEV_UNKNOWN
- *	the event of failure.
+ *	Device type, %ATA_DEV_ATA, %ATA_DEV_ATAPI, %ATA_DEV_PMP or
+ *	%ATA_DEV_UNKNOWN the event of failure.
  */
-
 unsigned int ata_dev_classify(const struct ata_taskfile *tf)
 {
 	/* Apple's open source Darwin code hints that some devices only
 	 * put a proper signature into the LBA mid/high registers,
 	 * So, we only check those.  It's sufficient for uniqueness.
+	 *
+	 * ATA/ATAPI-7 (d1532v1r1: Feb. 19, 2003) specified separate
+	 * signatures for ATA and ATAPI devices attached on SerialATA,
+	 * 0x3c/0xc3 and 0x69/0x96 respectively.  However, SerialATA
+	 * spec has never mentioned about using different signatures
+	 * for ATA/ATAPI devices.  Then, Serial ATA II: Port
+	 * Multiplier specification began to use 0x69/0x96 to identify
+	 * port multpliers.  ATA/ATAPI-7 dropped descriptions about
+	 * 0x3c/0xc3 and 0x69/0x96 shortly and described them as
+	 * reserved for SerialATA.
+	 *
+	 * We follow the current spec and consider that 0x69/0x96
+	 * identifies a port multiplier.  If there is an ATAPI device
+	 * which returns 0x69/0x96 as its signature, we'll have to
+	 * implement 'try PMP, then try ATAPI' logic.
 	 */
-
 	if (((tf->lbam == 0) && (tf->lbah == 0)) ||
 	    ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))) {
 		DPRINTK("found ATA device by sig\n");
 		return ATA_DEV_ATA;
 	}
 
-	if (((tf->lbam == 0x14) && (tf->lbah == 0xeb)) ||
-	    ((tf->lbam == 0x69) && (tf->lbah == 0x96))) {
+	if ((tf->lbam == 0x14) && (tf->lbah == 0xeb)) {
 		DPRINTK("found ATAPI device by sig\n");
 		return ATA_DEV_ATAPI;
 	}
 
+	if ((tf->lbam == 0x69) && (tf->lbah == 0x96)) {
+		DPRINTK("found PMP device by sig\n");
+		return ATA_DEV_PMP;
+	}
+
 	DPRINTK("unknown device\n");
 	return ATA_DEV_UNKNOWN;
 }
@@ -5043,24 +5060,29 @@ int sata_scr_valid(struct ata_link *link
  *	@val: Place to store read value
  *
  *	Read SCR register @reg of @link into *@val.  This function is
- *	guaranteed to succeed if the cable type of the port is SATA
- *	and the port implements ->scr_read.
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
  *
  *	LOCKING:
- *	None.
+ *	None if @link is ap->link.  Kernel thread context otherwise.
  *
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
 int sata_scr_read(struct ata_link *link, int reg, u32 *val)
 {
-	struct ata_port *ap = link->ap;
+	if (ata_is_host_link(link)) {
+		struct ata_port *ap = link->ap;
 
-	if (sata_scr_valid(link)) {
-		*val = ap->ops->scr_read(ap, reg);
-		return 0;
+		if (sata_scr_valid(link)) {
+			*val = ap->ops->scr_read(ap, reg);
+			return 0;
+		}
+
+		return -EOPNOTSUPP;
 	}
-	return -EOPNOTSUPP;
+
+	return sata_pmp_scr_read(link, reg, val);
 }
 
 /**
@@ -5070,24 +5092,29 @@ int sata_scr_read(struct ata_link *link,
  *	@val: value to write
  *
  *	Write @val to SCR register @reg of @link.  This function is
- *	guaranteed to succeed if the cable type of the port is SATA
- *	and the port implements ->scr_read.
+ *	guaranteed to succeed if @link is ap->link, the cable type of
+ *	the port is SATA and the port implements ->scr_read.
  *
  *	LOCKING:
- *	None.
+ *	None if @link is ap->link.  Kernel thread context otherwise.
  *
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
 int sata_scr_write(struct ata_link *link, int reg, u32 val)
 {
-	struct ata_port *ap = link->ap;
+	if (ata_is_host_link(link)) {
+		struct ata_port *ap = link->ap;
 
-	if (sata_scr_valid(link)) {
-		ap->ops->scr_write(ap, reg, val);
-		return 0;
+		if (sata_scr_valid(link)) {
+			ap->ops->scr_write(ap, reg, val);
+			return 0;
+		}
+
+		return -EOPNOTSUPP;
 	}
-	return -EOPNOTSUPP;
+
+	return sata_pmp_scr_write(link, reg, val);
 }
 
 /**
@@ -5100,21 +5127,26 @@ int sata_scr_write(struct ata_link *link
  *	function performs flush after writing to the register.
  *
  *	LOCKING:
- *	None.
+ *	None if @link is ap->link.  Kernel thread context otherwise.
  *
  *	RETURNS:
  *	0 on success, negative errno on failure.
  */
 int sata_scr_write_flush(struct ata_link *link, int reg, u32 val)
 {
-	struct ata_port *ap = link->ap;
+	if (ata_is_host_link(link)) {
+		struct ata_port *ap = link->ap;
 
-	if (sata_scr_valid(link)) {
-		ap->ops->scr_write(ap, reg, val);
-		ap->ops->scr_read(ap, reg);
-		return 0;
+		if (sata_scr_valid(link)) {
+			ap->ops->scr_write(ap, reg, val);
+			ap->ops->scr_read(ap, reg);
+			return 0;
+		}
+
+		return -EOPNOTSUPP;
 	}
-	return -EOPNOTSUPP;
+
+	return sata_pmp_scr_write(link, reg, val);
 }
 
 /**
@@ -5905,6 +5937,8 @@ int ata_scsi_release(struct Scsi_Host *h
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
 
+	kfree(ap->pmp_link);
+
 	DPRINTK("EXIT\n");
 	return 1;
 }
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 0125c18..c4946cc 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1730,6 +1730,8 @@ static int ata_eh_revalidate_and_attach(
 		unsigned int action = ata_eh_dev_action(dev);
 
 		if (action & ATA_EH_REVALIDATE && ata_dev_ready(dev)) {
+			WARN_ON(dev->class == ATA_DEV_PMP);
+
 			if (ata_link_offline(dev->link)) {
 				rc = -EIO;
 				break;
@@ -1750,6 +1752,13 @@ static int ata_eh_revalidate_and_attach(
 			   ata_class_enabled(ehc->classes[dev->devno])) {
 			dev->class = ehc->classes[dev->devno];
 
+			if (dev->class == ATA_DEV_PMP) {
+				rc = sata_pmp_attach(dev);
+				if (rc)
+					dev->class = ATA_DEV_UNKNOWN;
+				break;
+			}
+
 			rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
 			if (rc == 0)
 				rc = ata_dev_configure(dev, 1);
@@ -2166,6 +2175,12 @@ int ata_eh_recover(struct ata_port *ap, 
 		if (rc)
 			goto dev_fail;
 
+		/* if PMP got attached, return, we don't know what to do */
+		if (link->device->class == ATA_DEV_PMP) {
+			ehc->i.action = 0;
+			return 0;
+		}
+
 		/* configure transfer mode if the port has been reset */
 		if (ehc->i.flags & ATA_EHI_DID_RESET) {
 			rc = ata_set_mode(link, &dev);
-- 
1.3.2


