From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev-2.6:sil24 02/03] sil24: remove CMDERR clearing
Date: Thu,  6 Oct 2005 11:43:34 +0900 (KST)
Message-ID: <20051006024322.38822A95@htj.dyndns.org>
References: <20051006024322.E428BF34@htj.dyndns.org>
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:34222 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751201AbVJFCnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Oct 2005 22:43:41 -0400
Received: by wproxy.gmail.com with SMTP id i2so150566wra
        for <linux-ide@vger.kernel.org>; Wed, 05 Oct 2005 19:43:40 -0700 (PDT)
In-Reply-To: <20051006024322.E428BF34@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, efalk@google.com
Cc: linux-ide@vger.kernel.org

02_sil24_remove-cmderr-clearing.patch

	CMDERR register doesn't need clearing.  This is from Edward's
	driver.

Signed-off-by: Tejun Heo <htejun@gmail.com>

 sata_sil24.c |    4 ----
 1 file changed, 4 deletions(-)

Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-10-06 11:43:21.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-10-06 11:43:21.000000000 +0900
@@ -502,10 +502,6 @@ static void sil24_error_intr(struct ata_
 	cmd_err = readl(port + PORT_CMD_ERR);
 	sstatus = readl(port + PORT_SSTATUS);
 	serror = readl(port + PORT_SERROR);
-
-	/* Clear IRQ/errors */
-	if (cmd_err)
-		writel(cmd_err, port + PORT_CMD_ERR);
 	if (serror)
 		writel(serror, port + PORT_SERROR);
 

