From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/11] libata-eh: implement ata_ering
Date: Thu, 11 May 2006 22:21:27 +0900
Message-ID: <11473536871340-git-send-email-htejun@gmail.com>
References: <11473536873966-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:48375 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751715AbWEKNVe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 09:21:34 -0400
Received: by py-out-1112.google.com with SMTP id f28so234245pyf
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 06:21:33 -0700 (PDT)
In-Reply-To: <11473536873966-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_ering is a ring buffer which records libata errors - whether a
command was for normar IO request, err_mask and timestamp.  This will
be used by EH to determine recovery actions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h    |    2 ++
 include/linux/libata.h   |   16 ++++++++++++++
 3 files changed, 69 insertions(+), 0 deletions(-)

4a10a7d433551195a47e1bf77014fdceea66de8b
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 0803231..f6f0557 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -46,6 +46,57 @@
 
 static void __ata_port_freeze(struct ata_port *ap);
 
+void ata_ering_init(struct ata_ering *ering, int size)
+{
+	memset(ering, 0, sizeof(*ering) + sizeof(ering->ring[0]) * size);
+	ering->size = size;
+}
+
+static void ata_ering_record(struct ata_ering *ering, int is_io,
+			     unsigned int err_mask)
+{
+	struct ata_ering_entry *ent;
+
+	WARN_ON(!err_mask);
+
+	ering->cursor++;
+	ering->cursor %= ering->size;
+
+	ent = &ering->ring[ering->cursor];
+	ent->is_io = is_io;
+	ent->err_mask = err_mask;
+	ent->timestamp = get_jiffies_64();
+}
+
+static struct ata_ering_entry * ata_ering_top(struct ata_ering *ering)
+{
+	struct ata_ering_entry *ent = &ering->ring[ering->cursor];
+	if (!ent->err_mask)
+		return NULL;
+	return ent;
+}
+
+static int ata_ering_map(struct ata_ering *ering,
+			 int (*map_fn)(struct ata_ering_entry *, void *),
+			 void *arg)
+{
+	int idx, rc = 0;
+	struct ata_ering_entry *ent;
+
+	idx = ering->cursor;
+	do {
+		ent = &ering->ring[idx];
+		if (!ent->err_mask)
+			break;
+		rc = map_fn(ent, arg);
+		if (rc)
+			break;
+		idx = (idx - 1 + ering->size) % ering->size;
+	} while (idx != ering->cursor);
+
+	return rc;
+}
+
 /**
  *	ata_scsi_timed_out - SCSI layer time out callback
  *	@cmd: timed out SCSI command
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index e2bbddf..134cb4d 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -62,6 +62,7 @@ extern int ata_check_atapi_dma(struct at
 extern void ata_dev_select(struct ata_port *ap, unsigned int device,
                            unsigned int wait, unsigned int can_sleep);
 extern void swap_buf_le16(u16 *buf, unsigned int buf_words);
+extern void ata_dev_init(struct ata_device *dev);
 extern int ata_task_ioctl(struct scsi_device *scsidev, void __user *arg);
 extern int ata_cmd_ioctl(struct scsi_device *scsidev, void __user *arg);
 
@@ -101,6 +102,7 @@ extern void ata_scsi_rbuf_fill(struct at
 extern void ata_schedule_scsi_eh(struct Scsi_Host *shost);
 
 /* libata-eh.c */
+extern void ata_ering_init(struct ata_ering *ering, int size);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_scsi_error(struct Scsi_Host *host);
 extern void ata_qc_schedule_eh(struct ata_queued_cmd *qc);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 80c8f0e..ad16d6b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -375,6 +375,22 @@ struct ata_host_stats {
 	unsigned long		rw_reqbuf;
 };
 
+struct ata_ering_entry {
+	int			is_io;
+	unsigned int		err_mask;
+	u64			timestamp;
+};
+
+struct ata_ering {
+	int			cursor;
+	int			size;
+	struct ata_ering_entry	ring[];
+};
+
+#define DEFINE_ATA_ERING(name, size)	\
+	struct ata_ering	name;	\
+	struct ata_ering_entry	name_entries[size];
+
 struct ata_device {
 	struct ata_port		*ap;
 	u64			n_sectors;	/* size of device, if ATA */
-- 
1.2.4


