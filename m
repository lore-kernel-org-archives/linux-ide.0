From: Marc Pignat <marc.pignat@hevs.ch>
Subject: [PATCH] pata_pcmcia: another memory card support
Date: Thu, 6 Nov 2008 11:44:34 +0100
Message-ID: <200811061144.35556.marc.pignat@hevs.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hevs.ch ([153.109.23.10]:33398 "EHLO mail.hevs.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbYKFKon (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Nov 2008 05:44:43 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-ide@vger.kernel.org

Support for Apacer photo steno pro card.

Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
---

Hi all!

Here is a new ID for ide-cs and pata_pcmcia. I tried all the card
I can find in the labs, only this one was unknown.

Best regards

Marc



diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 271cb64..64b2e22 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -416,6 +416,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
 	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
+	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
 	PCMCIA_DEVICE_NULL,
 };
 
diff --git a/drivers/ide/ide-cs.c b/drivers/ide/ide-cs.c
index cb199c8..f50210f 100644
--- a/drivers/ide/ide-cs.c
+++ b/drivers/ide/ide-cs.c
@@ -444,6 +444,7 @@ static struct pcmcia_device_id ide_ids[] = {
 	PCMCIA_DEVICE_PROD_ID1("STI Flash", 0xe4a13209),
 	PCMCIA_DEVICE_PROD_ID12("STI", "Flash 5.0", 0xbf2df18d, 0x8cb57a0e),
 	PCMCIA_MFC_DEVICE_PROD_ID12(1, "SanDisk", "ConnectPlus", 0x7a954bd9, 0x74be00c6),
+	PCMCIA_DEVICE_PROD_ID2("Flash Card", 0x5a362506),
 	PCMCIA_DEVICE_NULL,
 };
 MODULE_DEVICE_TABLE(pcmcia, ide_ids);
