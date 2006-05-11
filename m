From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 19/22] libata: add dev->ap
Date: Thu, 11 May 2006 20:59:51 +0900
Message-ID: <11473487914070-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.197]:3016 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751612AbWEKMAG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:06 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170503nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:05 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add dev->ap which points back to the port the device belongs to.  This
makes it unnecessary to pass @ap for silly reasons (e.g. printks).
Also, this change is necessary to accomodate later PM support which
will introduce ATA link inbetween port and device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 include/linux/libata.h     |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

d9d4fd3f482c7c5054b60ddde1d5b408b14ff288
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 128f84d..38a9833 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4748,6 +4748,7 @@ static void ata_host_init(struct ata_por
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
+		dev->ap = ap;
 		dev->devno = i;
 		dev->pio_mask = UINT_MAX;
 		dev->mwdma_mask = UINT_MAX;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b719b16..8d7fbb3 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -358,6 +358,7 @@ struct ata_host_stats {
 };
 
 struct ata_device {
+	struct ata_port		*ap;
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
 	unsigned int		class;		/* ATA_DEV_xxx */
-- 
1.2.4


