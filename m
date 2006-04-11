From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/13] libata-hp: make ata_bus_probe() extern
Date: Tue, 11 Apr 2006 23:06:22 +0900
Message-ID: <11447643822707-git-send-email-htejun@gmail.com>
References: <11447643813451-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:29188 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbWDKOG1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:06:27 -0400
Received: by zproxy.gmail.com with SMTP id o37so1100680nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:06:27 -0700 (PDT)
In-Reply-To: <11447643813451-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_bus_probe() extern and put its prototype in libata private
header file.  It will be called from libata-eh.c.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 drivers/scsi/libata.h      |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

b0d71bd83fe780a3831d5a2414df632cd3f0aaf9
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index a6c984f..0206791 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1473,7 +1473,7 @@ static void ata_dev_init(struct ata_port
  *	the port has no enabled device after probing, or any negative
  *	errno from ->probe_reset.
  */
-static int ata_bus_probe(struct ata_port *ap)
+int ata_bus_probe(struct ata_port *ap)
 {
 	int existing_dev_failed = 0;
 	unsigned int classes[ATA_MAX_DEVICES];
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
index 7faa9a4..659badb 100644
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -43,6 +43,7 @@ struct ata_scsi_args {
 extern int atapi_enabled;
 extern int atapi_dmadir;
 extern int libata_fua;
+extern int ata_bus_probe(struct ata_port *ap);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_port *ap,
 				      struct ata_device *dev);
 extern int ata_rwcmd_protocol(struct ata_queued_cmd *qc);
-- 
1.2.4


