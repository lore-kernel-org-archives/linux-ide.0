From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] pcmcia: add CNF-CDROM-ID for ide
Date: Fri,  7 Aug 2009 13:17:50 +0200
Message-ID: <1249643870-13276-1-git-send-email-w.sang@pengutronix.de>
References: <20090806.132413.156910755.davem@davemloft.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33493 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbZHGLRu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Aug 2009 07:17:50 -0400
In-Reply-To: <20090806.132413.156910755.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, David Miller <davem@davemloft.net>, Wolfram Sang <w.sang@pengutronix.de>

Fixes this report:
http://article.gmane.org/gmane.linux.kernel.pcmcia.devel/2228/

Reported-by: John McGrath <john@john-mcgrath.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/ide/ide-cs.c      |    1 +
 1 file changed, 1 insertion(+), 0 deletions(-)

diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index 527908f..063b933 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -408,6 +408,7 @@ static struct pcmcia_device_id ide_ids[] = {
 	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907960c, 0xf7fde8b9),
 	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "CD-ROM", 0x78f308dc, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "PnPIDE", 0x78f308dc, 0x0c694728),
+	PCMCIA_DEVICE_PROD_ID12("CNF   ", "CD-ROM", 0x46d7db81, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("CNF CD-M", "CD-ROM", 0x7d93b852, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("Creative Technology Ltd.", "PCMCIA CD-ROM Interface Card", 0xff8c8a45, 0xfe8020c4),
 	PCMCIA_DEVICE_PROD_ID12("Digital Equipment Corporation.", "Digital Mobile Media CD-ROM", 0x17692a66, 0xef1dcbde),
-- 
1.6.3.1

