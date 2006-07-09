From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: LibPATA code issues / 2.6.15.4 (found the opcode=0x35)!
Date: Sun, 9 Jul 2006 16:40:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <44AEB3CA.8080606@pobox.com>
 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan> <200607091224.31451.liml@rtr.ca>
 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([66.45.37.187]:52425 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1161133AbWGIUkw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Jul 2006 16:40:52 -0400
In-Reply-To: <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

I made my own patch (following Mark's example) but also added that printk 
in that function.

Jul  9 16:37:52 p34 kernel: [4294810.556000] ata_gen_fixed_sense: failed 
ata_op=0x35
Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: translated ATA stat/err 
0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
Jul  9 16:37:52 p34 kernel: [4294810.556000] ata_gen_ata_desc_sense: 
failed ata_op=0x51
Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: status=0x51 { 
DriveReady SeekComplete Error }
Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: error=0x04 { 
DriveStatusError }

Now that we have found the ata_op code of 0x35, what does this mean?  Is 
it generated from a bad FUA/unsupported command from the kernel/SATA 
driver?

Justin.

