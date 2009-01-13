From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] ata: fix wrong WARN_ON_ONCE
Date: Tue, 13 Jan 2009 10:38:36 +0100
Message-ID: <200901131038.36593.borntraeger@de.ibm.com>
References: <200901091334.55823.borntraeger@de.ibm.com> <4968BA6F.8050207@ru.mvista.com> <20090110152800.44308491@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:35393 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbZAMJio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jan 2009 04:38:44 -0500
In-Reply-To: <20090110152800.44308491@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Jeff, Alan,

this is still not fixed upstream. What about:

[PATCH] ata: fix wrong WARN_ON_ONCE

This patch fixes a wrong WARN_ON that was triggered by 32bit PIO support:
WARNING: at drivers/ata/libata-sff.c:1017 ata_sff_hsm_move+0x45e/0x750()

__atapi_pio_bytes simply doesnt know enough to decide if there is a bug.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/ata/libata-sff.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.orig/drivers/ata/libata-sff.c
+++ linux-2.6/drivers/ata/libata-sff.c
@@ -1013,9 +1013,12 @@ next_sg:
 		qc->cursg_ofs = 0;
 	}
 
-	/* consumed can be larger than count only for the last transfer */
-	WARN_ON_ONCE(qc->cursg && count != consumed);
-
+	/*
+	 * There used to be a  WARN_ON_ONCE(qc->cursg && count != consumed);
+	 * Unfortunately __atapi_pio_bytes doesn't know enough to do the WARN
+	 * check correctly as it doesn't know if it is the last request being
+	 * made. Somebody should implement a proper sanity check.
+	 */
 	if (bytes)
 		goto next_sg;
 	return 0;
