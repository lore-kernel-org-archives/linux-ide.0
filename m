From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/15] libata: always generate sense if qc->err_mask is non-zero
Date: Sun, 2 Apr 2006 18:51:53 +0900
Message-ID: <1143971513830-git-send-email-htejun@gmail.com>
References: <11439715124131-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:11846 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932313AbWDBJwG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 05:52:06 -0400
Received: by zproxy.gmail.com with SMTP id o37so1447006nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 01:52:05 -0800 (PST)
In-Reply-To: <11439715124131-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Current sense generation code does not generate sense error if status
register value doesn't indicate error condition.  However, LLDD's may
indicate errors which 't show up in status register.  Completing such
qc's without generating sense results in successful completion of
failed commands.

Invoke ata_to_sense_error() regardless of status register if
qc->err_mask is not zero such that ata_to_sense_error() generates
default sense error.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

60719165920bbb0902851c862f4c181057f48a64
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 234e1ca..ec628ce 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -555,7 +555,8 @@ void ata_gen_ata_desc_sense(struct ata_q
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+	if (qc->err_mask ||
+	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[1], &sb[2], &sb[3]);
 		sb[1] &= 0x0f;
@@ -630,7 +631,8 @@ void ata_gen_fixed_sense(struct ata_queu
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+	if (qc->err_mask ||
+	    tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
 				   &sb[2], &sb[12], &sb[13]);
 		sb[2] &= 0x0f;
-- 
1.2.4


