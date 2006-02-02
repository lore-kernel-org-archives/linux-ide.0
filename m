From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/11] libata: fix ata_std_probe_reset() SATA detection
Date: Thu, 2 Feb 2006 18:20:00 +0900
Message-ID: <11388720002687-git-send-email-htejun@gmail.com>
References: <11388720003793-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:30455 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423400AbWBBJUF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Feb 2006 04:20:05 -0500
Received: by xproxy.gmail.com with SMTP id s14so246549wxc
        for <linux-ide@vger.kernel.org>; Thu, 02 Feb 2006 01:20:04 -0800 (PST)
In-Reply-To: <11388720003793-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ap->cbl is initialized during postreset and thus unknown on entry to
ata_std_probe_reset().  This patch makes ata_std_probe_reset() use
ATA_FLAG_SATA flag instead of ap->cbl to detect SATA port.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

f820ad6fcf9839d76cfbaa6553c3875b0d7c0657
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 32ac63c..1d106b4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2472,7 +2472,7 @@ int ata_std_probe_reset(struct ata_port 
 	ata_reset_fn_t hardreset;
 
 	hardreset = NULL;
-	if (ap->cbl == ATA_CBL_SATA && ap->ops->scr_read)
+	if (ap->flags & ATA_FLAG_SATA && ap->ops->scr_read)
 		hardreset = sata_std_hardreset;
 
 	return ata_drive_probe_reset(ap, ata_std_softreset, hardreset,
-- 
1.1.3


