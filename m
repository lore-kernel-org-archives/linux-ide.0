From: Rolf Eike Beer <eike-kernel@sf-tec.de>
Subject: Fwd: [PATCH] typo fix in drivers/scsi/sata_svw.c
Date: Tue, 5 Apr 2005 10:51:25 +0200
Message-ID: <200504051051.26321@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:31675 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261630AbVDEIpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Apr 2005 04:45:33 -0400
Received: from bilbo.math.uni-mannheim.de ([::ffff:134.155.88.153])
	by mail.sf-mail.de (Qsmtpd 0.3) with (RC4-MD5 encrypted) ESMTPS
	for <linux-ide@vger.kernel.org>; Tue, 05 Apr 2005 10:45:30 +0200
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: benh@kernel.crashing.org

Add missing brace.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/drivers/scsi/sata_svw.c	2005-03-21 11:41:58.000000000 +0100
+++ linux-2.6.12-rc1/drivers/scsi/sata_svw.c	2005-03-27 15:50:38.000000000 +0200
@@ -395,7 +395,7 @@
 
 	/* Clear a magic bit in SCR1 according to Darwin, those help
 	 * some funky seagate drives (though so far, those were already
-	 * set by the firmware on the machines I had access to
+	 * set by the firmware on the machines I had access to)
 	 */
 	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
 	       mmio_base + K2_SATA_SICR1_OFFSET);
