From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 19:27:11 +0000
Message-ID: <yw1xr3if4n74.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	<yw1x60zs7g40.fsf@unicorn.mansr.com>
	<1450724880.30729.250.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54597 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbbLUT1T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 14:27:19 -0500
In-Reply-To: <1450724880.30729.250.camel@linux.intel.com> (Andy Shevchenko's
	message of "Mon, 21 Dec 2015 21:08:00 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2015-12-21 at 01:19 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>=A0
>> > P.S. I also noticed that original driver enables interrupt per eac=
h
>> > block
>>=20
>> And then ignores all but the transfer complete interrupt.
>>=20
>> > and sets protection control bits.
>>=20
>> With no indication what the value it sets is supposed to mean.
>
> Okay, let's summarize what we have:
>
> 0. AR: Get a working reference for PPC 460EX SATA driver

Do we consider Julian's latest result working?

> 1. AR: Clear LLP_EN bits at the last block of LLP transfer

Patch sent.

> 2. AR: Rename masters to 'memory' and 'peripheral' and change them pe=
r
> DMA direction

Good idea.  I'd call them memory and device though to match existing
dmaengine nomenclature.

> 3. AR: Set LMS (LLP master) to 'memory' when do LLP transfers

I started working on a patch for that already.

> 4. CHECK: PROTCTL bit (documentation says that recommended value is
> 0x01)

Any idea what the value of 0x3 used by the old sata driver means?
Presumably that's decided by the bus.

> 5. CHECK: Other bits in CFG register (FIFO_MODE, FCMODE)
> 6. CHECK: Block interrupts vs. one interrupt at the end of block chai=
n
> (M=E5ns, I missed how any of them is ignored)

The interrupt handler looks at the StatusTfr and StatusErr registers an=
d
ignores StatusBlock.

> 7. AR: Test everything on Intel SoCs such as Baytrail, CherryTrail, e=
tc
> (SPI, UART, dmatest), AVR32 (MMC, dmatest), PPC 460EX (Onboard SATA)

I can test on AVR32.  That is as far as I know the only system I have
with this DMA engine.

> I can share my working branch with a set of patches regarding to
> dw_dmac. We may do our work based on that code and after I'll submit
> everything to upstream. Does it sound okay for you, guys?

I'm going away for the holidays, so I won't be able to do any serious
work on this until January, but I'll keep an eye on emails and may even
reply occasionally.  Before I go, I'll publish my patches so far
whatever shape they're in.

--=20
M=E5ns Rullg=E5rd
