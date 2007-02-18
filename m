From: Magnus Damm <damm@opensource.se>
Subject: [PATCH] pata_pcmcia: Update device table
Date: Sun, 18 Feb 2007 17:52:25 +0900
Message-ID: <20070218085225.447.95141.sendpatchset@va-lsv.local.valinux.co.jp>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1]:36912 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161128AbXBRIwZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Feb 2007 03:52:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-pcmcia@lists.infradead.org
Cc: linux-ide@vger.kernel.org, Magnus Damm <damm@opensource.se>, alan@lxorguk.ukuu.org.uk

pata_pcmcia: Update device table

Add CFA devices from I-O Data, Mitsubishi and Viking. Add SanDisk comment.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to 2.6.20-git14.

 pata_pcmcia.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- 0002/drivers/ata/pata_pcmcia.c
+++ work/drivers/ata/pata_pcmcia.c	2007-02-18 15:54:17.000000000 +0900
@@ -320,14 +320,17 @@ static void pcmcia_remove_one(struct pcm
 static struct pcmcia_device_id pcmcia_devices[] = {
 	PCMCIA_DEVICE_FUNC_ID(4),
 	PCMCIA_DEVICE_MANF_CARD(0x0007, 0x0000),	/* Hitachi */
+	PCMCIA_DEVICE_MANF_CARD(0x000a, 0x0000),	/* I-O Data CFA */
+	PCMCIA_DEVICE_MANF_CARD(0x001c, 0x0001),	/* Mitsubishi CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
-	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),
+	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
 	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
 	PCMCIA_DEVICE_MANF_CARD(0x00ce, 0x0000),	/* Samsung */
  	PCMCIA_DEVICE_MANF_CARD(0x0319, 0x0000),	/* Hitachi */
 	PCMCIA_DEVICE_MANF_CARD(0x2080, 0x0001),
-	PCMCIA_DEVICE_MANF_CARD(0x4e01, 0x0200),	/* Lexar */
+	PCMCIA_DEVICE_MANF_CARD(0x4e01, 0x0100),	/* Viking CFA */
+	PCMCIA_DEVICE_MANF_CARD(0x4e01, 0x0200),	/* Lexar, Viking CFA */
 	PCMCIA_DEVICE_PROD_ID123("Caravelle", "PSC-IDE ", "PSC000", 0x8c36137c, 0xd0693ab8, 0x2768a9f0),
 	PCMCIA_DEVICE_PROD_ID123("CDROM", "IDE", "MCD-601p", 0x1b9179ca, 0xede88951, 0x0d902f74),
 	PCMCIA_DEVICE_PROD_ID123("PCMCIA", "IDE CARD", "F1", 0x281f1c5d, 0x1907960c, 0xf7fde8b9),
