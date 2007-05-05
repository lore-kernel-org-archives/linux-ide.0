From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/11] libata-acpi: remove redundant checks
Date: Sat, 5 May 2007 23:50:39 +0900
Message-ID: <11783766392074-git-send-email-htejun@gmail.com>
References: <11783766373569-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <11783766373569-git-send-email-htejun@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, lenb@kernel.org, linux-acpi@vger.kernel.org, hare@suse.de, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>
List-Id: linux-ide@vger.kernel.org

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


