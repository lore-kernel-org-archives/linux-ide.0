From: Vlad Codrea <vladc6@yahoo.com>
Subject: Re: IDE Problem with old Gateway laptop (1998 solo 2300)
Date: Tue, 30 Oct 2007 14:03:59 -0700 (PDT)
Message-ID: <884696.96067.qm@web54404.mail.yahoo.com>
References: <1193749336.2360.88.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web54404.mail.yahoo.com ([206.190.49.134]:34019 "HELO
	web54404.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755726AbXJ3VEB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 17:04:01 -0400
In-Reply-To: <1193749336.2360.88.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Declan Moriarty <declan.moriarty@iol.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide <linux-ide@vger.kernel.org>

--- Declan Moriarty <declan.moriarty@iol.ie> wrote:
> On Mon, 2007-10-29 at 11:20 +0000, Alan Cox wrote: 
> > 1998 is well into the world of ATA (IDE is just a confusing
> othername)
> Yeah I read it as 'faster ide' but the board/disk won't do it. The
> disk
> seems up to it, but something else is dodgy.
> > 
> > From your info there isn't enough to debug this. 
> > 
> > Boot the kernel with initcall_debug=1
> > 
> > and it will spew a list of each initializer as it calls it, you
> can then
> > see which is the last called and look it up in the symbol table
> ide_init
...
> 	Uniform  Multi-Platform E-IDE driver Revision 7.00alpha2
> 	ide assuming 33 Mhz
> ide_generic_init
> 	Hitatchi_DK226A-32 ATA disk drive
> 	ide0 at 0x1f0-0x1f7 on irq 14
> *** ide_generic_init took 1446 msec to run***(asterisks mine)
> 
> 
> idedisk_init
> 	hda: max request size:128KiB
> 	hda: 6332256 sectors (3242 MB) w/128 KiB Cache CHS=6282/16/63
> 	hda: hda1 hda2 hda3 hda4
> *** Ran for 18 msec*** (asterisks mine)

The above output seems to indicate that the kernel is still relying on
drivers/ide instead of libata. To change this, I'd suggest setting
"CONFIG_IDE=n" and "CONFIG_ATA=y" in your .config before compiling the
kernel. Also, make sure everything that starts with CONFIG_ATA,
CONFIG_PATA, CONFIG_SATA, and CONFIG_SCSI is set to "y".

Vlad

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
