From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/28 v6] m68k: Convert to genirq
Date: Thu, 20 Oct 2011 14:18:56 +0200
Message-ID: <CAMuHMdWOhKcoDoyTnKJzruZ=gpV5uKNFpXnGCkrac7oEkCihJw@mail.gmail.com>
References: <1315742394-16036-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315742394-16036-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-m68k@lists.linux-m68k.org
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Sun, Sep 11, 2011 at 13:59, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> This patch series converts the m68k/mmu (nommu was converted before)
> architecture to the generic hardirq framework.
>
> =C2=A0- [01/28] genirq: Add missing "else" in irq_shutdown()
> =C2=A0- [02/28] ide-{cd,floppy,tape}: Do not include <linux/irq.>
> =C2=A0- [03/28] keyboard: Do not include <linux/irq.>
> =C2=A0- [04/28] m68k/irq: Rename irq_controller to irq_chip
> =C2=A0- [05/28] m68k/irq: Kill irq_node_t typedef, always use struct =
irq_node
> =C2=A0- [06/28] m68k/irq: Rename irq_node to irq_data
> =C2=A0- [07/28] m68k/irq: Switch irq_chip methods to "struct irq_data=
 *data"
> =C2=A0- [08/28] m68k/irq: Rename setup_irq() to m68k_setup_irq() and =
make it static
> =C2=A0- [09/28] m68k/irq: Extract irq_set_chip()
> =C2=A0- [10/28] m68k/irq: Add m68k_setup_irq_controller()
> =C2=A0- [11/28] m68k/irq: Rename {,__}m68k_handle_int()
> =C2=A0- [12/28] m68k/irq: Remove obsolete IRQ_FLG_* definitions and u=
sers
> =C2=A0- [13/28] m68k/irq: Add genirq support
> =C2=A0- [14/28] m68k/atari: Convert Atari to genirq
> =C2=A0- [15/28] m68k/atari: Remove code and comments about different =
irq types
> =C2=A0- [16/28] m68k/amiga: Refactor amiints.c
> =C2=A0- [17/28] m68k/amiga: Convert Amiga to genirq
> =C2=A0- [18/28] m68k/amiga: Optimize interrupts using chain handlers
> =C2=A0- [19/28] m68k/mac: Convert Mac to genirq
> =C2=A0- [20/28] m68k/mac: Optimize interrupts using chain handlers
> =C2=A0- [21/28] m68k/hp300: Convert HP9000/300 and HP9000/400 to geni=
rq
> =C2=A0- [22/28] m68k/vme: Convert VME to genirq
> =C2=A0- [23/28] m68k/apollo: Convert Apollo to genirq
> =C2=A0- [24/28] m68k/sun3: Use the kstat_irqs_cpu() wrapper
> =C2=A0- [25/28] m68k/sun3: Convert Sun3/3x to genirq
> =C2=A0- [26/28] m68k/q40: Convert Q40/Q60 to genirq
> =C2=A0- [27/28] m68k/irq: Remove obsolete m68k irq framework
> =C2=A0- [28/28] m68k/irq: Remove obsolete support for user vector int=
errupt fixups
>
> Overview:
> =C2=A0- [01] is a fix for the core genirq code,

This went into v3.1-rc6.

> =C2=A0- [02-03] are fixes to avoid compile problems later in the conv=
ersion
> =C2=A0 =C2=A0process,

The keyboard path went into the tty -next tree.
The IDE one is still pending (I've just resent it).

> =C2=A0- [04-12] refactor the current m68k irq framework to match the =
generic
> =C2=A0 =C2=A0hardirq framework more closely w.r.t. to its (platform) =
users,
> =C2=A0- [13] adds generic hardirq support to the core, which can be e=
nabled through
> =C2=A0 =C2=A0a config option, so both legacy and generic hardirq can =
coexist at the
> =C2=A0 =C2=A0source level during the migration,
> =C2=A0- [14-26] convert the individual platforms to use generic hardi=
rqs,
> =C2=A0- [27] removes support for the legacy m68k irq framework,
> =C2=A0- [28] removes a now unused feature.
>
> The code has received some testing on Amiga, Atari (mainly ARAnyM), a=
nd Mac.
> There are some known issues with drivers, which Finn and Michael are =
looking
> into.

Any fixes I still have to apply?

> I will update my m68k-genirq branch as soon as master.kernel.org is a=
vailable
> again.

Updated, on top of m68k master (which is at v3.1-rc10 now).
http://git.kernel.org/?p=3Dlinux/kernel/git/geert/linux-m68k.git;a=3Dsh=
ortlog;h=3Drefs/heads/m68k-genirq

If noone objects, I'd like to add this to the m68k master and for-3.2 b=
ranches.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
