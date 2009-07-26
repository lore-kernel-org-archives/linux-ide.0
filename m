From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] pcmcia: add CNF-CDROM-ID for ide/pata
Date: Sun, 26 Jul 2009 18:27:29 +0200
Message-ID: <1248625649-7193-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49374 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZGZQ1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jul 2009 12:27:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org, Wolfram Sang <w.sang@pengutronix.de>

Fixes this report:
http://article.gmane.org/gmane.linux.kernel.pcmcia.devel/2228/

Reported-by: John McGrath <john@john-mcgrath.com>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/ata/pata_pcmcia.c |    1 +
 drivers/ide/ide-cs.c      |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index f4d009e..dc99e26 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -411,6 +411,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907960c, 0xf7fde8b9),
 	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "CD-ROM", 0x78f308dc, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("ARGOSY", "PnPIDE", 0x78f308dc, 0x0c694728),
+	PCMCIA_DEVICE_PROD_ID12("CNF   ", "CD-ROM", 0x46d7db81, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("CNF CD-M", "CD-ROM", 0x7d93b852, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("Creative Technology Ltd.", "PCMCIA CD-ROM Interface Card", 0xff8c8a45, 0xfe8020c4),
 	PCMCIA_DEVICE_PROD_ID12("Digital Equipment Corporation.", "Digital Mobile Media CD-ROM", 0x17692a66, 0xef1dcbde),
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

