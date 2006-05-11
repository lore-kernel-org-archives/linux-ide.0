From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 04/11] libata-eh: implement ata_eh_info and ata_eh_context
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <11473536871367-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:48375 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751728AbWEKNVk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:40 -0400
Received: by py-out-1112.google.com with SMTP id f28so234245pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:40 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

struct ata_eh_info serves as the communication channel between
execution path and EH.  Execution path describes detected error
condition in ap->eh_info and EH recovers the port using it.  To avoid
missing error conditions detected during EH, EH makes its own copy of
eh_info and clears it on entry allowing error info to accumulate
during EH.

Most EH states including EH's copy of eh_info are stored in
ap->eh_context (struct ata_eh_context) which is owned by EH and thus
doesn't require any synchronization to access and alter.  This
standardized context makes it easy to integrate various parts of EH
and extend EH to handle multiple links (for PM).

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   11 ++++++++++-
 include/linux/libata.h   |   40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)

819953b0ab81f1b93f355863b23e85d9a74cd334
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index f6f0557..5a76e22 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -235,9 +235,15 @@ void ata_scsi_error(struct Scsi_Host *ho
  repeat:
 	/* invoke error handler */
 	if (ap->ops->error_handler) {
-		/* clear EH pending */
+		/* fetch & clear EH info */
 		spin_lock_irqsave(hs_lock, flags);
+
+		memset(&ap->eh_context, 0, sizeof(ap->eh_context));
+		ap->eh_context.i = ap->eh_info;
+		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+
 		ap->flags &= ~ATA_FLAG_EH_PENDING;
+
 		spin_unlock_irqrestore(hs_lock, flags);
 
 		/* invoke EH */
@@ -261,6 +267,9 @@ void ata_scsi_error(struct Scsi_Host *ho
 					"tries, giving up\n", ATA_EH_MAX_REPEAT);
 		}
 
+		/* this run is complete, make sure EH info is clear */
+		memset(&ap->eh_info, 0, sizeof(ap->eh_info));
+
 		/* Clear host_eh_scheduled while holding hs_lock such
 		 * that if exception occurs after this point but
 		 * before EH completion, SCSI midlayer will
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 1a4df14..c5c5f18 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -228,6 +228,9 @@ enum {
 	ATA_PORT_PRIMARY	= (1 << 0),
 	ATA_PORT_SECONDARY	= (1 << 1),
 
+	/* desc_len for ata_eh_info and context */
+	ATA_EH_DESC_LEN		= 80,
+
 	/* reset / recovery action types */
 	ATA_EH_REVALIDATE	= (1 << 0),
 	ATA_EH_SOFTRESET	= (1 << 1),
@@ -235,6 +238,9 @@ enum {
 
 	ATA_EH_RESET_MASK	= ATA_EH_SOFTRESET | ATA_EH_HARDRESET,
 
+	/* ata_eh_context->flags */
+	ATA_EHC_DID_RESET	= (1 << 0), /* already reset this port */
+
 	/* max repeat if error condition is still set after ->error_handler */
 	ATA_EH_MAX_REPEAT	= 5,
 
@@ -423,6 +429,21 @@ struct ata_device {
 	DEFINE_ATA_ERING	(ering, ATA_DEV_ERING_SIZE);
 };
 
+struct ata_eh_info {
+	struct ata_device	*dev;		/* offending device */
+	u32			serror;		/* SError from LLDD */
+	unsigned int		err_mask;	/* port-wide err_mask */
+	unsigned int		action;		/* ATA_EH_* action mask */
+	char			desc[ATA_EH_DESC_LEN];
+	int			desc_len;
+};
+
+struct ata_eh_context {
+	struct ata_eh_info	i;
+	int			tries[ATA_MAX_DEVICES];
+	unsigned int		flags;		/* ATA_EHC_* */
+};
+
 struct ata_port {
 	struct Scsi_Host	*host;	/* our co-allocated scsi host */
 	const struct ata_port_operations *ops;
@@ -447,6 +468,11 @@ struct ata_port {
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 	unsigned int		sata_spd_limit;	/* SATA PHY speed limit */
 
+	/* record runtime error info, protected by host_set lock */
+	struct ata_eh_info	eh_info;
+	/* EH context owned by EH */
+	struct ata_eh_context	eh_context;
+
 	struct ata_device	device[ATA_MAX_DEVICES];
 
 	struct ata_queued_cmd	qcmd[ATA_MAX_QUEUE];
@@ -714,6 +740,20 @@ extern void ata_eh_qc_retry(struct ata_q
 	printk(lv"ata%u.%02u: "fmt, (dev)->ap->id, (dev)->devno , ##args)
 
 /*
+ * ata_eh_info helpers
+ */
+#define ata_ehi_push_desc(ehi, fmt, args...) do { \
+	(ehi)->desc_len += scnprintf((ehi)->desc + (ehi)->desc_len, \
+				     ATA_EH_DESC_LEN - (ehi)->desc_len, \
+				     fmt , ##args); \
+} while (0)
+
+#define ata_ehi_clear_desc(ehi) do { \
+	(ehi)->desc[0] = '\0'; \
+	(ehi)->desc_len = 0; \
+} while (0)
+
+/*
  * qc helpers
  */
 static inline int
-- 
1.2.4


