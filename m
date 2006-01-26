From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/16] libata: convert dev->id to pointer
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899513038-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:806 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964772AbWAZQLW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 11:11:22 -0500
Received: by zproxy.gmail.com with SMTP id 34so381300nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 08:11:21 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Convert dev->id from array to pointer.  This is to accomodate
revalidation.  During revalidation, both old and new IDENTIFY pages
should be accessible and single ->id array doesn't cut it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    7 +++++++
 include/linux/libata.h     |    2 +-
 2 files changed, 8 insertions(+), 1 deletions(-)

993b529e88acd500b15d745edb3f5b7d18badf38
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 4453060..c7e9dc0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1333,6 +1333,10 @@ static void ata_dev_identify(struct ata_
 
 	ata_dev_select(ap, device, 1, 1); /* select device 0/1 */
 
+	dev->id = kmalloc(sizeof(dev->id[0]) * ATA_ID_WORDS, GFP_KERNEL);
+	if (dev->id == NULL)
+		goto err_out;
+
 retry:
 	ata_tf_init(ap, &tf, device);
 
@@ -5053,11 +5057,14 @@ void ata_host_set_remove(struct ata_host
 int ata_scsi_release(struct Scsi_Host *host)
 {
 	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	int i;
 
 	DPRINTK("ENTER\n");
 
 	ap->ops->port_disable(ap);
 	ata_host_remove(ap, 0);
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		kfree(ap->device[i].id);
 
 	DPRINTK("EXIT\n");
 	return 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5bcbab0..1fceafd 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -347,7 +347,7 @@ struct ata_device {
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
-	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
+	u16			*id;		/* IDENTIFY xxx DEVICE data */
 	u8			pio_mode;
 	u8			dma_mode;
 	u8			xfer_mode;
-- 
1.1.3


