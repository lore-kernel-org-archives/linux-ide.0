From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata: export ata_hsm_move()
Date: Fri, 12 May 2006 00:11:58 +0900
Message-ID: <1147360318689-git-send-email-htejun@gmail.com>
References: <1147360318920-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:39210 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751840AbWEKPME (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 11:12:04 -0400
Received: by nz-out-0102.google.com with SMTP id 13so224766nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 08:12:04 -0700 (PDT)
In-Reply-To: <1147360318920-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_hsm_move() will be used by LLDDs which depend on standard PIO HSM
but implement their own interrupt handlers.

---

 drivers/scsi/libata-core.c |    6 +++---
 include/linux/libata.h     |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

80a810231596efc4c208307250cfea7c2b55cb15
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 7259646..9acfdc7 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4099,9 +4099,8 @@ static void ata_hsm_qc_complete(struct a
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
@@ -5821,6 +5820,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
+EXPORT_SYMBOL_GPL(ata_hsm_move);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9e06d82..815087f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -704,6 +704,8 @@ extern void ata_bmdma_drive_eh(struct at
 			       ata_postreset_fn_t postreset);
 extern void ata_bmdma_error_handler(struct ata_port *ap);
 extern void ata_bmdma_post_internal_cmd(struct ata_queued_cmd *qc);
+extern int ata_hsm_move(struct ata_port *ap, struct ata_queued_cmd *qc,
+			u8 status, int in_wq);
 extern void ata_qc_complete(struct ata_queued_cmd *qc);
 extern int ata_qc_complete_multiple(struct ata_port *ap, u32 qc_active,
 				    void (*finish_qc)(struct ata_queued_cmd *));
-- 
1.2.4


