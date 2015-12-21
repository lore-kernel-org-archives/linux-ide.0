From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 22:54:49 +0200
Message-ID: <1450731289.30729.282.camel@linux.intel.com>
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
	 <yw1xr3if4n74.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:32187 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbLUUyc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 15:54:32 -0500
In-Reply-To: <yw1xr3if4n74.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-12-21 at 19:27 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>=20
> > On Mon, 2015-12-21 at 01:19 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > > =C2=A0
> > > > P.S. I also noticed that original driver enables interrupt per
> > > > each
> > > > block
> > >=20
> > > And then ignores all but the transfer complete interrupt.
> > >=20
> > > > and sets protection control bits.
> > >=20
> > > With no indication what the value it sets is supposed to mean.
> >=20
> > Okay, let's summarize what we have:
> >=20
> > 0. AR: Get a working reference for PPC 460EX SATA driver
>=20
> Do we consider Julian's latest result working?

I think so.

>=20
> > 1. AR: Clear LLP_EN bits at the last block of LLP transfer
>=20
> Patch sent.

Acked.

>=20
> > 2. AR: Rename masters to 'memory' and 'peripheral' and change them
> > per
> > DMA direction
>=20
> Good idea.=C2=A0=C2=A0I'd call them memory and device though to match=
 existing
> dmaengine nomenclature.

I remember how I called in my patch. So, there is no problem to rename,
but will see.

>=20
> > 3. AR: Set LMS (LLP master) to 'memory' when do LLP transfers
>=20
> I started working on a patch for that already.

Thanks.

>=20
> > 4. CHECK: PROTCTL bit (documentation says that recommended value is
> > 0x01)
>=20
> Any idea what the value of 0x3 used by the old sata driver means?
> Presumably that's decided by the bus.

Nope, documentation says that it is direct representation of hprot[3:1]
wires on the master interface. Also it refers to AMBA spec, so, if you
have access to AMBA spec I think we might get it from there.

>=20
> > 5. CHECK: Other bits in CFG register (FIFO_MODE, FCMODE)
> > 6. CHECK: Block interrupts vs. one interrupt at the end of block
> > chain
> > (M=C3=A5ns, I missed how any of them is ignored)
>=20
> The interrupt handler looks at the StatusTfr and StatusErr registers
> and
> ignores StatusBlock.

I have to refresh my memory, since BLOCK interrupts should be enabled
(unmasked) separately. I have forgotten which type of interrupt is
generated in this case, BLOCK, or XFER after each block, or only one
XFER at the last block (LLP.LOC =3D 0) and BLOCK are ignored. So, will
check later.

>=20
> > 7. AR: Test everything on Intel SoCs such as Baytrail, CherryTrail,
> > etc
> > (SPI, UART, dmatest), AVR32 (MMC, dmatest), PPC 460EX (Onboard
> > SATA)
>=20
> I can test on AVR32.=C2=A0=C2=A0That is as far as I know the only sys=
tem I have
> with this DMA engine.

If you have Intel Haswell, BayTrail, Braswell, CherryTrail, Broadwell,
you have it as well as long you have LPSS block there. (Most of them
are Atoms).

>=20
> > I can share my working branch with a set of patches regarding to
> > dw_dmac. We may do our work based on that code and after I'll
> > submit
> > everything to upstream. Does it sound okay for you, guys?
>=20
> I'm going away for the holidays, so I won't be able to do any serious
> work on this until January, but I'll keep an eye on emails and may
> even
> reply occasionally.=C2=A0=C2=A0Before I go, I'll publish my patches s=
o far
> whatever shape they're in.

Okay, thanks! I will include them in my branch which I'm going to
publish on GitHUB.

Happy holidays!

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

