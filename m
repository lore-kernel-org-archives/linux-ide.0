From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 22 Jan 2016 12:05:40 +0000
Message-ID: <yw1xk2n1n7jf.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	<1453463800.2521.189.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54245 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbcAVMFm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jan 2016 07:05:42 -0500
In-Reply-To: <1453463800.2521.189.camel@linux.intel.com> (Andy Shevchenko's
	message of "Fri, 22 Jan 2016 13:56:40 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Fri, 2016-01-22 at 11:13 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>> > On Wed, 2016-01-20 at 20:07 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> > In=C2=A0DWC_DEFAULT_CTLLO() can we do tab indentation for \ ?
>>=20
>> Is there a wrong indentation somewhere?=C2=A0=C2=A0I don't see it.
>
> My git diff shows this in particular:
>
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -45,10 +45,10 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0DW_DMA_MSIZE_16;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 _dmsize =3D _is_slave ? _sconfig->dst_max=
burst :=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0DW_DMA_MSIZE_16;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0\
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0u8 _dms =3D (_is_slave && _dwc->direction =3D=3D D=
MA_MEM_TO_DEV) ? \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_d=
wc->p_master : _dwc->m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0u8 _sms =3D (_is_slave && _dwc->direction =3D=3D D=
MA_DEV_TO_MEM) ? \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_d=
wc->p_master : _dwc->m_master;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0u8 _dms =3D (_is_slave && _dwc->direction =3D=3D D=
MA_MEM_TO_DEV) ?=C2=A0=C2=A0=C2=A0=C2=A0\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0_dwc->p_master : _dwc->m_master;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0u8 _sms =3D (_is_slave && _dwc->direction =3D=3D D=
MA_DEV_TO_MEM) ?=C2=A0=C2=A0=C2=A0=C2=A0\
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0_dwc->p_master : _dwc->m_master;=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
>
> Means in your case the ' \' is used, in mine =E2=80=94 '\t\' at the e=
nd of
> lines.

Oh, I see it now.  Two lines have a space rather than a tab since a tab
would push them over 80 columns.  Now those lines could be shortened by
simply dropping the "_is_slave" since this is necessarily true if the
other half of the && is.

>> Now the question: who do you prefer to submit the series (dw_dmac)?
>> > Me
>> > or you?
>> >=20
>> > In case you would like to do it (what I see in your dwc-sata branc=
h
>> > today):
>> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>=20
>> I'll fix the above, give your changes a review, and add my sign-off
>> before sending the series, today or during the weekend.
>
> OK.
>
> Just to be sure we are on the same page. I assume your dwc-sata branc=
h
> as for submitting.

Yes, I'm not aware of anything that needs to change in that branch.

--=20
M=C3=A5ns Rullg=C3=A5rd
