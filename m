From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: fast exit from EH while unloading
Date: Mon, 12 Jun 2006 14:11:43 +0900
Message-ID: <20060612051143.GC9166@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:15488 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751347AbWFLFLs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 01:11:48 -0400
Received: by py-out-1112.google.com with SMTP id x31so1574659pye
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2006 22:11:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Make EH exit fast if the port is being unloaded.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-eh.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

82cc14802031e17e594daee60bfb99767dfc04da
diff --git a/drivers/scsi/libata-eh.c b/drivers/scsi/libata-eh.c
index 782dfba..531a4e1 100644
--- a/drivers/scsi/libata-eh.c
+++ b/drivers/scsi/libata-eh.c
@@ -1680,6 +1680,10 @@ static int ata_eh_recover(struct ata_por
 	down_xfermask = 0;
 	rc = 0;
 
+	/* if UNLOADING, finish immediately */
+	if (ap->flags & ATA_FLAG_UNLOADING)
+		goto out;
+
 	/* skip EH if possible. */
 	if (ata_eh_skip_recovery(ap))
 		ehc->i.action = 0;
-- 
1.3.2

