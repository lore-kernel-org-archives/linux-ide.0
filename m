From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata: fix handling of race between timeout and completion
Date: Sun, 22 Jan 2006 16:58:31 +0900
Message-ID: <11379167113869-git-send-email-htejun@gmail.com>
References: <11379167103055-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.195]:41654 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751252AbWAVH6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 02:58:39 -0500
Received: by xproxy.gmail.com with SMTP id s14so513087wxc
        for <linux-ide@vger.kernel.org>; Sat, 21 Jan 2006 23:58:39 -0800 (PST)
In-Reply-To: <11379167103055-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com
Cc: Tejun Heo <htejun@gmail.com>

If a qc completes after SCSI timer expires but before libata EH kicks
in, the qc gets completed but the scsicmd still gets passed to libata
EH resulting in ->eng_timeout invocation with NULL qc.  Currently none
of ->eng_timeout callbacks handles this properly.  This patch makes
ata_scsi_error() bypass ->eng_timeout and handle this rare case.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-scsi.c |   42 +++++++++++++++++++++++++++++++++++++++---
 1 files changed, 39 insertions(+), 3 deletions(-)

ba51311c2cc3177f9c5d33aee11be1488d783c7c
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index ab6b533..accb63a 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -731,12 +731,48 @@ int ata_scsi_slave_config(struct scsi_de
 
 int ata_scsi_error(struct Scsi_Host *host)
 {
-	struct ata_port *ap;
+	struct ata_port *ap = (struct ata_port *) &host->hostdata[0];
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
 
 	DPRINTK("ENTER\n");
 
-	ap = (struct ata_port *) &host->hostdata[0];
-	ap->ops->eng_timeout(ap);
+	spin_lock_irqsave(&ap->host_set->lock, flags);
+	qc = ata_qc_from_tag(ap, ap->active_tag);
+	spin_unlock_irqrestore(&ap->host_set->lock, flags);
+
+	if (qc) {
+		ap->ops->eng_timeout(ap);
+	} else {
+		struct scsi_cmnd *scmd;
+		unsigned char *sb;
+
+		/* The scmd had timed out but the corresponding qc
+		 * completed successfully inbetween timer expiration
+		 * and here.  Retry if possible.
+		 *
+		 * It is better to enter eng_timeout and perform EH
+		 * before retrying the command, but this case should
+		 * be _very_ rare and eng_timeout isn't ready for
+		 * NULL-qc case.
+		 */
+		scmd = list_entry(host->eh_cmd_q.next,
+				  struct scsi_cmnd, eh_entry);
+		sb = scmd->sense_buffer;
+
+		/* Timeout, fake parity for now */
+		scmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+		sb[0] = 0x70;
+		sb[7] = 0x0a;
+		sb[2] = ABORTED_COMMAND;
+		sb[12] = 0x47;
+		sb[13] = 0x00;
+
+		printk(KERN_WARNING "ata%u: interrupt and timer raced for "
+		       "scsicmd %p\n", ap->id, scmd);
+
+		scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
+	}
 
 	assert(host->host_failed == 0 && list_empty(&host->eh_cmd_q));
 
-- 
1.0.8


