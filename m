From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m68k: Atari - leave out spurious request_irq for Falcon
	IDE
Date: Tue, 28 Apr 2009 09:27:09 +0200
Message-ID: <10f740e80904280027m307f5850u5373d80b0dfcb7f@mail.gmail.com>
References: <20090326123822.GD8081@marenka.net>
	 <alpine.DEB.1.00.0904160107540.4339@zirkon.biophys.uni-duesseldorf.de>
	 <1239862075.12777.14.camel@petr>
	 <alpine.DEB.1.00.0904160934480.19859@zirkon.biophys.uni-duesseldorf.de>
	 <1239868903.12777.25.camel@petr>
	 <alpine.DEB.1.00.0904170314220.18855@zirkon.biophys.uni-duesseldorf.de>
	 <alpine.DEB.1.00.0904190308310.8939@zirkon.biophys.uni-duesseldorf.de>
	 <alpine.DEB.1.00.0904260751590.30061@zirkon.biophys.uni-duesseldorf.de>
	 <alpine.DEB.1.00.0904260909510.32441@zirkon.biophys.uni-duesseldorf.de>
	 <alpine.DEB.1.00.0904280735550.18935@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.1.00.0904280735550.18935@zirkon.biophys.uni-duesseldorf.de>
Sender: linux-m68k-owner@vger.kernel.org
To: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Stephen R Marenka <stephen@marenka.net>, debian-68k@lists.debian.org, linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 28, 2009 at 07:41, Michael Schmitz
<schmitz@biophys.uni-duesseldorf.de> wrote:
> I found I need to have this patch in order to avoid doubly registerin=
g the
> ST-DMA interrupt for IDE on Falcon.

But further it has no ill effects, as it works fine on ARAnyM? Or does
it fail on real hardware?

> The interrupt is registered in stdma_init and the current user of the=
 interrupt
> is set by stdma_get_lock. Without the lock held, no interrupt should =
be
> delivered anyway, so this patch will make it easier to debug locking =
problems.
>
> Signed-off-by: Michael Schmitz <schmitz@debian.org>
>
> ---
> =C2=A0drivers/ide/ide-probe.c | =C2=A0 =C2=A03 +++
> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
> index 7f264ed..f8a86b7 100644
> --- a/drivers/ide/ide-probe.c
> +++ b/drivers/ide/ide-probe.c
> @@ -843,6 +843,9 @@ static int init_irq (ide_hwif_t *hwif)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (io_ports->ctl_addr)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hwif->tp_ops->=
write_devctl(hwif, ATA_DEVCTL_OBS);
>
> +#if defined(__mc68000__) && defined (CONFIG_BLK_DEV_FALCON_IDE)
> + =C2=A0 =C2=A0 =C2=A0 if (!MACH_IS_ATARI)
> +#endif
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (request_irq(hwif->irq, irq_handler, sa=
, hwif->name, hwif))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_up;

Ugh, adding an m68k dependency in generic code is not nice...
Would it work to add a generic test for hwif->irq, and set hwif->irq to=
 zero in
falconide.c?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-m68k" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
