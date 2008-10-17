From: Michael Schmitz <schmitz@biophys.uni-duesseldorf.de>
Subject: Re: [RFC PATCH] falconide: remove needless ST-DMA locking
Date: Sat, 18 Oct 2008 00:32:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810180023010.22248@zirkon.biophys.uni-duesseldorf.de>
References: <200810172041.17191.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-m68k-owner@vger.kernel.org>
In-reply-to: <200810172041.17191.bzolnier@gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Stephen R Marenka <stephen@marenka.net>
List-Id: linux-ide@vger.kernel.org

Hi Bartlomiej,

> While working on ide_do_request() improvements I stumbled upon
> mismatched ide_get_lock() / ide_release_lock() calls.
>
> [ It seems to be known issue:
>  http://marc.info/?l=linux-m68k&m=121423752829622&w=2 ]

It is a known issue, and I submitted a simple fix to Geert a month or so ago. It 
involves moving the ide_get_lock call inside the request loop instead of doing 
it once at the start of the function.

> I may be completely wrong but how's about the following patch?

You are, indeed .

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [RFC PATCH] falconide: remove needless ST-DMA locking
>
> According to comments in arch/m68k/atari/stdma.c IDE controller on
> Atari Falcon doesn't use ST-DMA chip itself and no locking is needed
> (both ST-DMA and IDE IRQ handlers are registered with IRQF_SHARED).

The IDE controller does not use the DMA chip, but it does use the same
interrupt vector as floppy controller, SCSI controller and DMA do. SCSI, as well 
as floppy do shart DMA. From what I recall, it is not possible to figure out if 
the interrupt was a DMA complete from the DMA chip state. That's basically whi 
we need to reserve DMA and interrupt for exclusive use of a single driver a a 
time.

> * Remove code for locking ST-DMA from <asm-m68k/ide.h>
>  and falconide.c.
>
> * Remove ide_{get,release}_lock() from ide_do_request()
>  (it was broken anyway).
>
> * Remove #ifndef IDE_ARCH_LOCK handling from <linux/ide.h>.
>
> This patch should fix "ide_release_lock: bug" errors reported
> by Stephen R Marenka.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Michael Schmitz <schmitz@debian.org>
> Cc: Stephen R Marenka <stephen@marenka.net>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Objected: Michael Schmitz <schmitz@debian.org>

Do not apply, please.

 	Michael

