From: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: Can't disable IDE DMA on 2.6.0-test9 (patch)
Date: Mon, 8 Dec 2003 13:34:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <16339.58195.71921.425034@wombat.chubb.wattle.id.au>
References: <16317.18623.912339.111750@wombat.disy.cse.unsw.edu.au>
	<200312080239.58602.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200312080239.58602.bzolnier@elka.pw.edu.pl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

>>>>> "Bartlomiej" == Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

Bartlomiej> On Friday 21 of November 2003 00:05, Peter Chubb wrote:
>> Hi Folks,

Bartlomiej> Hi,

>> If you try to disable IDE DMA from Kconfig, you'll end up with an
>> undefined symbol, ide_hwif_setup_dma().
>> 
>> The attached rather ugly patch fixes the problem by defining a
>> dummy function.

Bartlomiej> Not exactly.  Disable IDE DMA and enable support for every
Bartlomiej> PCI chipset.  Now try to compile... welcome to compile
Bartlomiej> time hell :-).

If you disable IDE_DMA, then the other chipset drivers cannot be
enabled --- the config system won't let you.
With IDE_DMA disabled and all chipsets disabled, I see:

drivers/built-in.o(.text+0x9f8bc): In function `ide_hwif_setup_dma':
: undefined reference to `ide_setup_dma'

And *that's* what my patch was supposed to fix.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
