From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 12/13] libata-acpi: remove redundant checks
Date: Mon, 23 Apr 2007 02:41:07 +0900
Message-ID: <11772636673733-git-send-email-htejun@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:25103 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbXDVRlT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:41:19 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1332033wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:41:19 -0700 (PDT)
In-Reply-To: <11772636651400-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Remove remaining unnecessary feature and status checks.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 63b77b9..0ba0e79 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -134,22 +134,10 @@ static int do_drive_get_GTF(struct ata_device *adev, struct ata_acpi_gtf **gtf,
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
-	if (!adev->acpi_handle)
-		goto out_free;
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(adev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (!ata_dev_enabled(adev) || (ap->flags & ATA_FLAG_DISABLED)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(adev, KERN_DEBUG, "%s: ERR: "
-				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
-				__FUNCTION__, ata_dev_enabled(adev),
-				ap->flags & ATA_FLAG_DISABLED);
-		goto out_free;
-	}
-
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(adev->acpi_handle, "_GTF", NULL, &output);
 	if (ACPI_FAILURE(status)) {
@@ -339,21 +327,10 @@ static int ata_acpi_push_id(struct ata_device *adev)
 	struct acpi_object_list input;
 	union acpi_object in_params[1];
 
-	if (!adev->acpi_handle)
-		return 0;
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(adev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
 			       __FUNCTION__, adev->devno, ap->port_no);
 
-	/* Don't continue if not a SATA device. */
-	if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(adev, KERN_DEBUG,
-				"%s: Not a SATA device\n", __FUNCTION__);
-		return 0;
-	}
-
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
 	input.count = 1;
-- 
1.5.0.3


