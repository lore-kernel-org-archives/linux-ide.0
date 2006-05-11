From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] PIIX: fix 82371MX enablebits
Date: Thu, 11 May 2006 23:50:56 +0400
Message-ID: <446395A0.20806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020602010708060803040205"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:50893 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1750756AbWEKTv4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 May 2006 15:51:56 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020602010708060803040205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

     According to the datasheet, Intel 82371MX (MPIIX) actually has only a
single IDE channel mapped to the primary or secondary ports depending on the
value of the bit 14 of the IDETIM register at PCI config. offset 0x6C (the
register at 0x6F which the driver refers to. doesn't exist). So, disguise the
controller as dual channel and set enablebits masks/values such that only
either primary or secondary channel is detected enabled. Also, preclude the
IDE probing code from reading PCI BARs, this controller just doesn't have them
(it's not the separate PCI function like the other PCI controllers), it only
decodes the legacy addresses.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------020602010708060803040205
Content-Type: text/plain;
 name="82371MX-IDE-enablebits-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="82371MX-IDE-enablebits-fix.patch"

Index: linus/drivers/ide/pci/piix.c
===================================================================
--- linus.orig/drivers/ide/pci/piix.c
+++ linus/drivers/ide/pci/piix.c
@@ -512,13 +512,19 @@ static ide_pci_device_t piix_pci_info[] 
 	/*  0 */ DECLARE_PIIX_DEV("PIIXa"),
 	/*  1 */ DECLARE_PIIX_DEV("PIIXb"),
 
-	{	/* 2 */
+	/*  2 */
+	{	/*
+		 * MPIIX actually has only a single IDE channel mapped to
+		 * the primary or secondary ports depending on the value
+		 * of the bit 14 of the IDETIM register at offset 0x6c
+		 */
 		.name		= "MPIIX",
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= NODMA,
-		.enablebits	= {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},
+		.enablebits	= {{0x6d,0xc0,0x80}, {0x6d,0xc0,0xc0}},
 		.bootable	= ON_BOARD,
+		.flags		= IDEPCI_FLAG_ISA_PORTS
 	},
 
 	/*  3 */ DECLARE_PIIX_DEV("PIIX3"),



--------------020602010708060803040205--
