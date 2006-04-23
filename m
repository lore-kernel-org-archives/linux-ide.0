From: Hugh Dickins <hugh@veritas.com>
Subject: Re: sata suspend resume ...
Date: Sun, 23 Apr 2006 13:58:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0604231343010.2515@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
 <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com> <20060420134713.GA2360@ucw.cz>
 <Pine.LNX.4.64.0604211333050.4891@blonde.wat.veritas.com>
 <20060421163930.GA1648@elf.ucw.cz> <Pine.LNX.4.64.0604212108010.7531@blonde.wat.veritas.com>
 <4449504D.1040901@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gold.veritas.com ([143.127.12.110]:63879 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1751389AbWDWM6s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Apr 2006 08:58:48 -0400
Received: from [172.21.56.26]([172.21.56.26]) (3252 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1FXeAo-0001oQC@megami.veritas.com>
	for <linux-ide@vger.kernel.org>; Sun, 23 Apr 2006 05:58:46 -0700 (PDT)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
In-Reply-To: <4449504D.1040901@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Pavel Machek <pavel@suse.cz>, Arkadiusz Miskiewicz <arekm@maven.pl>, Jeff Chua <jeffchua@silk.corp.fedex.com>, Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thanks for taking a look, and replying in such detail, Jeff
(I'm afraid you overestimate my understanding of this area!)

On Fri, 21 Apr 2006, Jeff Garzik wrote:
> This is helpful to narrow down the problem, but its a bit of a layering
> violation.  In the current code, all functions called by
> ata_device_{suspend,resume}() are high level functions, which uses
> ata_qc_issue/ata_qc_complete high level API to address the device.

Ah, that's a pity.  I see what you mean.

> In contrast, ata_busy_sleep() sticks its hands deep into the host state
> machine, and gives the tree a good hard shake.  :)

Though that seems a considerable overstatement: ata_busy_sleep doesn't
shake anything, it just hangs around reading and testing a flag (in a
bewildering series of slightly different loops).  I guess even reading
status must be viewed as "a good hard shake" at this upper level.

> Consider that
> ata_busy_sleep() doesn't make sense for unusual cases like ATA-over-ethernet
> (AoE), or other tunnelled ATA transports.
> 
> It may very well be that ata_busy_sleep() is the proper solution for your
> hardware, but it isn't applicable to all hardware.

Can it do harm on any hardware to wait for ATA_BUSY to clear there?
Would it be less of a violation to do it in ata_scsi_device_resume?
Or should ata_piix.c have its own .resume to add this in?  Or....

> So you really want an ata_make_sure_bus_is_awake_and_working() called at that
> location.  ata_busy_sleep()'s purpose is to bring a PATA-like bus to the
> bus-idle state.  So, when working on suspend/resume, the software needs to
> have points at which the bus state is controlled/queried/asserted.

As you can see from my questions, I haven't a clue around here.  So for
now I'll just have to keep that ata_busy_sleep with the patches I apply
to my kernel, until someone with a clue makes it redundant.  And it is
now there in the LKML archives for those who find it useful.

Hugh
