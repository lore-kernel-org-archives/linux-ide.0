From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 03/11] libata: add probeinit component operation to ata_drive_probe_reset()
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720002859-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:21802 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423405AbWBBJUH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:07 -0500
Received: by zproxy.gmail.com with SMTP id f1so15679nzc
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:07 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

This patch adds probeinit component operation to
ata_drive_probe_reset().  If present, this new operation is called
before performing any reset.  The operations's roll is to prepare @ap
for following probe-reset operations.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    9 +++++++--
 include/linux/libata.h     |    2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

e854fb48e07ab9ae790280843fdd6d7f2bee9be3
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e302545..8bd197d 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2485,7 +2485,8 @@ int ata_std_probe_reset(struct ata_port 
 	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
 		hardreset = sata_std_hardreset;
 
-	return ata_drive_probe_reset(ap, ata_std_softreset, hardreset,
+	return ata_drive_probe_reset(ap, NULL,
+				     ata_std_softreset, hardreset,
 				     ata_std_postreset, classes);
 }
 
@@ -2524,6 +2525,7 @@ static int do_probe_reset(struct ata_por
 /**
  *	ata_drive_probe_reset - Perform probe reset with given methods
  *	@ap: port to reset
+ *	@probeinit: probeinit method (can be NULL)
  *	@softreset: softreset method (can be NULL)
  *	@hardreset: hardreset method (can be NULL)
  *	@postreset: postreset method (can be NULL)
@@ -2552,12 +2554,15 @@ static int do_probe_reset(struct ata_por
  *	if classification fails, and any error code from reset
  *	methods.
  */
-int ata_drive_probe_reset(struct ata_port *ap,
+int ata_drive_probe_reset(struct ata_port *ap, ata_probeinit_fn_t probeinit,
 			  ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			  ata_postreset_fn_t postreset, unsigned int *classes)
 {
 	int rc = -EINVAL;
 
+	if (probeinit)
+		probeinit(ap);
+
 	if (softreset) {
 		rc = do_probe_reset(ap, softreset, postreset, classes);
 		if (rc == 0)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4cd1eb..e8f29ce 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -244,6 +244,7 @@ struct ata_queued_cmd;
 
 /* typedefs */
 typedef void (*ata_qc_cb_t) (struct ata_queued_cmd *qc);
+typedef void (*ata_probeinit_fn_t)(struct ata_port *);
 typedef int (*ata_reset_fn_t)(struct ata_port *, int, unsigned int *);
 typedef void (*ata_postreset_fn_t)(struct ata_port *ap, unsigned int *);
 
@@ -484,6 +485,7 @@ extern void __sata_phy_reset(struct ata_
 extern void sata_phy_reset(struct ata_port *ap);
 extern void ata_bus_reset(struct ata_port *ap);
 extern int ata_drive_probe_reset(struct ata_port *ap,
+			ata_probeinit_fn_t probeinit,
 			ata_reset_fn_t softreset, ata_reset_fn_t hardreset,
 			ata_postreset_fn_t postreset, unsigned int *classes);
 extern int ata_std_softreset(struct ata_port *ap, int verbose,
-- 
1.1.3


