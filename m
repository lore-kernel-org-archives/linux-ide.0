From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Wed, 20 Jan 2016 21:38:28 +0200
Message-ID: <CAHp75Vc__QXa=HE1Zw5yJut_sVEUs88tYTdeNxFnOVvBmB24rw@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1xegei893o.fsf@unicorn.mansr.com>
	<5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com>
	<5676E906.1060603@candw.ms>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:35721 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbcATTi3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2016 14:38:29 -0500
In-Reply-To: <yw1xpowwoy08.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Julian Margetson <runaway@candw.ms>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jan 20, 2016 at 9:24 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
>> On Wed, 2016-01-20 at 18:50 +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>
>>> > > Tested on AVR32 (DMA driver) and Sigma SMP8642 (SATA driver).
>>> > >
>>> > > Code here:
>>> > > https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata
>>> >
>>> > Thanks for testing!
>>>
>>> Have you had time to look any more at these patches?
>>
>> Not yet.
>> I will look soon for sure.
>>
>> One comment still regarding to lli types. We can avoid warnings by
>> using (__force u32) in macros.
>
> But that won't give the benefits of having the types checked.

You mean if we access the lli->field directly? I didn't quite get what
use case you are keeping in mind.

--=20
With Best Regards,
Andy Shevchenko
