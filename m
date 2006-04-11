From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/15] libata-ncq: implement NCQ command translation
Date: Tue, 11 Apr 2006 22:53:36 +0900
Message-ID: <11447636163701-git-send-email-htejun@gmail.com>
References: <1144763616819-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.235]:52388 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750995AbWDKNxp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 09:53:45 -0400
Received: by wproxy.gmail.com with SMTP id i11so927606wra
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 06:53:45 -0700 (PDT)
In-Reply-To: <1144763616819-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch implements NCQ command translation.  Note that NCQ commands
don't use ata_rwcmd_protocol() to choose ATA command.  This is
because, unlike non-NCQ RW commands, NCQ commands can only be used for
NCQ protocol and FUA handling is done with a flag rather than separate
command.

Original implementation is from Jens Axboe.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 +
 drivers/scsi/libata-scsi.c |   31 ++++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)

d3819d03d822cf98a8b932fde42fcdc3e553edb1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7dc668c..8e90aa0 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4287,6 +4287,7 @@ static inline int ata_should_dma_map(str
 	struct ata_port *ap = qc->ap;
 
 	switch (qc->tf.protocol) {
+	case ATA_PROT_NCQ:
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
 		return 1;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 00cb9ca..fdc95f1 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1098,7 +1098,36 @@ static unsigned int ata_scsi_rw_xlat(str
 		 */
 		goto nothing_to_do;
 
-	if (dev->flags & ATA_DFLAG_LBA) {
+	if ((dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ) {
+		/* yay, NCQ */
+		if (!lba_48_ok(block, n_block))
+			goto out_of_range;
+
+		tf->protocol = ATA_PROT_NCQ;
+		tf->flags |= ATA_TFLAG_LBA | ATA_TFLAG_LBA48;
+
+		if (tf->flags & ATA_TFLAG_WRITE)
+			tf->command = ATA_CMD_FPDMA_WRITE;
+		else
+			tf->command = ATA_CMD_FPDMA_READ;
+
+		qc->nsect = n_block;
+
+		tf->nsect = qc->tag << 3;
+		tf->hob_feature = (n_block >> 8) & 0xff;
+		tf->feature = n_block & 0xff;
+
+		tf->hob_lbah = (block >> 40) & 0xff;
+		tf->hob_lbam = (block >> 32) & 0xff;
+		tf->hob_lbal = (block >> 24) & 0xff;
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device = 1 << 6;
+		if (tf->flags & ATA_TFLAG_FUA)
+			tf->device |= 1 << 7;
+	} else if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
 		if (lba_28_ok(block, n_block)) {
-- 
1.2.4


