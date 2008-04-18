From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH] libata: fix boot panic with SATAPI devices on non-SFF HBAs
Date: Fri, 18 Apr 2008 13:18:48 -0500
Message-ID: <1208542728.3063.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Current 2.6.25 git head now panics reliably on boot if you have a SATAPI
device connected.

The problem was introduced by the libata merge trying to pull out all
the SFF code into a separate module.  Unfortunately, if you're a satapi
device you usually need to call atapi_request_sense, which has a bare
invocation of a SFF callback which is NULL on non-SFF HBAs.  Fix this by
making the call conditional.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 784ac41..f3c69a8 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2390,7 +2390,8 @@ static void atapi_request_sense(struct ata_queued_cmd *qc)
 	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 
 #ifdef CONFIG_ATA_SFF
-	ap->ops->sff_tf_read(ap, &qc->tf);
+	if (ap->ops->sff_tf_read)
+		ap->ops->sff_tf_read(ap, &qc->tf);
 #endif
 
 	/* fill these in, for the case where they are -not- overwritten */


