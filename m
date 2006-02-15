From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: increase LBA48 max sectors to 65535
Date: Wed, 15 Feb 2006 16:24:49 +0900
Message-ID: <20060215072449.GA31691@htj.dyndns.org>
References: <1139754779159-git-send-email-htejun@gmail.com> <43EF8E61.5040409@pobox.com> <43EFD73D.4070207@gmail.com> <43F011DF.6020203@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:28424 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751016AbWBOHYw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Feb 2006 02:24:52 -0500
Received: by zproxy.gmail.com with SMTP id v1so1598401nzb
        for <linux-ide@vger.kernel.org>; Tue, 14 Feb 2006 23:24:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43F011DF.6020203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

max_hw_sectors/max_sectors separation patch made into the tree,
increase max_sectors to its hardware limit.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

Jeff, first of all, thanks for the pointer.  I have two more
questions.

* I make ATA_MAX_SECTORS_LBA48 65535 (the 0000h case is supposed to be
  broken, right?); however, the comment says 65534.  Should it be
  65534?

* ATA_MAX_SECTORS is 200 w/ FIXME.  Would bumping it up to 255 be
  okay?  Is this because some lldd's don't handle sectors above 200
  very well?

Thanks.

diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 86da465..bceadb3 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -689,14 +689,9 @@ int ata_scsi_slave_config(struct scsi_de
 		ap = (struct ata_port *) &sdev->host->hostdata[0];
 		dev = &ap->device[sdev->id];
 
-		/* TODO: 2048 is an arbitrary number, not the
-		 * hardware maximum.  This should be increased to
-		 * 65534 when Jens Axboe's patch for dynamically
-		 * determining max_sectors is merged.
-		 */
 		max_sectors = ATA_MAX_SECTORS;
 		if (dev->flags & ATA_DFLAG_LBA48)
-			max_sectors = 2048;
+			max_sectors = ATA_MAX_SECTORS_LBA48;
 		if (dev->max_sectors)
 			max_sectors = dev->max_sectors;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index afe4645..6253650 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -110,6 +110,7 @@ enum {
 	ATA_DEF_QUEUE		= 1,
 	ATA_MAX_QUEUE		= 1,
 	ATA_MAX_SECTORS		= 200,	/* FIXME */
+	ATA_MAX_SECTORS_LBA48	= 65535,
 	ATA_MAX_BUS		= 2,
 	ATA_DEF_BUSY_WAIT	= 10000,
 	ATA_SHORT_PAUSE		= (HZ >> 6) + 1,
