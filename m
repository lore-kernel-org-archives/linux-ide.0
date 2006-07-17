From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/12] libata: add msec_to_jiffies()
Date: Mon, 17 Jul 2006 15:52:31 +0900
Message-ID: <11531191513074-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:4738 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751342AbWGQGvN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:13 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398407nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:13 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add msec_to_jiffies() to drivers/scsi/libata.h and use it in
ata_wait_register().

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 drivers/scsi/libata.h      |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

017cbbd4749d4f40fca7764281dd8283c562ae4c
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index d8c3bed..61db4f5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5904,7 +5904,7 @@ u32 ata_wait_register(void __iomem *reg,
 	 * preceding writes reach the controller before starting to
 	 * eat away the timeout.
 	 */
-	timeout = jiffies + (timeout_msec * HZ) / 1000;
+	timeout = jiffies + msec_to_jiffies(timeout_msec);
 
 	while ((tmp & mask) == val && time_before(jiffies, timeout)) {
 		msleep(interval_msec);
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index c325679..e2fa600 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -38,6 +38,11 @@ struct ata_scsi_args {
 	void			(*done)(struct scsi_cmnd *);
 };
 
+static inline unsigned long msec_to_jiffies(unsigned long ms)
+{
+	return (ms * HZ + 999) / 1000;
+}
+
 /* libata-core.c */
 extern struct workqueue_struct *ata_aux_wq;
 extern int atapi_enabled;
-- 
1.3.2


