From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] ata: add m68k/Atari Falcon PATA support
Date: Thu, 26 Jan 2017 10:03:32 +0100
Message-ID: <CAMuHMdW9CgZNdq9rDY4EgJNXEzxSLZESqnSRHEU_Zy2u4hon1A@mail.gmail.com>
References: <CGME20161230140139epcas5p160eda5a6a77be084e21f12002c85cc2a@epcas5p1.samsung.com>
 <1483106478-1382-1-git-send-email-b.zolnierkie@samsung.com>
 <CAOmrzkJP6s34DPOHd4OFFx=CXko35Kt=CfeDZthOPvKDJy-9YA@mail.gmail.com>
 <3939493.HXZ6C33pKV@amdc3058> <CAOmrzkJfQu6PuCpyyRJL8PNvSYxYO42F-k8jEYf2d1-5C28A_A@mail.gmail.com>
 <alpine.LNX.2.00.1701111053340.22260@nippy.intranet> <c55cb48c-7200-9577-974b-3c080e141907@gmail.com>
 <alpine.LNX.2.00.1701151046500.352@nippy.intranet> <a637f52e-d70a-4b10-3998-9db5c2534d83@gmail.com>
 <alpine.LNX.2.00.1701151541230.7981@nippy.intranet> <b1b409e0-9243-83a6-8379-50f933c97477@gmail.com>
 <alpine.LNX.2.00.1701211805050.18276@nippy.intranet> <1585626b-5642-3e42-2d40-52fae49c9e59@gmail.com>
 <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1701261944160.23370@nippy.intranet>
Sender: linux-m68k-owner@vger.kernel.org
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Michael Schmitz <schmitzmic@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
List-Id: linux-ide@vger.kernel.org

Hi Finn,

On Thu, Jan 26, 2017 at 9:47 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> The difficulty will be arranging for disabled FDC & IDE interrupt sources
> during SCSI DMA, and disabled SCSI & IDE interrupt sources during FDC DMA.
> (Not all 5380 interrupts can be disabled; no idea about the IDE device or
> WD1772 FDC.)

IDE interrupts are disabled at the device level.
Unfortunately some hard drives (e.g. Western Digital Caviar) didn't honour
the ATA disable IRQ bit, so they caused an interrupt deadlock if you probed
for them on Amiga with the IDE interrupt enabled. The problem didn't show
up on PC because they had no shared interrupts, while on A4000 the IDE
interrupt is shared with Zorro Ethernet, which was still enabled.

That was fixed (in 1995 or 1996?) by disabling the IDE interrupt at the
IRQ controller level.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
