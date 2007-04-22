From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: add missing call to ->cable_detect() in new EH path
Date: Mon, 23 Apr 2007 02:05:53 +0900
Message-ID: <20070422170553.GL10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:14241 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161509AbXDVRF6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:05:58 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1326759wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:05:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

->cable_detect() used to be called on by the old ata_bus_probe() path.
Add invocation to ata_eh_revalidate_and_attach() right after IDENTIFYs
are done.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-eh.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0dbee55..67bf150 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1810,6 +1810,10 @@ static int ata_eh_revalidate_and_attach(struct ata_port *ap,
 		}
 	}
 
+	/* PDIAG- should have been released, ask cable type if post-reset */
+	if ((ehc->i.flags & ATA_EHI_DID_RESET) && ap->ops->cable_detect)
+		ap->cbl = ap->ops->cable_detect(ap);
+
 	/* Configure new devices forward such that user doesn't see
 	 * device detection messages backwards.
 	 */
-- 
1.5.0.3

