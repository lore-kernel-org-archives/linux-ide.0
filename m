From: Richard Kennedy <richard@rsk.demon.co.uk>
Subject: [PATCH] pata_pcmcia.c: add card ident for jvc cdrom
Date: Tue, 08 May 2007 15:20:56 +0100
Message-ID: <1178634056.3835.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:3414 "EHLO
	anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968076AbXEHOU7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 10:20:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

update pata_pcmcia to add card ident for JVC MP-CDX1 cdrom drive
card info:
PRODID_1="KME"
PRODID_2="KXLC005"
PRODID_3="00"
MANFID=0032,2904

Signed-off-by: Richard Kennedy <richard@rsk.demon.co.uk>
---
patch against 2.6.21.1

This gets my laptop cd drive working with the new libata driver.
thanks
Richard

--- linux-2.6.21.1/drivers/ata/pata_pcmcia.c	2007-04-27 22:49:26.000000000 +0100
+++ linux-2.6.21.1/drivers/ata/pata_pcmcia.c.new	2007-05-08 12:18:35.000000000 +0100
@@ -322,6 +322,7 @@ static struct pcmcia_device_id pcmcia_de
 	PCMCIA_DEVICE_MANF_CARD(0x000a, 0x0000),	/* I-O Data CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x001c, 0x0001),	/* Mitsubishi CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x0704),
+	PCMCIA_DEVICE_MANF_CARD(0x0032, 0x2904),
 	PCMCIA_DEVICE_MANF_CARD(0x0045, 0x0401),	/* SanDisk CFA */
 	PCMCIA_DEVICE_MANF_CARD(0x0098, 0x0000),	/* Toshiba */
 	PCMCIA_DEVICE_MANF_CARD(0x00a4, 0x002d),
 

