From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic changes in ata_bus_softreset()
Date: Sat, 25 Mar 2006 01:02:11 +0900
Message-ID: <20060324160211.GA2806@htj.dyndns.org>
References: <20060324034556.GF25706@htj.dyndns.org> <44240337.8030509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:56614 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbWCXQCR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 11:02:17 -0500
Received: by zproxy.gmail.com with SMTP id o37so859443nzf
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 08:02:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44240337.8030509@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
positive number.  While at it, reformat comment above it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>

---

 libata-core.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

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
 
