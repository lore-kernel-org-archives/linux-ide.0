From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/6] libata: export ata_hsm_move()
Date: Sat, 20 May 2006 00:38:10 +0900
Message-ID: <1148053090174-git-send-email-htejun@gmail.com>
References: <11480530901755-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.204]:14230 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932354AbWESPiS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 May 2006 11:38:18 -0400
Received: by wx-out-0102.google.com with SMTP id s6so531883wxc
        for <linux-ide@vger.kernel.org>; Fri, 19 May 2006 08:38:18 -0700 (PDT)
In-Reply-To: <11480530901755-git-send-email-htejun@gmail.com>
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

cb28a26fe7a13513c15d26f8099231ab9c419d2d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b2197b0..1809f98 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -4137,9 +4137,8 @@ static void ata_hsm_qc_complete(struct a
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
@@ -5861,6 +5860,7 @@ EXPORT_SYMBOL_GPL(ata_device_add);
 EXPORT_SYMBOL_GPL(ata_host_set_remove);
 EXPORT_SYMBOL_GPL(ata_sg_init);
 EXPORT_SYMBOL_GPL(ata_sg_init_one);
+EXPORT_SYMBOL_GPL(ata_hsm_move);
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 EXPORT_SYMBOL_GPL(ata_qc_complete_multiple);
 EXPORT_SYMBOL_GPL(ata_qc_issue_prot);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f078c4c..5a382bf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -712,6 +712,8 @@ extern void ata_bmdma_drive_eh(struct at
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


