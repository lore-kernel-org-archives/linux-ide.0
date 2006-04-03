From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/13] libata: implement ata_ering
Date: Mon, 3 Apr 2006 12:44:38 +0900
Message-ID: <11440358783417-git-send-email-htejun@gmail.com>
References: <11440358783861-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:43706 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932199AbWDCDoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 23:44:44 -0400
Received: by zproxy.gmail.com with SMTP id o37so1665771nzf
        for <linux-ide@vger.kernel.org>; Sun, 02 Apr 2006 20:44:43 -0700 (PDT)
In-Reply-To: <11440358783861-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_ering is a ring buffer which records libata errors - whether a
command was for normar IO request, err_mask and timestamp.  This will
be used by EH to determine recovery actions.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata.h    |    1 +
 include/linux/libata.h   |   16 ++++++++++++++
 3 files changed, 68 insertions(+), 0 deletions(-)

b92a795c5b84f3840388da95e2d4675d976c9e66
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index dfbb8c4..b5825b7 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -44,6 +44,57 @@
 
 #include "libata.h"
 
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
index 826010c..97eeacb 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -105,6 +105,7 @@ extern void ata_scsi_rbuf_fill(struct at
                                            u8 *rbuf, unsigned int buflen));
 
 /* libata-eh.c */
+extern void ata_ering_init(struct ata_ering *ering, int size);
 extern enum scsi_eh_timer_return ata_scsi_timed_out(struct scsi_cmnd *cmd);
 extern void ata_eh_schedule_qc(struct ata_queued_cmd *qc);
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 19d3ecc..e4480f2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -371,6 +371,22 @@ struct ata_host_stats {
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
 	u64			n_sectors;	/* size of device, if ATA */
 	unsigned long		flags;		/* ATA_DFLAG_xxx */
-- 
1.2.4


