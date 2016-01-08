From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 08 Jan 2016 10:57:44 +0200
Message-ID: <1452243464.30729.430.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	 <5675A84F.2070208@candw.ms> <yw1xio3u8dgc.fsf@unicorn.mansr.com>
	 <5675BB2F.6060107@candw.ms>
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
	 <yw1x37uv4a6l.fsf@unicorn.mansr.com>
	 <1450781890.30729.298.camel@linux.intel.com>
	 <yw1x4meq1xnx.fsf@unicorn.mansr.com>
	 <CAHp75VfVo+y3rwQzBaLmi4-ZemzYt2nP3eHr-fhwGf0Lzg08UQ@mail.gmail.com>
	 <1452159294.30729.405.camel@linux.intel.com>
	 <yw1xr3htz1dv.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:14872 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751700AbcAHI5z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jan 2016 03:57:55 -0500
In-Reply-To: <yw1xr3htz1dv.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2016-01-07 at 18:32 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:

> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>=20
> > On Wed, 2016-01-06 at 19:36 +0200, Andy Shevchenko wrote:
> > >=C2=A0
> > So, M=C3=A5ns, Julian, I just have published my repository containi=
ng
> > M=C3=A5ns'
> > and my patches regarding dw_dmac and sata_dwc_460ex drivers here
> >=20
> > https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fnext
>=20
> I've picked out the relevant changes from your branch and made some
> additional improvements.=C2=A0=C2=A0A few notes:
>=20
> - The __be32/__le32 typedefs for the DMA descriptor fields are
> necessary
> =C2=A0 to avoid a million sparse warnings (and sparse is correct to w=
arn).

Hmm=E2=80=A6 Which version of sparse are you using? I always run builds=
 with
sparse enabled and didn't see anything.

> - Using #ifdef CONFIG_AVR32 is a step back, IMO, since this driver
> may
> =C2=A0 well be used on another big endian system some day.=C2=A0=C2=A0=
The Kconfig
> logic
> =C2=A0 for selecting this option could perhaps be improved though.

Maybe runtime chosen accessors will be better than ifdefs?
I don't like the Kconfig option which limits application of the
(compiled) driver.

>=20
> Tested on AVR32 (DMA driver) and Sigma SMP8642 (SATA driver).
>=20
> Code here:
> https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata

Thanks for testing!

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

