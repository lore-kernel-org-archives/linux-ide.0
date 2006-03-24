From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic change in ata_bus_softreset()
Date: Fri, 24 Mar 2006 12:45:56 +0900
Message-ID: <20060324034556.GF25706@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:9571 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751536AbWCXDqC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 22:46:02 -0500
Received: by pproxy.gmail.com with SMTP id w49so621181pyg
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 19:46:01 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, alan@htj.dyndns.org, linux-ide@vger.kernel.org

ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
positive number.  While at it, kill trailing indentations and reformat
comment.

Signed-off-by: Tejun Heo <htejun@gmail.com>

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index f3c115b..200198c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1999,13 +1999,12 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
-	
-	/* Before we perform post reset processing we want to see if 
-	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
-	   resistor */
-	
+	/* Before we perform post reset processing we want to see if
+	 * the bus shows 0xFF because the odd clown forgets the D7
+	 * pulldown resistor
+	 */
 	if (ata_check_status(ap) == 0xFF)
-		return 1;	/* Positive is failure for some reason */
+		return AC_ERR_OTHER;
 
 	ata_bus_post_reset(ap, devmask);
 
