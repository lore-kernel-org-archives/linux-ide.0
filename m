From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] sd: fix return value of sd_sync_cache()
Date: Wed, 21 Mar 2007 00:07:18 +0900
Message-ID: <20070320150718.GF6152@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.231]:45703 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573AbXCTPHY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 20 Mar 2007 11:07:24 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1776326wxd
        for <linux-ide@vger.kernel.org>; Tue, 20 Mar 2007 08:07:23 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>, djwong@us.ibm.com, hmh@hmh.eng.br

sd_sync_cache() should return -errno on error, fix it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/scsi/sd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work/drivers/scsi/sd.c
===================================================================
--- work.orig/drivers/scsi/sd.c
+++ work/drivers/scsi/sd.c
@@ -817,7 +817,9 @@ static int sd_sync_cache(struct scsi_dev
 				scsi_print_sense_hdr("sd", &sshdr);
 	}
 
-	return res;
+	if (res)
+		return -EIO;
+	return 0;
 }
 
 static int sd_issue_flush(struct device *dev, sector_t *error_sector)
