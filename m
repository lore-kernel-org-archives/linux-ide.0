From: Mark Lord <liml@rtr.ca>
Subject: Re: Delkin Cardbus IDE, a.k.a. ASKA "Ninja" chipset
Date: Tue, 13 Nov 2007 23:50:47 -0500
Message-ID: <473A7EA7.2030404@rtr.ca>
References: <200711031541.lA3FfJ6h006120@harpo.it.uu.se>	<20071103162203.5388a37f@the-village.bc.nu>	<47323E13.3030205@rtr.ca>	<20071107232132.238fdf04@the-village.bc.nu>	<47324A16.5010205@rtr.ca>	<4738B364.5030806@rtr.ca> <20071114005718.7b151b37@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1070 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757369AbXKNEus (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Nov 2007 23:50:48 -0500
In-Reply-To: <20071114005718.7b151b37@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, greg.freemyer@gmail.com, linux-ide@vger.kernel.org

Alan wrote:
> First guess
> 
> /*
>  * pata_ninja32.c 	- Ninja32 PATA for new ATA layer
..

Okay, I tried it on the wife's notebook.
It needs the patch below to enable chip interrupts,
and it is *very* slow on I/O (1MB/sec), slower even
than delkin_cb at present.

But it does work, with this patch:

Signed-off-by: Mark Lord <mlord@pobox.com>
---
(I still have hardware here to send you..)

--- old/pata_ninja32.c	2007-11-13 23:06:21.000000000 -0500
+++ new/pata_ninja32.c	2007-11-13 23:49:24.000000000 -0500
@@ -169,6 +169,7 @@
 	ap->pio_mask = 0x1F;
 	ap->flags |= ATA_FLAG_SLAVE_POSS;
 	
+	iowrite8(0x05, base + 1);
 	ap->ioaddr.cmd_addr = base + 0x10;
 	ap->ioaddr.ctl_addr = base + 0x1E;
 	ap->ioaddr.altstatus_addr = base + 0x1E;
