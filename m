From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 8/9] libata-acpi: remove redundant checks
Date: Tue, 15 May 2007 03:28:16 +0900
Message-ID: <11791672963219-git-send-email-htejun@gmail.com>
References: <11791672953697-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.225]:26093 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757278AbXENS2a (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 May 2007 14:28:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1670180wxd
        for <linux-ide@vger.kernel.org>; Mon, 14 May 2007 11:28:30 -0700 (PDT)
In-Reply-To: <11791672953697-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Remove remaining unnecessary feature and status checks.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   23 -----------------------
 1 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index e09df44..78db2e6 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -134,22 +134,10 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 	output.length = ACPI_ALLOCATE_BUFFER;
 	output.pointer = NULL;	/* ACPI-CA sets this; save/free it later */
 
-	if (!dev->acpi_handle)
-		goto out_free;
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ENTER: port#: %d\n",
 			       __FUNCTION__, ap->port_no);
 
-	if (!ata_dev_enabled(dev) || (ap->flags & ATA_FLAG_DISABLED)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG, "%s: ERR: "
-				"ata_dev_present: %d, PORT_DISABLED: %lu\n",
-				__FUNCTION__, ata_dev_enabled(dev),
-				ap->flags & ATA_FLAG_DISABLED);
-		goto out_free;
-	}
-
 	/* _GTF has no input parameters */
 	status = acpi_evaluate_object(dev->acpi_handle, "_GTF", NULL, &output);
 
@@ -340,21 +328,10 @@ static int ata_acpi_push_id(struct ata_device *dev)
 	struct acpi_object_list input;
 	union acpi_object in_params[1];
 
-	if (!dev->acpi_handle)
-		return 0;
-
 	if (ata_msg_probe(ap))
 		ata_dev_printk(dev, KERN_DEBUG, "%s: ix = %d, port#: %d\n",
 			       __FUNCTION__, dev->devno, ap->port_no);
 
-	/* Don't continue if not a SATA device. */
-	if (!(ap->flags & ATA_FLAG_ACPI_SATA)) {
-		if (ata_msg_probe(ap))
-			ata_dev_printk(dev, KERN_DEBUG,
-				"%s: Not a SATA device\n", __FUNCTION__);
-		return 0;
-	}
-
 	/* Give the drive Identify data to the drive via the _SDD method */
 	/* _SDD: set up input parameters */
 	input.count = 1;
-- 
1.5.0.3


