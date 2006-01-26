From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/16] libata: implement ata_dev_id_c_string()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <11382899512709-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:21074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932370AbWAZPjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:25 -0500
Received: by zproxy.gmail.com with SMTP id 34so372383nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:25 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

ata_dev_id_c_string() reads ATA string from the specified offset of
the given IDENTIFY PAGE and puts it in the specified buffer in trimmed
and NULL-terminated form.  The caller must supply a buffer which is
one byte larger than the maximum size of the target ID string.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   30 ++++++++++++++++++++++++++++++
 include/linux/libata.h     |    2 ++
 2 files changed, 32 insertions(+), 0 deletions(-)

170e46fb5e18c2bc6c6606f9bf6650bfb2b4f578
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index b1ec4e5..2dfc3e9 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -916,6 +916,35 @@ void ata_dev_id_string(const u16 *id, un
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
+	assert(len & 1);
+	s[len - 1] = ' ';
+
+	ata_dev_id_string(id, s, ofs, len - 1);
+
+	p = s + strnlen(s, len) - 1;
+	while (p >= s && *p == ' ')
+		p--;
+	*++p = '\0';
+}
 
 /**
  *	ata_noop_dev_select - Select device 0/1 on ATA bus
@@ -5531,6 +5560,7 @@ EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
 EXPORT_SYMBOL_GPL(ata_dev_id_string);
+EXPORT_SYMBOL_GPL(ata_dev_id_c_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a30aba8..5bcbab0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -545,6 +545,8 @@ extern void ata_sg_init(struct ata_queue
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
 extern void ata_dev_id_string(const u16 *id, unsigned char *s,
 			      unsigned int ofs, unsigned int len);
+extern void ata_dev_id_c_string(const u16 *id, unsigned char *s,
+				unsigned int ofs, unsigned int len);
 extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
-- 
1.1.3


