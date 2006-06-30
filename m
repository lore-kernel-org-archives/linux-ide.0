From: Tejun Heo <htejun@gmail.com>
Subject: Re: long boot delay for SATA cdrom on current 2.6.17-git
Date: Fri, 30 Jun 2006 13:49:12 +0900
Message-ID: <20060630044912.GA2592@htj.dyndns.org>
References: <20060630025341.GA4675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.203]:50417 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750722AbWF3Ess (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jun 2006 00:48:48 -0400
Received: by wx-out-0102.google.com with SMTP id t5so200201wxc
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2006 21:48:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20060630025341.GA4675@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Thu, Jun 29, 2006 at 07:53:41PM -0700, Greg KH wrote:
> With Linus's current -git tree (like 2.6.17-git13), it takes a long time
> to boot my laptop.  Turns out the SATA cdrom discovery process is taking
> up many seconds.

Was any previous version okay?  No timeout messages on boot?

> This laptop does not have a SATA hard drive, only a SATA cdrom drive.
> I've included the boot log below and trimmed it after the delay
> happened, as I doubt anything after it would be relevant.
> 
> Is there any patch I can test to help fix this?

This seems to be the ghost device problem which occurs when the first
device is ATAPI but the second slot is empty.

> My .config is also attached, if that helps any.

Please try the following patch.

[PATCH] ata_piix: fix ghost device probing by honoring PCS present bits

Move out PCS handling from piix_sata_prereset() into
piix_sata_present_mask() and use it from newly implemented
piix_sata_softreset().  Class codes for devices which are indicated to
be absent by PCS are cleared to ATA_DEV_NONE.  This fixes ghost device
problem reported on ICH6 and 7.

This patch moves PCS handling from prereset to softreset, which makes
two behavior changes.

* perform softreset even when PCS indicates no device
* PCS handling is repeated before retrying softresets due to reset
  failures.

Both behavior changes are intended and more consistent with how other
drivers behave.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch fixes ghost device problem on my machine and also somehow
allows me to warm plug the second slot successfully (e.g. if PM is
occupied and PS not, I couldn't warm plug PS, but with this patch, it
works).

This patch is against upstream + set-PIO-0-patch + all hotplug
patches, and is also available from for-jeff git tree, tagged with
fj-ata_piix-fix-ghost.

 drivers/scsi/ata_piix.c |   51 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 12 deletions(-)

cafaa04becd7fa90c562d4af10513c0acdc7fe7c
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 521b718..c8fdad5 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -491,21 +491,20 @@ static void piix_pata_error_handler(stru
 }
 
 /**
- *	piix_sata_prereset - prereset for SATA host controller
+ *	piix_sata_present_mask - determine present mask for SATA host controller
  *	@ap: Target port
  *
  *	Reads and configures SATA PCI device's PCI config register
  *	Port Configuration and Status (PCS) to determine port and
- *	device availability.  Return -ENODEV to skip reset if no
- *	device is present.
+ *	device availability.
  *
  *	LOCKING:
- *	None (inherited from caller).
+ *	Kernel thread context (may sleep).
  *
  *	RETURNS:
- *	0 if device is present, -ENODEV otherwise.
+ *	determined present_mask
  */
-static int piix_sata_prereset(struct ata_port *ap)
+static unsigned int piix_sata_present_mask(struct ata_port *ap)
 {
 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
 	const unsigned int *map = ap->host_set->private_data;
@@ -547,18 +546,46 @@ static int piix_sata_prereset(struct ata
 	DPRINTK("ata%u: LEAVE, pcs=0x%x present_mask=0x%x\n",
 		ap->id, pcs, present_mask);
 
-	if (!present_mask) {
-		ata_port_printk(ap, KERN_INFO, "SATA port has no device.\n");
-		ap->eh_context.i.action &= ~ATA_EH_RESET_MASK;
-		return 0;
+	return present_mask;
+}
+
+/**
+ *	piix_sata_softreset - reset SATA host port via ATA SRST
+ *	@ap: port to reset
+ *	@classes: resulting classes of attached devices
+ *
+ *	Reset SATA host port via ATA SRST.  On controllers with
+ *	reliable PCS present bits, the bits are used to determine
+ *	device presence.
+ *
+ *	LOCKING:
+ *	Kernel thread context (may sleep)
+ *
+ *	RETURNS:
+ *	0 on success, -errno otherwise.
+ */
+static int piix_sata_softreset(struct ata_port *ap, unsigned int *classes)
+{
+	unsigned int present_mask;
+	int i, rc;
+
+	present_mask = piix_sata_present_mask(ap);
+
+	rc = ata_std_softreset(ap, classes);
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		if (!(present_mask & (1 << i)))
+			classes[i] = ATA_DEV_NONE;
 	}
 
-	return ata_std_prereset(ap);
+	return 0;
 }
 
 static void piix_sata_error_handler(struct ata_port *ap)
 {
-	ata_bmdma_drive_eh(ap, piix_sata_prereset, ata_std_softreset, NULL,
+	ata_bmdma_drive_eh(ap, ata_std_prereset, piix_sata_softreset, NULL,
 			   ata_std_postreset);
 }
 
-- 
1.3.2

