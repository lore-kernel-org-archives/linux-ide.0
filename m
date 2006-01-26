From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: don't do EDD handling if ->probe_reset is used
Date: Fri, 27 Jan 2006 00:24:03 +0900
Message-ID: <11382890432020-git-send-email-htejun@gmail.com>
References: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.206]:2446 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932360AbWAZPYJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:09 -0500
Received: by zproxy.gmail.com with SMTP id 34so368591nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:08 -0800 (PST)
In-Reply-To: <11382890422935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

EDD is never used with ->probe_reset.  Don't handle EDD special case
in ata_dev_identify if ->probe_reset is in use.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

d759ca5b17e448ffa7e91143b754513d5f7f338b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c92f96f..e416950 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1294,7 +1294,8 @@ static void ata_dev_identify(struct ata_
 		return;
 	}
 
-	if (ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
+	if (ap->ops->probe_reset ||
+	    ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
 		using_edd = 0;
 	else
 		using_edd = 1;
-- 
1.1.3


