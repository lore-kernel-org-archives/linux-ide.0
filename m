From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 09/15] libata-hp: activate hotplug by adding a call to ata_eh_hotplug() from EH
Date: Tue, 11 Apr 2006 23:14:07 +0900
Message-ID: <11447648473100-git-send-email-htejun@gmail.com>
References: <1144764846705-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:19875 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751288AbWDKOOO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Apr 2006 10:14:14 -0400
Received: by zproxy.gmail.com with SMTP id o37so1102564nzf
        for <linux-ide@vger.kernel.org>; Tue, 11 Apr 2006 07:14:13 -0700 (PDT)
In-Reply-To: <1144764846705-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Now all the required pieces for hotplug support are in place.  Update
all ->error_handler's to call ata_eh_hotplug() after regular EH is
finished.  This enables hotplug support for all drivers which use new
EH.  With this patch, all new EH drivers can do warm unplug and plug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c         |    1 +
 drivers/scsi/libata-bmdma.c |    1 +
 drivers/scsi/sata_sil24.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

5a9a286e07ca0d216be1b8f81ab6c6e7048ae963
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index a8b699a..7f478c4 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -864,6 +864,7 @@ static void ahci_error_handler(struct at
 	ata_eh_revive(ap, action,
 		      ahci_softreset, ahci_hardreset, ahci_postreset);
 	ata_eh_finish_qcs(ap, qc, &tf);
+	ata_eh_hotplug(ap);
 }
 
 static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
diff --git a/drivers/scsi/libata-bmdma.c b/drivers/scsi/libata-bmdma.c
index 3c3bc71..a87efae 100644
--- a/drivers/scsi/libata-bmdma.c
+++ b/drivers/scsi/libata-bmdma.c
@@ -729,6 +729,7 @@ void ata_bmdma_drive_eh(struct ata_port 
 	ata_eh_report(ap, qc, &tf, serror, action, NULL);
 	ata_eh_revive(ap, action, softreset, hardreset, postreset);
 	ata_eh_finish_qcs(ap, qc, &tf);
+	ata_eh_hotplug(ap);
 }
 
 /**
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 9acf7a4..1ca76f7 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -852,6 +852,7 @@ static void sil24_error_handler(struct a
 	ata_eh_revive(ap, action,
 		      sil24_softreset, sil24_hardreset, sil24_postreset);
 	ata_eh_finish_qcs(ap, qc, &tf);
+	ata_eh_hotplug(ap);
 }
 
 static void sil24_post_internal_cmd(struct ata_queued_cmd *qc)
-- 
1.2.4


