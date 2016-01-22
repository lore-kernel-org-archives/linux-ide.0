From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 22 Jan 2016 13:56:40 +0200
Message-ID: <1453463800.2521.189.camel@linux.intel.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	 <1453457080.2521.179.camel@linux.intel.com>
	 <yw1xsi1pn9yr.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26619 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383AbcAVL6S (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 06:58:18 -0500
In-Reply-To: <yw1xsi1pn9yr.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2016-01-22 at 11:13 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Wed, 2016-01-20 at 20:07 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> > In=C2=A0DWC_DEFAULT_CTLLO() can we do tab indentation for \ ?
>=20
> Is there a wrong indentation somewhere?=C2=A0=C2=A0I don't see it.

My git diff shows this in particular:

--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -45,10 +45,10 @@
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
DW_DMA_MSIZE_16;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0u8 _dmsize =3D _is_slave ? _sconfig->dst_maxbur=
st
:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
DW_DMA_MSIZE_16;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0\
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0u8 _dms =3D (_is_slave && _dwc->direction =3D=3D
DMA_MEM_TO_DEV) ? \
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_dwc-=
>p_master : _dwc-
>m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0u8 _sms =3D (_is_slave && _dwc->direction =3D=3D
DMA_DEV_TO_MEM) ? \
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_dwc-=
>p_master : _dwc-
>m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0u8 _dms =3D (_is_slave && _dwc->direction =3D=3D
DMA_MEM_TO_DEV) ?=C2=A0=C2=A0=C2=A0=C2=A0\
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0_dwc->p_master : _dwc-
>m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0u8 _sms =3D (_is_slave && _dwc->direction =3D=3D
DMA_DEV_TO_MEM) ?=C2=A0=C2=A0=C2=A0=C2=A0\
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0_dwc->p_master : _dwc-
>m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\

Means in your case the ' \' is used, in mine =E2=80=94 '\t\' at the end=
 of
lines.

> Now the question: who do you prefer to submit the series (dw_dmac)?
> > Me
> > or you?
> >=20
> > In case you would like to do it (what I see in your dwc-sata branch
> > today):
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> I'll fix the above, give your changes a review, and add my sign-off
> before sending the series, today or during the weekend.

OK.

Just to be sure we are on the same page. I assume your dwc-sata branch
as for submitting.

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

