From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: sata_via: write errors on SATA drive connected to VT6421
Date: Tue, 03 Feb 2009 10:59:10 -0500
Message-ID: <498869CE.6030902@pobox.com>
References: <20090203133008.GN19493@dawn.rhaalovely.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39674 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbZBCP7Q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Feb 2009 10:59:16 -0500
In-Reply-To: <20090203133008.GN19493@dawn.rhaalovely.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Landry Breuil <landry@rhaalovely.net>
Cc: linux-ide@vger.kernel.org

Landry Breuil wrote:
> Hi,
> 
> i encounter a very similar problem as reported in
> http://marc.info/?l=linux-kernel&m=118764381013943&w=2, but with a SATA
> disk. Trying to transfer 250Gb (mostly small files) from a SATA disk
> (ata1/sda) to another (ata2/sdb), both plugged on the VT6421 card, after
> some dozens of seconds the controler bails out and degrades write performance
> (UDMA133->UDMA100->UDMA33...)
> 
> kernel: ata2.00: limiting speed to UDMA/33:PIO4
> kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
> kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
> kernel: ata2.00: cmd 35/00:00:07:c6:f4/00:04:07:00:00/e0 tag 0 dma 524288 out
> kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)

Like Robert noted, this is the hardware complaining that it has found a 
hardware error.

"SErr" stands for SATA SError register value.  That is a value read 
directly from hardware, which indicates one or more problems.  Here is 
some more info:
http://ata.wiki.kernel.org/index.php/Libata_error_messages#SATA_SError_expansion

When libata sees a bunch of hardware problems, it tries the only things 
it can do to attempt progress in that situation:  reset the hardware, 
and slow down data transfer in an attempt to avoid errors again.

	Jeff



