From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Wed, 20 Jan 2016 20:07:00 +0000
Message-ID: <yw1xh9i8ow0r.fsf@unicorn.mansr.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50473 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbcATUHE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2016 15:07:04 -0500
In-Reply-To: <CAHp75Vftz_dAEDdG8yar==BB2spBpGozqf6UNpEDr-196J9xhg@mail.gmail.com>
	(Andy Shevchenko's message of "Wed, 20 Jan 2016 21:51:21 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Jan 20, 2016 at 9:46 PM, M=E5ns Rullg=E5rd <mans@mansr.com> w=
rote:
>
>>>>> One comment still regarding to lli types. We can avoid warnings b=
y
>>>>> using (__force u32) in macros.
>>>>
>>>> But that won't give the benefits of having the types checked.
>>>
>>> You mean if we access the lli->field directly? I didn't quite get w=
hat
>>> use case you are keeping in mind.
>>
>> Yes, accessing any of those fields directly with my patch gives a sp=
arse
>> warning.  It's situations like these those checks are intended for.
>> Defeating them seems foolish to me.
>
> Otherwise it makes that struct looks ugly.
> Why not union, though it still ugly, but less.

What's so ugly about it?  IMO data should be declared as the type it
actually is, and here we have fields that might have a different byte
order from the host CPU.  The __be32 and __le32 types were invented to
make such situations clear and allow automatic (sparse) checking.  I'd
say the price of one small typedef is well worth it.  The actual code i=
s
not impacted since it must use the accessor macros anyhow.

--=20
M=E5ns Rullg=E5rd
