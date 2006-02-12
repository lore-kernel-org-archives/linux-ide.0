From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: implement ata_dev_id_c_string()
Date: Sun, 12 Feb 2006 22:47:04 +0900
Message-ID: <11397520242535-git-send-email-htejun@gmail.com>
References: <11397520242602-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:51164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbWBLNrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 08:47:11 -0500
Received: by zproxy.gmail.com with SMTP id 40so776895nzk
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 05:47:10 -0800 (PST)
In-Reply-To: <11397520242602-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_id_c_string() reads ATA string from the specified offset of
the given IDENTIFY PAGE and puts it in the specified buffer in trimmed
and NULL-terminated form.  The caller must supply a buffer which is
one byte larger than the maximum size of the target ID string.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   29 +++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 ++
 2 files changed, 31 insertions(+), 0 deletions(-)

fecf9b72f3395e5c73d303cdd098d39418554a82
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index cef85e5..ea993eb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -519,6 +519,34 @@ void ata_dev_id_string(const u16 *id, un
 	}
 }
 
+/**
+ *	ata_dev_id_c_string - Convert IDENTIFY DEVICE page into C string
+ *	@id: IDENTIFY DEVICE results we will examine
+ *	@s: string into which data is output
+ *	@ofs: offset into identify device page
+ *	@len: length of string to return. must be an odd number.
+ *
+ *	This function is identical to ata_dev_id_string except that it
+ *	trims trailing spaces and terminates the resulting string with
+ *	null.  @len must be actual maximum length (even number) + 1.
+ *
+ *	LOCKING:
+ *	caller.
+ */
+void ata_dev_id_c_string(const u16 *id, unsigned char *s,
+			 unsigned int ofs, unsigned int len)
+{
+	unsigned char *p;
+
+	WARN_ON(!(len & 1));
+
+	ata_dev_id_string(id, s, ofs, len - 1);
+
+	p = s + strnlen(s, len - 1);
+	while (p > s && p[-1] == ' ')
+		p--;
+	*p = '\0';
+}
 
 /**
  *	ata_noop_dev_select - Select device 0/1 on ATA bus
@@ -4902,6 +4930,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_id_c_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 83a1f2e..0853032 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -540,6 +540,8 @@ extern void ata_sg_init(struct ata_queue
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
 extern void ata_dev_id_string(const u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_id_c_string(const u16 *id, unsigned char *s,
+				unsigned int ofs, unsigned int len);
 extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
-- 
1.1.5


