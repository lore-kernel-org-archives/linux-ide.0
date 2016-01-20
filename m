From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Wed, 20 Jan 2016 19:46:39 +0000
Message-ID: <yw1xlh7kowyo.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	<1452243464.30729.430.camel@linux.intel.com>
	<yw1xwpr4ozjq.fsf@unicorn.mansr.com>
	<1453317808.2521.135.camel@linux.intel.com>
	<yw1xpowwoy08.fsf@unicorn.mansr.com>
	<CAHp75Vc__QXa=HE1Zw5yJut_sVEUs88tYTdeNxFnOVvBmB24rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vc__QXa=HE1Zw5yJut_sVEUs88tYTdeNxFnOVvBmB24rw@mail.gmail.com>
	(Andy Shevchenko's message of "Wed, 20 Jan 2016 21:38:28 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Wed, Jan 20, 2016 at 9:24 PM, M=E5ns Rullg=E5rd <mans@mansr.com> w=
rote:
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>
>>> On Wed, 2016-01-20 at 18:50 +0000, M=E5ns Rullg=E5rd wrote:
>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>>
>>>> > > Tested on AVR32 (DMA driver) and Sigma SMP8642 (SATA driver).
>>>> > >
>>>> > > Code here:
>>>> > > https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata
>>>> >
>>>> > Thanks for testing!
>>>>
>>>> Have you had time to look any more at these patches?
>>>
>>> Not yet.
>>> I will look soon for sure.
>>>
>>> One comment still regarding to lli types. We can avoid warnings by
>>> using (__force u32) in macros.
>>
>> But that won't give the benefits of having the types checked.
>
> You mean if we access the lli->field directly? I didn't quite get wha=
t
> use case you are keeping in mind.

Yes, accessing any of those fields directly with my patch gives a spars=
e
warning.  It's situations like these those checks are intended for.
Defeating them seems foolish to me.

--=20
M=E5ns Rullg=E5rd
