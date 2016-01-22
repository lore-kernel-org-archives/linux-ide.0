From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 22 Jan 2016 11:13:16 +0000
Message-ID: <yw1xsi1pn9yr.fsf@unicorn.mansr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54080 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbcAVLNY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jan 2016 06:13:24 -0500
In-Reply-To: <1453457080.2521.179.camel@linux.intel.com> (Andy Shevchenko's
	message of "Fri, 22 Jan 2016 12:04:40 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Wed, 2016-01-20 at 20:07 +0000, M=E5ns Rullg=E5rd wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>=20
>> > > > > > One comment still regarding to lli types. We can avoid
>> > > > > > warnings by
>> > > > > > using (__force u32) in macros.
>> > > > >=20
>> > > > > But that won't give the benefits of having the types checked=
=2E
>> > > >=20
>> > > > You mean if we access the lli->field directly? I didn't quite
>> > > > get what
>> > > > use case you are keeping in mind.
>> > >=20
>> > > Yes, accessing any of those fields directly with my patch gives =
a
>> > > sparse
>> > > warning.=A0=A0It's situations like these those checks are intend=
ed
>> > > for.
>> > > Defeating them seems foolish to me.
>> >=20
>> > Otherwise it makes that struct looks ugly.
>> > Why not union, though it still ugly, but less.
>>=20
>> What's so ugly about it?=A0=A0IMO data should be declared as the typ=
e it
>> actually is, and here we have fields that might have a different byt=
e
>> order from the host CPU.=A0=A0The __be32 and __le32 types were inven=
ted
>> to
>> make such situations clear and allow automatic (sparse)
>> checking.=A0=A0I'd
>> say the price of one small typedef is well worth it.=A0=A0The actual=
 code
>> is
>> not impacted since it must use the accessor macros anyhow.
>
> Okay, let's move with current state.
>
> I have few style minors and a question.
>
> So, in type definitions can we use __dw32 instead of dw_u32?

Sure, no problem.

> In=A0DWC_DEFAULT_CTLLO() can we do tab indentation for \ ?

Is there a wrong indentation somewhere?  I don't see it.

> Now the question: who do you prefer to submit the series (dw_dmac)? M=
e
> or you?
>
> In case you would like to do it (what I see in your dwc-sata branch
> today):
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'll fix the above, give your changes a review, and add my sign-off
before sending the series, today or during the weekend.

--=20
M=E5ns Rullg=E5rd
