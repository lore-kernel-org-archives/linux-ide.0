From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Thu, 19 Jan 2006 01:05:02 +0000
Message-ID: <1137632702.1760.29.camel@localhost.localdomain>
References: <200601131909.07981.pvrusb2@toplitzer.net>
	 <200601181536.16868.pvrusb2@toplitzer.net>
	 <58cb370e0601180813pfb6baffr953e5be26223ea1@mail.gmail.com>
	 <200601190041.36138.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4799 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161130AbWASBFt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Jan 2006 20:05:49 -0500
In-Reply-To: <200601190041.36138.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

On Iau, 2006-01-19 at 00:41 +0100, Helmut Toplitzer wrote:
> Ok. Was just a bit digging through the sourcecode. Found a
> function called disable_hlt. Some further digging.
> Found in drivers/block/floppy.c a usage of disable_hlt.
> It's called (if I haven't missunderstood something) 
> whenever a DMA transfer is setup. enable_hlt is called
> when a transfer stops/is cancled etc...

Yes this deals with some errata cases

> Does such thing makes sense for IDE DMA-transfers too? 
> (Maybe I've missed something)

Only for the CS5510 Cyrix as far as I know, and I really ought to fix
that in the new libata driver.

Generally speaking hlt is good, it takes the CPU off the bus and frees
it up for the other users.

