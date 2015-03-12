From: Shaohua Li <shli@fb.com>
Subject: Re: [PATCH] libata: revert "libata: use blk taging" et al.
Date: Thu, 12 Mar 2015 10:32:18 -0700
Message-ID: <20150312173218.GA3109737@devbig257.prn2.facebook.com>
References: <5500863D.4070807@cybernetics.com>
 <5500B783.20106@fb.com>
 <5500BF6F.6080000@cybernetics.com>
 <20150312023148.GA1960870@devbig257.prn2.facebook.com>
 <CAPcyv4izOUB93ySh1Qua6qbDC8utgCjY5Zj__NbUXvS9MNY5EQ@mail.gmail.com>
 <20150312121157.GH25944@htj.duckdns.org>
 <20150312124601.GA2750169@devbig257.prn2.facebook.com>
 <20150312135926.GK25944@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42583 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754816AbbCLRdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Mar 2015 13:33:02 -0400
Content-Disposition: inline
In-Reply-To: <20150312135926.GK25944@htj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Tony Battersby <tonyb@cybernetics.com>, Jens Axboe <axboe@fb.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 12, 2015 at 09:59:26AM -0400, Tejun Heo wrote:
> On Thu, Mar 12, 2015 at 05:46:01AM -0700, Shaohua Li wrote:
> > ata: Add a new flag for sas controller
> > 
> > Add a new flag to destinguish sas controller. sas controller has its own tag
> > allocation, which doesn't directly match to ata tag. We use the new flag for
> > sas ata tag allocation.
> 
> This doesn't really explain why the patch came to be.  Can you please
> update it to include what broke how and got fixed?  A Fixes: tag would
> be nice too.

Is this better?


ata: Add a new flag to destinguish sas controller
 
SAS controller has its own tag allocation, which doesn't directly match to ATA
tag, so SAS and SATA have different code path for ata tags. Originally we use
port->scsi_host (98bd4be1) to destinguish SAS controller, but libsas set
->scsi_host too, so we can't use it for the destinguish, we add a new flag for
this purpose.

Reported-and-tested-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Shaohua Li <shli@fb.com>

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4c35f08..ef150eb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4737,7 +4737,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
 		return NULL;
 
 	/* libsas case */
-	if (!ap->scsi_host) {
+	if (ap->flags & ATA_FLAG_SAS_HOST) {
 		tag = ata_sas_allocate_tag(ap);
 		if (tag < 0)
 			return NULL;
@@ -4776,7 +4776,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		if (!ap->scsi_host)
+		if (ap->flags & ATA_FLAG_SAS_HOST)
 			ata_sas_free_tag(tag, ap);
 	}
 }
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 9219953..d9afc51 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6815,7 +6815,8 @@ static struct ata_port_operations ipr_sata_ops = {
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
+			  ATA_FLAG_SAS_HOST,
 	.pio_mask	= ATA_PIO4_ONLY,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA6,
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 932d9cc..9c706d8 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -547,7 +547,8 @@ static struct ata_port_operations sas_sata_ops = {
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
+	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ |
+		 ATA_FLAG_SAS_HOST,
 	.pio_mask = ATA_PIO4,
 	.mwdma_mask = ATA_MWDMA2,
 	.udma_mask = ATA_UDMA6,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fc03efa..6b08cc1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -232,6 +232,7 @@ enum {
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
 	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
+	ATA_FLAG_SAS_HOST	= (1 << 25), /* SAS host */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
