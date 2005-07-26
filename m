From: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Subject: Re: libata and sata_promise errors when using multiple disks on the same controller simultaneously
Date: Mon, 25 Jul 2005 22:01:39 -0400
Message-ID: <fab4e42a050725190163ddb605@mail.gmail.com>
References: <4789af9e050705111263cc6f7b@mail.gmail.com>
	 <4789af9e0507151233235ee42@mail.gmail.com>
	 <fab4e42a05072410043f0ccfd5@mail.gmail.com>
Reply-To: Jarrod Johnson <jarrod.b.johnson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.192]:15446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261545AbVGZCBj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Jul 2005 22:01:39 -0400
Received: by wproxy.gmail.com with SMTP id i2so1045449wra
        for <linux-ide@vger.kernel.org>; Mon, 25 Jul 2005 19:01:39 -0700 (PDT)
In-Reply-To: <fab4e42a05072410043f0ccfd5@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Anyone have suggestions as to how to implement a semaphore/lock as
described?  I've been trying to use my PDC20579 controller for a while
and just want to use it, even if significantly slowly, reliably.  I
tried a few things, but I'm admittedly a very inexperiencied kernel
hacker, and particularly the thought of some lock to span the context
of an IO request and answering DMA seems to not be a commonly
addressed issue.  My attempts all ended in deadlock, not locking
anything at all, and/or throwing 'scheduling while atomic' messages on
every I/O request, while still not preventing the condition.  Unless
someone seems to have a proper solution, I'd like to know a quick hack
to keep me going with this array in the interim.

> On 7/15/05, Jim Ramsay  wrote:
> > I have further characterized the error.  It looks like, at least
> > during the softraid rebuild process, most DMA commands are sent to the
> > PCI card and then complete via an IRQ callback before the next command
> > is sent.  However, the problem I see here sometimes occurrs when:
> >
> > - Command for drive 1 is sent to the PCI card via DMA
> > (sata_promise.c:pdc_packet_start)
> > - Command for drive 2 is sent to the PCI card via DMA before the
> > previous command completes
> > - Command for drive 1 completes (sata_promise.c:pdc_host_intr)
> >
> > Often the command for drive 2 will now timeout.
> >
> > Now, I have seen the case when this above scenario will actually
> > complete successfully, either with a second IRQ just for the drive2
> > command, or sometimes with a single IRQ which completes both commands.
> >
> > I have a workaround using a semaphore which causes all commands to
> > strictly serialize, (lock it in pdc_packet_start, unlock in
> > pdc_host_intr) thereby not allowing any concurrent commands, but this
> > appears to have a large performance impact.  At least it allows me to
> > actually cause my softraid device to finish syncing to 100%.
> >
> > I'm looking for other solutions, or a clue as to the actual cause of
> > the error.  My current theory is that if the second command is sent to
> > the PCI via DMA too soon, it may be overlooked, so some rate-limiting
> > may be useful, if I can figure out how to implement it.
> >
> > Any comments or suggestions here would be greatly appreciated, thanks!
> >
> > --
> > Jim Ramsay
> > "Me fail English?  That's unpossible!"
> >
>
