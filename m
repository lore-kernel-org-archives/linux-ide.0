From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/12] libata: add ata_port_nr_ready()
Date: Mon, 17 Jul 2006 15:52:32 +0900
Message-ID: <11531191523566-git-send-email-htejun@gmail.com>
References: <11531191512028-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.200]:23944 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932315AbWGQGvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Jul 2006 02:51:18 -0400
Received: by nz-out-0102.google.com with SMTP id x7so398399nzc
        for <linux-ide@vger.kernel.org>; Sun, 16 Jul 2006 23:51:17 -0700 (PDT)
In-Reply-To: <11531191512028-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add ready counting function - ata_port_nr_ready().  This is in
preparation for powersave support.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   10 ++++++++++
 drivers/scsi/libata.h      |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

efc7e0e82005a0135d9b658af156d6388c49367d
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8e75899..3e35839 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -120,6 +120,16 @@ int ata_port_nr_enabled(struct ata_port 
 	return cnt;
 }
 
+int ata_port_nr_ready(struct ata_port *ap)
+{
+	int i, cnt = 0;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		if (ata_dev_ready(&ap->device[i]))
+			cnt++;
+	return cnt;
+}
+
 /**
  *	ata_tf_to_fis - Convert ATA taskfile to SATA FIS structure
  *	@tf: Taskfile to convert
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index d77b5ff..ce44e06 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -50,6 +50,7 @@ extern int atapi_dmadir;
 extern int libata_fua;
 extern int ata_port_nr_vacant(struct ata_port *ap);
 extern int ata_port_nr_enabled(struct ata_port *ap);
+extern int ata_port_nr_ready(struct ata_port *ap);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
 extern void ata_dev_disable(struct ata_device *dev);
-- 
1.3.2


