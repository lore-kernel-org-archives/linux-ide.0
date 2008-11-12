From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 5/6] pcmcia: add another pata/ide ID
Date: Wed, 12 Nov 2008 11:24:57 +0100
Message-ID: <1226485498-15754-5-git-send-email-linux@dominikbrodowski.net>
References: <20081112101725.GA14698@comet.dominikbrodowski.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:46517 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752595AbYKLKZa (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 05:25:30 -0500
In-Reply-To: <20081112101725.GA14698@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Marc Pignat <marc.pignat@hevs.ch>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org

From: Marc Pignat <marc.pignat@hevs.ch>

Support for Apacer photo steno pro card.

Signed-off-by: Marc Pignat <marc.pignat@hevs.ch>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk
CC: linux-ide@vger.kernel.org
---
 drivers/ata/pata_pcmcia.c |    1 +
 drivers/ide/ide-cs.c      |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

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
-- 
1.5.6.3

