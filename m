From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4] ata: Remove depends on HAS_DMA in case of platform dependency
Date: Mon, 2 Jul 2018 22:04:43 +0200
Message-ID: <CAMuHMdW1JiW=AGeXp+dVVdaLo3JXCR4rn9UC84qQWt7E1BvQ+w@mail.gmail.com>
References: <20180622110307.31523-1-geert@linux-m68k.org> <20180702161248.GG533219@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702161248.GG533219@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Tejun,

On Mon, Jul 2, 2018 at 6:12 PM Tejun Heo <tj@kernel.org> wrote:
> On Fri, Jun 22, 2018 at 01:03:07PM +0200, Geert Uytterhoeven wrote:
> > Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
> > symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
> > In most cases this other symbol is an architecture or platform specific
> > symbol, or PCI.
> >
> > Generic symbols and drivers without platform dependencies keep their
> > dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
> > cannot work anyway.
> >
> > This simplifies the dependencies, and allows to improve compile-testing.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Acked-by: Robin Murphy <robin.murphy@arm.com>
>
> This looks fine to me but how do you wanna route it?  Should I apply
> it to for-4.18-fixes or should it go with arch changes in some other
> tree?

Please queue it in the ata tree. There are no related arch changes.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
