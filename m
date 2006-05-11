From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 06/22] libata: kill duplicate prototypes
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487901633-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:9925 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751584AbWEKMAB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:01 -0400
Received: by nz-out-0102.google.com with SMTP id 13so170486nzn
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:01 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Kill duplicate prototypes for ata_eh_qc_complete/retry() in libata.h.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/libata.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

24e675bc2d266ce75ca95663b3e92d97beb8bbaf
diff --git a/include/linux/libata.h b/include/linux/libata.h
index d35b1e3..9c2d4bb 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -530,8 +530,6 @@ extern void ata_host_set_remove(struct a
 extern int ata_scsi_detect(struct scsi_host_template *sht);
 extern int ata_scsi_ioctl(struct scsi_device *dev, int cmd, void __user *arg);
 extern int ata_scsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *));
-extern void ata_eh_qc_complete(struct ata_queued_cmd *qc);
-extern void ata_eh_qc_retry(struct ata_queued_cmd *qc);
 extern int ata_scsi_release(struct Scsi_Host *host);
 extern unsigned int ata_host_intr(struct ata_port *ap, struct ata_queued_cmd *qc);
 extern int ata_scsi_device_resume(struct scsi_device *);
-- 
1.2.4


