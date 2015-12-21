From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 21:06:23 +0000
Message-ID: <yw1xa8p34ils.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x60zua1ld.fsf@unicorn.mansr.com>
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
	<1450731289.30729.282.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:55111 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbbLUVG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 16:06:26 -0500
In-Reply-To: <1450731289.30729.282.camel@linux.intel.com> (Andy Shevchenko's
	message of "Mon, 21 Dec 2015 22:54:49 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

>> > 4. CHECK: PROTCTL bit (documentation says that recommended value i=
s
>> > 0x01)
>>=20
>> Any idea what the value of 0x3 used by the old sata driver means?
>> Presumably that's decided by the bus.
>
> Nope, documentation says that it is direct representation of hprot[3:=
1]
> wires on the master interface. Also it refers to AMBA spec, so, if yo=
u
> have access to AMBA spec I think we might get it from there.

That's assuming AMCC didn't change something.

>> > 5. CHECK: Other bits in CFG register (FIFO_MODE, FCMODE)
>> > 6. CHECK: Block interrupts vs. one interrupt at the end of block
>> > chain
>> > (M=E5ns, I missed how any of them is ignored)
>>=20
>> The interrupt handler looks at the StatusTfr and StatusErr registers
>> and ignores StatusBlock.
>
> I have to refresh my memory, since BLOCK interrupts should be enabled
> (unmasked) separately. I have forgotten which type of interrupt is
> generated in this case, BLOCK, or XFER after each block, or only one
> XFER at the last block (LLP.LOC =3D 0) and BLOCK are ignored. So, wil=
l
> check later.

I interpreted the, admittedly a bit vague, documentation as meaning
BLOCK interrupts are signalled after each block and XFER interrupts
after the last block.

>> > 7. AR: Test everything on Intel SoCs such as Baytrail, CherryTrail=
,
>> > etc (SPI, UART, dmatest), AVR32 (MMC, dmatest), PPC 460EX (Onboard
>> > SATA)
>>=20
>> I can test on AVR32.=A0=A0That is as far as I know the only system I=
 have
>> with this DMA engine.
>
> If you have Intel Haswell, BayTrail, Braswell, CherryTrail, Broadwell=
,
> you have it as well as long you have LPSS block there. (Most of them
> are Atoms).

I don't have any of those (or any Atom hardware).

--=20
M=E5ns Rullg=E5rd
