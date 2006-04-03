From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/14] libata: implement NCQ command translation
Date: Mon, 3 Apr 2006 17:32:39 +0900
Message-ID: <11440531592079-git-send-email-htejun@gmail.com>
References: <1144053158183-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:36988 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751630AbWDCIcu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 04:32:50 -0400
Received: by xproxy.gmail.com with SMTP id t10so764240wxc
        for <linux-ide@vger.kernel.org>; Mon, 03 Apr 2006 01:32:49 -0700 (PDT)
In-Reply-To: <1144053158183-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, axboe@suse.de, linux-ide@vger.kernel.org
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

b3b26b1edc907b391ca73d68a0b5d03d409d6799
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b4eeb4b..cc45cfc 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4272,6 +4272,7 @@ static inline int ata_should_dma_map(str
 	struct ata_port *ap = qc->ap;
 
 	switch (qc->tf.protocol) {
+	case ATA_PROT_NCQ:
 	case ATA_PROT_DMA:
 	case ATA_PROT_ATAPI_DMA:
 		return 1;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index f3a73c4..d5748b1 100644
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


