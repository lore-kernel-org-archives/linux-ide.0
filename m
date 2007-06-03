From: olof@lixom.net (Olof Johansson)
Subject: [PATCH] [2.6.22] libata: fix probe time irq printouts
Date: Sun, 3 Jun 2007 18:35:10 -0500
Message-ID: <20070603233510.GA25750@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:35244 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbXFCX3K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Jun 2007 19:29:10 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Most drivers don't seem to fill out the host->irq field, resulting in the
wrong (no) irq being reported at probe time. For example, sil24 on my system:

ata1: SATA max UDMA/100 cmd 0xd00008009001f000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0
ata2: SATA max UDMA/100 cmd 0xd000080090021000 ctl 0x0000000000000000 bmdma 0x0000000000000000 irq 0

Since they're allocated and set up in ata_host_activate(), just save
them away there.


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index af62514..7491b11 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6438,6 +6438,9 @@ int ata_host_activate(struct ata_host *host, int irq,
 	if (rc)
 		devm_free_irq(host->dev, irq, host);
 
+	/* Used to print device info at probe */
+	host->irq = irq;
+
 	return rc;
 }
 
