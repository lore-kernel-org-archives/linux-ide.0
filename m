From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 05/22] libata: unexport ata_scsi_error()
Date: Thu, 11 May 2006 20:59:50 +0900
Message-ID: <11473487902238-git-send-email-htejun@gmail.com>
References: <11473487893774-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.193]:58054 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751574AbWEKMAA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 08:00:00 -0400
Received: by wx-out-0102.google.com with SMTP id t16so118649wxc
        for <linux-ide@vger.kernel.org>; Thu, 11 May 2006 05:00:00 -0700 (PDT)
In-Reply-To: <11473487893774-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

While moving ata_scsi_error() from LLDD sht to libata transportt,
EXPORT_SYMBOL_GPL() entry was left out.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

b6212a123649958b5502a95e235807e2176bb247
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 509178c..8ac560c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5161,7 +5161,6 @@ EXPORT_SYMBOL_GPL(ata_device_resume);
 EXPORT_SYMBOL_GPL(ata_scsi_device_suspend);
 EXPORT_SYMBOL_GPL(ata_scsi_device_resume);
 
-EXPORT_SYMBOL_GPL(ata_scsi_error);
 EXPORT_SYMBOL_GPL(ata_eng_timeout);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
 EXPORT_SYMBOL_GPL(ata_eh_qc_retry);
-- 
1.2.4


