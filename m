From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] HPT37x: read f_CNT saved by BIOS from port
Date: Sat, 20 May 2006 12:41:26 +0400
Message-ID: <446ED636.4000905@ru.mvista.com>
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010806010505080003010008"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:40136 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932251AbWETIma
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 May 2006 04:42:30 -0400
In-Reply-To: <445A5A1B.60903@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------010806010505080003010008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    The undocumented register BIOS uses for saving f_CNT seems to only be
mapped to I/O space while all the other HPT3xx regs are dual-mapped. Looks
like another HighPoint's dirty trick.
    With this patch, the deadly kernel oops on the cards having the modern
HighPoint BIOSes is now at last gone!

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------010806010505080003010008
Content-Type: text/plain;
 name="HPT37x-read-f_CNT-from-port.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT37x-read-f_CNT-from-port.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1016,14 +1016,14 @@ static void __devinit hpt37x_clocking(id
 	 * First try reading the register in which the HighPoint BIOS
 	 * saves f_CNT value before  reprogramming the DPLL from its
 	 * default setting (which differs for the various chips).
+	 * NOTE: This register is only accessible via I/O space.
+	 *
 	 * In case the signature check fails, we'll have to resort to
 	 * reading the f_CNT register itself in hopes that nobody has
 	 * touched the DPLL yet...
 	 */
-	pci_read_config_dword(dev, 0x70, &temp);
+	temp = inl(pci_resource_start(dev, 4) + 0x90);
 	if ((temp & 0xFFFFF000) != 0xABCDE000) {
-		int i;
-
 		printk(KERN_WARNING "HPT37X: no clock data saved by BIOS\n");
 
 		/* Calculate the average value of f_CNT */



--------------010806010505080003010008--
