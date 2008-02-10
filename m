From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Subject: Re: 2.6.26-git0: IDE oops during boot
Date: Sun, 10 Feb 2008 13:32:58 -0800
Message-ID: <29495f1d0802101332p6b39b331ye2f6fb488b63e228@mail.gmail.com>
References: <20080206105334.GA3664@elf.ucw.cz>
	 <200802062105.42929.bzolnier@gmail.com>
	 <47AAD0CB.3090305@linux.vnet.ibm.com>
	 <200802071501.09318.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:56574 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYBJVdB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Feb 2008 16:33:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3578070fga.17
        for <linux-ide@vger.kernel.org>; Sun, 10 Feb 2008 13:32:59 -0800 (PST)
In-Reply-To: <200802071501.09318.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On 2/7/08, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
>
> On Thursday 07 February 2008, Kamalesh Babulal wrote:
> > Bartlomiej Zolnierkiewicz wrote:
> > > Hi,
> > >
> > > On Wednesday 06 February 2008, Pavel Machek wrote:
> > >> On Wed 2008-02-06 11:53:34, Pavel Machek wrote:
> > >>> Hi!
> > >>>
> > >>> Trying to boot 2.6.25-git0 (few days old), I get
> > >>>
> > >>> BUG: unable to handle kernel paging request at ffff..ffb0
> > >>> IP at init_irq+0x42e
> > >
> > > init_irq? hmm...
> > >
> > >>> Call trace:
> > >>> ide_device_add_all
> > >
> > > this comes from ide-generic
> > > (Generic IDE host driver)
> > >
> > >>> ide_generic_init
> > >>> kernel_init
> > >>> child_rip
> > >>> vgacon_cursor
> > >>> kernel_init
> > >>> child_rip
> > >>>
> > >>> Excerpt from config:
> > >>>
> > >>> CONFIG_IDE=y
> > >>> CONFIG_BLK_DEV_IDE=y
> > >> Disabling CONFIG_IDE made my machine boot, as it was using libata
> > >> anyway.
> > >
> > > Kamalesh/Pavel:
> > >
> > > Could you try latest git and see if the OOPS is still there?
> > >
> > > [ Yeah, I'm unable to reproduce it. :( ]
> > >
> > > Thanks,
> > > Bart
> > Hi Bart,
> >
> > The panic is reproducible with the 2.6.24-git16 kernel, the call trace is
> > similar to the previous one
>
> Thanks, I again reviewed ide-probe.c changes but nothing seems wrong...
>
> Could you please bisect it down to the guilty commit?

Kamalesh, were you able to bisect this down? I just got hit by the
same panic on a 4-way x86_64, with 2.6.24-git22.

Thanks,
Nish
