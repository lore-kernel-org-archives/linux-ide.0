From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 02/49] pcmcia: uniform device IDs of pata_pcmcia and ide-cs
Date: Mon, 13 Oct 2008 19:47:47 +0200
Message-ID: <1223920114-19788-2-git-send-email-linux@dominikbrodowski.net>
References: <20081013173803.GA18569@comet.dominikbrodowski.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.133.102.198]:58614 "EHLO linta.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753345AbYJMRvR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 13:51:17 -0400
In-Reply-To: <20081013173803.GA18569@comet.dominikbrodowski.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-ide@vger.kernel.org

Over time, a few differences have accumulated between pata_pcmcia
and ide-cs. Fix those.

CC: linux-ide@vger.kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/ata/pata_pcmcia.c   |    3 ++-
 drivers/ide/legacy/ide-cs.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 41b4361..3c1fbb2 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -384,6 +384,7 @@ static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x2904),
 	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
+	PCMCIA_DEVICE_MANF_CARD(0x004f, 0x0000),	/* Kingston */
 	PCMCIA_DEVICE_MANF_CARD(0x0097, 0x1620), 	/* TI emulated */
 	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
 	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
@@ -404,9 +405,9 @@ static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_PROD_ID12("EXP   ", "CD-ROM", 0x0a5c52fd, 0x66536591),
 	PCMCIA_DEVICE_PROD_ID12("EXP   ", "PnPIDE", 0x0a5c52fd, 0x0c694728),
 	PCMCIA_DEVICE_PROD_ID12("FREECOM", "PCCARD-IDE", 0x5714cbf7, 0x48e0ab8e),
-	PCMCIA_DEVICE_PROD_ID12("Hyperstone", "Model1", 0x3d5b9ef5, 0xca6ab420),
 	PCMCIA_DEVICE_PROD_ID12("HITACHI", "FLASH", 0xf4f43949, 0x9eb86aae),
 	PCMCIA_DEVICE_PROD_ID12("HITACHI", "microdrive", 0xf4f43949, 0xa6d76178),
+	PCMCIA_DEVICE_PROD_ID12("Hyperstone", "Model1", 0x3d5b9ef5, 0xca6ab420),
 	PCMCIA_DEVICE_PROD_ID12("IBM", "microdrive", 0xb569a6e5, 0xa6d76178),
 	PCMCIA_DEVICE_PROD_ID12("IBM", "IBM17JSSFP20", 0xb569a6e5, 0xf2508753),
 	PCMCIA_DEVICE_PROD_ID12("KINGSTON", "CF8GB", 0x2e6d1829, 0xacbe682e),
diff --git a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
index 21bfac1..6dd2705 100644
--- a/drivers/ide/legacy/ide-cs.c
+++ b/drivers/ide/legacy/ide-cs.c
@@ -404,8 +404,10 @@ static struct pcmcia_device_id ide_ids[] = {
 	PCMCIA_DEVICE_MANF_CARD(0x000a, 0x0000),	/* I-O Data CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x001c, 0x0001),	/* Mitsubishi CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
+	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x2904),
 	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x004f, 0x0000),	/* Kingston */
+	PCMCIA_DEVICE_MANF_CARD(0x0097, 0x1620), 	/* TI emulated */
 	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
 	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
 	PCMCIA_DEVICE_MANF_CARD(0x00ce, 0x0000),	/* Samsung */
-- 
1.5.4.3

