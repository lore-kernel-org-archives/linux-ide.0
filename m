From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Incorrect device link for ide-cs
Date: Thu, 3 Nov 2005 11:59:39 +0100
Message-ID: <58cb370e0511030259i24580f3am9c2211f644fab99b@mail.gmail.com>
References: <4369D693.4040500@suse.de>
	 <58cb370e0511030157l5e47a15h25832fb98e46173a@mail.gmail.com>
	 <4369E4BF.4010706@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964887AbVKCK7o@vger.kernel.org>
In-Reply-To: <4369E4BF.4010706@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
List-Id: linux-ide@vger.kernel.org

On 11/3/05, Hannes Reinecke <hare@suse.de> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> >>      hw_regs_t hw;
> >>      memset(&hw, 0, sizeof(hw));
> >> -    ide_init_hwif_ports(&hw, io, ctl, NULL);
> >> +    ide_std_init_ports(&hw, io, ctl);
> >
> > Could you separate this into another patch?
> >
> > This change fixes ide-cs for some archs but OTOH we should verify that
> > there are no ide-cs specific hacks in ide_init_hwif_ports() on other archs.
> >
> Oops, you are correct. The main reason why I did this is this comment in
> include/linux/ide.h:
>  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
>
> Arch specific codes are in:
> cris/v10
> arm/sa1100
> arch-m68knommu

I'm more worried about indirect PPC32 hacks...

...
#ifdef CONFIG_PPC32
        if (ppc_ide_md.ide_init_hwif)
                ppc_ide_md.ide_init_hwif(hw, io_addr, ctl_addr, irq);
#endif
...

> Neither of which is using the irq parameter anyway, so it would make
> sense to remove that interface completely.
>
> Updated patch attached.

Thanks,
Bartlomiej
