From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 22 Jan 2016 12:04:40 +0200
Message-ID: <1453457080.2521.179.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <yw1xpoy16jlt.fsf@unicorn.mansr.com>
	 <CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	 <CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	 <yw1x60zs7g40.fsf@unicorn.mansr.com>
	 <1450724880.30729.250.camel@linux.intel.com>
	 <yw1xr3if4n74.fsf@unicorn.mansr.com>
	 <1450731289.30729.282.camel@linux.intel.com>
	 <yw1x37uv4a6l.fsf@unicorn.mansr.com>
	 <1450781890.30729.298.camel@linux.intel.com>
	 <yw1x4meq1xnx.fsf@unicorn.mansr.com>
	 <CAHp75VfVo+y3rwQzBaLmi4-ZemzYt2nP3eHr-fhwGf0Lzg08UQ@mail.gmail.com>
	 <1452159294.30729.405.camel@linux.intel.com>
	 <yw1xr3htz1dv.fsf@unicorn.mansr.com>
	 <1452243464.30729.430.camel@linux.intel.com>
	 <yw1xwpr4ozjq.fsf@unicorn.mansr.com>
	 <1453317808.2521.135.camel@linux.intel.com>
	 <yw1xpowwoy08.fsf@unicorn.mansr.com>
	 <CAHp75Vc__QXa=HE1Zw5yJut_sVEUs88tYTdeNxFnOVvBmB24rw@mail.gmail.com>
	 <yw1xlh7kowyo.fsf@unicorn.mansr.com>
	 <CAHp75Vftz_dAEDdG8yar==BB2spBpGozqf6UNpEDr-196J9xhg@mail.gmail.com>
	 <yw1xh9i8ow0r.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:35066 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbcAVKEL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 05:04:11 -0500
In-Reply-To: <yw1xh9i8ow0r.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2016-01-20 at 20:07 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>=20
> > > > > > One comment still regarding to lli types. We can avoid
> > > > > > warnings by
> > > > > > using (__force u32) in macros.
> > > > >=20
> > > > > But that won't give the benefits of having the types checked.
> > > >=20
> > > > You mean if we access the lli->field directly? I didn't quite
> > > > get what
> > > > use case you are keeping in mind.
> > >=20
> > > Yes, accessing any of those fields directly with my patch gives a
> > > sparse
> > > warning.=C2=A0=C2=A0It's situations like these those checks are i=
ntended
> > > for.
> > > Defeating them seems foolish to me.
> >=20
> > Otherwise it makes that struct looks ugly.
> > Why not union, though it still ugly, but less.
>=20
> What's so ugly about it?=C2=A0=C2=A0IMO data should be declared as th=
e type it
> actually is, and here we have fields that might have a different byte
> order from the host CPU.=C2=A0=C2=A0The __be32 and __le32 types were =
invented
> to
> make such situations clear and allow automatic (sparse)
> checking.=C2=A0=C2=A0I'd
> say the price of one small typedef is well worth it.=C2=A0=C2=A0The a=
ctual code
> is
> not impacted since it must use the accessor macros anyhow.

Okay, let's move with current state.

I have few style minors and a question.

So, in type definitions can we use __dw32 instead of dw_u32?
In=C2=A0DWC_DEFAULT_CTLLO() can we do tab indentation for \ ?

Now the question: who do you prefer to submit the series (dw_dmac)? Me
or you?

In case you would like to do it (what I see in your dwc-sata branch
today):
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

