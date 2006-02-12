From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: don't do EDD handling if ->probe_reset is used
Date: Sun, 12 Feb 2006 23:22:37 +0900
Message-ID: <20060212142237.GA7281@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:30089 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750761AbWBLOXO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:23:14 -0500
Received: by pproxy.gmail.com with SMTP id x31so570064pye
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:22:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

EDD is never used with ->probe_reset.  Don't handle EDD special case
in ata_dev_identify if ->probe_reset is in use.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

This patch should have been included in the reset patchset but was
left out somehow, sorry.  This patch is generated on top of "misc
preps for configuration reorganization" patchset[1] I've just posted
but also applies over upstream with offset.

[1] http://article.gmane.org/gmane.linux.ide/7977

 libata-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: work1/drivers/scsi/libata-core.c
===================================================================
--- work1.orig/drivers/scsi/libata-core.c	2006-02-12 22:54:42.000000000 +0900
+++ work1/drivers/scsi/libata-core.c	2006-02-12 22:56:29.000000000 +0900
@@ -939,7 +939,8 @@ static void ata_dev_identify(struct ata_
 		return;
 	}
 
-	if (ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
+	if (ap->ops->probe_reset ||
+	    ap->flags & (ATA_FLAG_SRST | ATA_FLAG_SATA_RESET))
 		using_edd = 0;
 	else
 		using_edd = 1;
