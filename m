From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic changes in ata_bus_softreset()
Date: Sat, 25 Mar 2006 02:58:13 +0900
Message-ID: <20060324175813.GA20709@htj.dyndns.org>
References: <20060324034556.GF25706@htj.dyndns.org> <44240337.8030509@pobox.com> <20060324160211.GA2806@htj.dyndns.org> <44242B97.30706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.197]:62943 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751331AbWCXR6T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 12:58:19 -0500
Received: by xproxy.gmail.com with SMTP id t10so542918wxc
        for <linux-ide@vger.kernel.org>; Fri, 24 Mar 2006 09:58:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <44242B97.30706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

ata_bus_softreset() should return AC_ERR_* on failure not arbitrary
positive number.  While at it, reformat comment above it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Acked-by: Alan Cox <alan@redhat.com>

---

Hmmm... weird.  Here's the regenerated patch against the current
upstream (aec5c3c1a929d7d79a420e943285cf3ba26a7c0d).

 libata-core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 0aff888..64f71df 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2008,13 +2008,12 @@ static unsigned int ata_bus_softreset(st
 	 */
 	msleep(150);
 
-
 	/* Before we perform post reset processing we want to see if
-	   the bus shows 0xFF because the odd clown forgets the D7 pulldown
-	   resistor */
-
+	 * the bus shows 0xFF because the odd clown forgets the D7
+	 * pulldown resistor.
+	 */
 	if (ata_check_status(ap) == 0xFF)
-		return 1;	/* Positive is failure for some reason */
+		return AC_ERR_OTHER;
 
 	ata_bus_post_reset(ap, devmask);
 
