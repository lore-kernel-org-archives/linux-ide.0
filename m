From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_via: write errors on SATA drive connected to VT6421
Date: Tue, 03 Feb 2009 08:38:32 -0600
Message-ID: <498856E8.4020404@gmail.com>
References: <20090203133008.GN19493@dawn.rhaalovely.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:16073 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbZBCOif (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2009 09:38:35 -0500
Received: by yx-out-2324.google.com with SMTP id 8so713830yxm.1
        for <linux-ide@vger.kernel.org>; Tue, 03 Feb 2009 06:38:34 -0800 (PST)
In-Reply-To: <20090203133008.GN19493@dawn.rhaalovely.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Landry Breuil <landry@rhaalovely.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

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
> kernel: ata2.00: status: { DRDY }
> kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
> kernel: ata2: device not ready (errno=-16), forcing hardreset
> kernel: ata2: hard resetting link
> kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> 
> Reading big datas is okay so far. Creating a 2.5Gb file on the same disk
> with dd if=/dev/zero is okay too. dd'ing a 500Mb file 10 times in a loop
> from sda to sdb works too.

This seems to indicate that the controller lost communication with the 
drive. This is usually due to some kind of hardware problem, like a 
power issue, cable or drive problem. Given that it's occurring when both 
drives are active, a power issue is quite possible..
