From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: export ata_hsm_move()
Date: Mon, 29 May 2006 15:34:42 +0900
Message-ID: <11488844823862-git-send-email-htejun@gmail.com>
References: <11488844811684-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:53437 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751278AbWE2Get (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 May 2006 02:34:49 -0400
Received: by wr-out-0506.google.com with SMTP id i7so818693wra
        for <linux-ide@vger.kernel.org>; Sun, 28 May 2006 23:34:49 -0700 (PDT)
In-Reply-To: <11488844811684-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_hsm_move() will be used by LLDDs which depend on standard PIO HSM
but implement their own interrupt handlers.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    6 +++---
 include/linux/libata.h     |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

082a1eadbc745b02f08aece3875bcab0b9a6c27c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index bbdc1ed..261fcd4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4135,9 +4135,8 @@ static void ata_hsm_qc_complete(struct a
  *	RETURNS:
  *	1 when poll next status needed, 0 otherwise.
  */
-
-static int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
-			 u8 status, int in_wq)
+int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+		 u8 status, int in_wq)
 {
 	unsigned long flags = 0;
 	int poll_next;
@@ -5879,6 +5878,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
+EXPORT_SYMBOL_GPL(ata_hsm_move);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8822340..a506b2f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -721,6 +721,8 @@ extern void ata_bmdma_drive_eh(struct at
 			       ata_postreset_fn_t postreset);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
+extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			u8 status, int in_wq);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 				    void (*finish_qc)(struct ata_queued_cmd *));
-- 
1.3.2


