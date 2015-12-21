From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 21:23:33 +0200
Message-ID: <1450725813.30729.256.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	 <yw1xa8p47h3w.fsf@unicorn.mansr.com>
	 <CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
	 <yw1xwps8577f.fsf@unicorn.mansr.com>
	 <CAHp75Vcin1GXpYm-air5fV5B+jiMnB9hoByCqOvbDgd5pHRRJA@mail.gmail.com>
	 <yw1xd1tz650x.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:48434 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbbLUTZY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2015 14:25:24 -0500
In-Reply-To: <yw1xd1tz650x.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 2015-12-21 at 18:16 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>=20
> > On Mon, Dec 21, 2015 at 2:15 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mans=
r.com>
> > wrote:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > >=C2=A0
> > I used to have a patch to implement this in dw_dmac driver.
> > However, I
> > dropped it at some point. Seems we need it back and now I possible
> > have a good explanation why.
>=20
> Are you still able to find that patch?=C2=A0=C2=A0Shouldn't be too ha=
rd to do
> from
> scratch if not.

Yes, I found a version of it, let me mock up tomorrow something
working.

>=20
> > > If those values didn't matter, why would the fields exist in the
> > > first place?
> >=20
> > Because someone can have more than one AHB bus on the system and
> > connect DMA to all of them (up to 4).
>=20
> Which apparently these guys did.=C2=A0=C2=A0Well, not a full-blown AH=
B bus, but
> they seem to be using two master interfaces.

To different buses? Intel HW uses two masters and they are quite equal
(at least from OS point of view, it might be HW adjusts it).

>=20
> > > > In any case on all Intel SoCs and AVR32, and as far as I can
> > > > tell on
> > > > Spear13xx (Viresh?) there is not a case, that's why I hardly
> > > > imagine
> > > > that the problem is in master numbers by themselves.
> > >=20
> > > The 460EX is a PowerPC system.=C2=A0=C2=A0Expect unusual topologi=
es.
> >=20
> > Yeah, that's right.
>=20
> BTW, there's a good reason for wiring it like this.=C2=A0=C2=A0If the=
 source
> and
> destination are on different buses, the DMA engine can do a read and
> a
> write in each cycle.=C2=A0=C2=A0Otherwise the reads and writes have t=
o be
> issued
> alternately.

Okay. We need first to have a confirmation. I would try to set other
bits under question to see if it helps first (CFG register in DMA).

> Most likely nothing happens, but I think it ought to be
> > > > > fixed.=C2=A0=C2=A0In fact,
> > > > > I have a patch already.
> > > >=20
> > > > Good. Send with Fixes tag if it's upstream ready.
> > > >=20
> > > > > Come to think of it, I have an AVR32 dev somewhere.=C2=A0=C2=A0=
Maybe I
> > > > > should dust
> > > > > it off.
> > > >=20
> > > > I have ATNGW100.
> > >=20
> > > I have an AT32ATK1006.=C2=A0=C2=A0Can you suggest a good test to =
exercise
> > > the DMA
> > > engine?
> >=20
> > On that board I tried MMC (the only available user for me), though
> > it
> > is not reliable, I also tried the dmatest module.
>=20
> Hmm, is there anywhere this damn driver actually works?=C2=A0=C2=A0;-=
)

Yes, on Intel HW.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

