From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH libata-dev#upstream 1/2] libata: don't skip EH report if action is pending
Date: Tue, 31 Jul 2007 16:42:03 +0900
Message-ID: <20070731074203.GA13674@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:9456 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbXGaHmI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Jul 2007 03:42:08 -0400
Received: by rv-out-0910.google.com with SMTP id k20so532332rvb
        for <linux-ide@vger.kernel.org>; Tue, 31 Jul 2007 00:42:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, mikpe@it.uu.se

Don't skip EH report if action is pending.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1675,7 +1675,7 @@ static void ata_eh_report(struct ata_por
 		nr_failed++;
 	}
 
-	if (!nr_failed && !ehc->i.err_mask)
+	if (!nr_failed && !ehc->i.err_mask && !ehc->i.action)
 		return;
 
 	frozen = "";
