From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 08/07] sata_mv: remove leftovers
Date: Fri, 30 Jan 2009 21:40:48 -0500
Message-ID: <4983BA30.2010304@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca> <49839209.9010602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57800 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752384AbZAaCkv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 21:40:51 -0500
In-Reply-To: <49839209.9010602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Remove redundant code left over from the earlier patch 04/07.

Signed-off-by: Mark Lord <mlord@pobox.com>
---

Gets rid of a harmless artifact from an earlier patch.
Posted as an addendum, rather than reworking the entire sequence.

--- old/drivers/ata/sata_mv.c	2009-01-30 18:38:17.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 21:37:56.000000000 -0500
@@ -1820,8 +1820,6 @@
 		else if (!(qc->flags & ATA_QCFLAG_ACTIVE))
 			qc = NULL;
 	}
-	if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
-		qc = NULL;
 	return qc;
 }
 
