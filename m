From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_nv: make hardreset return -EAGAIN on
 success
Date: Wed, 23 Apr 2008 12:14:05 +0900
Message-ID: <480EA97D.8080704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.246]:48739 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbYDWDON (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Apr 2008 23:14:13 -0400
Received: by ag-out-0708.google.com with SMTP id 35so4195529aga.10
        for <linux-ide@vger.kernel.org>; Tue, 22 Apr 2008 20:14:12 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: marc.c.dionne@gmail.com, Petr Vandrovec <vandrove@vc.cvut.cz>, Roland Dreier <rdreier@cisco.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

sata_nv hardreset can't classify but was left out while unifying
follow-up SRST request mechanism[1].  This caused detection failures
on those controllers.  Fix it.

Reported and bisected by Roland Dreier, Petr Vandrovec and Marc
Dionne.  Thanks guys.

[1] 305d2a1ab137d11d573319c315748a87060fe82d

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Roland Dreier <rdreier@cisco.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Marc Dionne <marc.c.dionne@gmail.com>
---
It actually was a single fall out I missed.  This is the proper fix
and verfied on ck804.

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 109b074..858f706 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1591,13 +1591,16 @@ static void nv_mcp55_thaw(struct ata_port *ap)
 static int nv_hardreset(struct ata_link *link, unsigned int *class,
 			unsigned long deadline)
 {
-	unsigned int dummy;
+	int rc;
 
 	/* SATA hardreset fails to retrieve proper device signature on
-	 * some controllers.  Don't classify on hardreset.  For more
-	 * info, see http://bugzilla.kernel.org/show_bug.cgi?id=3352
+	 * some controllers.  Request follow up SRST.  For more info,
+	 * see http://bugzilla.kernel.org/show_bug.cgi?id=3352
 	 */
-	return sata_sff_hardreset(link, &dummy, deadline);
+	rc = sata_sff_hardreset(link, class, deadline);
+	if (rc)
+		return rc;
+	return -EAGAIN;
 }
 
 static void nv_adma_error_handler(struct ata_port *ap)
