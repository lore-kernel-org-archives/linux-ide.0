From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: kernel support for Marvell 88SE614x chipset
Date: Tue, 31 Oct 2006 13:19:58 +0000
Message-ID: <1162300798.11965.59.camel@localhost.localdomain>
References: <45471C4E.8050902@iinet.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30682 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423223AbWJaNRQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Oct 2006 08:17:16 -0500
In-Reply-To: <45471C4E.8050902@iinet.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Evan_D <spampit@iinet.net.au>
Cc: linux-ide@vger.kernel.org

Ar Maw, 2006-10-31 am 20:50 +1100, ysgrifennodd Evan_D:
> Hi
> 
> Is any work being done on implementing kernel support for the Marvell 
> 88SE614x  chipset?

Marvell provided some docs recently

> http://dlsvr01.asus.com/pub/ASUS/misc/ide/marvell6141/61xx_SATA_linux.zip.  
> Being a relatively newcomer to Linux I've not managed to successfully 
> compile and install the drivers.

Well it seems to be a 50MB tar ball that actually just adds the Marvell
device id to a copy of ahci.c

Something like this ought to work

--- drivers/ata/ahci.c~	2006-10-31 13:00:50.918919744 +0000
+++ drivers/ata/ahci.c	2006-10-31 13:00:50.927918376 +0000
@@ -344,6 +344,9 @@
 	{ PCI_VDEVICE(SI, 0x1184), board_ahci }, /* SiS 966 */
 	{ PCI_VDEVICE(SI, 0x1185), board_ahci }, /* SiS 966 */
 	{ PCI_VDEVICE(SI, 0x0186), board_ahci }, /* SiS 968 */
+	
+	/* Marvell */
+	{ PCI_VDEVICE(MARVELL, 0x6141), board_ahci }, 	/* Marvell 88SE614x */
 
 	{ }	/* terminate list */
 };

