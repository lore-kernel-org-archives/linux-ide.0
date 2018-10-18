From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] ata: add Buddha PATA controller driver
Date: Thu, 18 Oct 2018 16:03:19 +0200
Message-ID: <CAMuHMdVe1KgQWYZ_BfBkSo3zr0c+TenLMEw3T=BLEQNoZ6ex7A@mail.gmail.com>
References: <CGME20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457@eucas1p2.samsung.com>
 <20181018122951eucas1p2be43dc17df8d2c754e771785b3ad7457~es8dn4Tg90035600356eucas1p2H@eucas1p2.samsung.com>
 <20181018124118.GA10376@infradead.org> <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018131210eucas1p14a11ec7555ca9ef3003387f1985326e6~ethZ7giWB0310803108eucas1p1X@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Christoph Hellwig <hch@infradead.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Schmitz <schmitzmic@gmail.com>, Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej, Christoph,

On Thu, Oct 18, 2018 at 3:12 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 10/18/2018 02:41 PM, Christoph Hellwig wrote:
> >> +static int __init pata_buddha_init_one(void)
> >> +{
> >> +    struct zorro_dev *z = NULL;
> >> +
> >> +    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
> >
> > I'm not really an m68k expert, but shouldn't this implement a
> > struct zorro_driver instead?  (or maybe two of them as xsurf
> > seems sufficiently different).
>
> I didn't want to introduce too many changes over old IDE's
> driver in the initial version of the libata driver as
> I can't test them myself. Once the new driver is verified
> to work I plan to convert it into proper Zorro_driver.

Unfortunately that conversion cannot happen right now, as zorro8390.c
already binds against the X-Surf zorro device.

I think the proper solution would be to start using MFD for multi-function
Zorro devices, cfr. the work I started years ago, but never completed
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd

Then the Buddha MFD driver can instantiate 2 Buddha IDE cells, the
Catweasel MFD driver can instantiate 3 Buddha IDE cells and a Catweasel
floppy cell, and the X-Surf MFD driver can instantiate 2 Buddha IDE
cells and a zorro8390 cell.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
