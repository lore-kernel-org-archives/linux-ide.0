From: Mark Lord <liml@rtr.ca>
Subject: [PATCH 04/07] sata_mv: update ata_qc_from_tag
Date: Fri, 30 Jan 2009 18:49:29 -0500
Message-ID: <49839209.9010602@rtr.ca>
References: <49839107.2040603@rtr.ca> <4983915F.7090705@rtr.ca> <498391A7.1090209@rtr.ca> <498391D9.2000403@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:57878 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbZA3Xta (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Jan 2009 18:49:30 -0500
In-Reply-To: <498391D9.2000403@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Update the logic in ata_qc_from_tag() to match that used
in similar places elsewhere in libata.

Signed-off-by: Mark Lord <mlord@pobox.com>

--- old/drivers/ata/sata_mv.c	2009-01-30 18:23:22.000000000 -0500
+++ linux/drivers/ata/sata_mv.c	2009-01-30 18:26:55.000000000 -0500
@@ -1628,6 +1628,12 @@
 	if (pp->pp_flags & MV_PP_FLAG_NCQ_EN)
 		return NULL;
 	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc) {
+		if (qc->tf.flags & ATA_TFLAG_POLLING)
+			qc = NULL;
+		else if (!(qc->flags & ATA_QCFLAG_ACTIVE))
+			qc = NULL;
+	}
 	if (qc && (qc->tf.flags & ATA_TFLAG_POLLING))
 		qc = NULL;
 	return qc;
