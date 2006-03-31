From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 01/15] libata: fix ata_set_mode() return value
Date: Sat, 1 Apr 2006 01:38:17 +0900
Message-ID: <11438230972882-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750720AbWCaQiX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:23 -0500
Received: by zproxy.gmail.com with SMTP id o37so955009nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:23 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_set_mode() return correct error value when ata_dev_set_mode()
fails.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

f88bb95c5b31979a787a4150953820c8e77d7f29
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e63c1ff..8def7a5 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1856,7 +1856,8 @@ static void ata_set_mode(struct ata_port
 		if (!ata_dev_present(dev))
 			continue;
 
-		if (ata_dev_set_mode(ap, dev))
+		rc = ata_dev_set_mode(ap, dev);
+		if (rc)
 			goto err_out;
 	}
 
-- 
1.2.4


