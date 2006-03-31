From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 13/15] libata: add 1s sleep between resets
Date: Sat, 1 Apr 2006 01:38:19 +0900
Message-ID: <1143823099305-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:30179 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbWCaQib (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:31 -0500
Received: by zproxy.gmail.com with SMTP id o37so955016nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:31 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Some devices react badly if resets are performed back-to-back.  Give
devices some time to breath.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

e7f505c001fd4cb43b8123387285a7694790b4ae
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 30ee203..bd9ca3b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2633,6 +2633,7 @@ int ata_drive_probe_reset(struct ata_por
 		rc = ata_do_reset(ap, softreset, postreset, 0, classes);
 		if (rc == 0 && classes[0] != ATA_DEV_UNKNOWN)
 			goto done;
+		ssleep(1);
 	}
 
 	if (!hardreset)
@@ -2649,6 +2650,7 @@ int ata_drive_probe_reset(struct ata_por
 
 		if (ata_down_sata_spd_limit(ap, &ap->device[0]))
 			goto done;
+		ssleep(1);
 	}
 
 	if (softreset)
-- 
1.2.4


