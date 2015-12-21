From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Mon, 21 Dec 2015 18:25:31 +0000
Message-ID: <yw1x4mfb64mc.fsf@unicorn.mansr.com>
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
	<CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	<1450716497.30729.232.camel@linux.intel.com> <56783636.80901@candw.ms>
	<CAHp75VfQ6jWm+W1kHh-4zqV28wF4OCCrBfSX8jXxsEcEYSsw5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:54353 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751211AbbLUSZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 13:25:32 -0500
In-Reply-To: <CAHp75VfQ6jWm+W1kHh-4zqV28wF4OCCrBfSX8jXxsEcEYSsw5Q@mail.gmail.com>
	(Andy Shevchenko's message of "Mon, 21 Dec 2015 19:55:53 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Dec 21, 2015 at 7:26 PM, Julian Margetson <runaway@candw.ms> =
wrote:
>> On 12/21/2015 12:48 PM, Andy Shevchenko wrote:
>>>
>>> On Sun, 2015-12-20 at 22:55 +0200, Andy Shevchenko wrote:
>>>>
>>>> On Sun, Dec 20, 2015 at 10:17 PM, Andy Shevchenko
>>>> <andy.shevchenko@gmail.com> wrote:
>>>>>
>>>>> On Sun, Dec 20, 2015 at 8:49 PM, M=E5ns Rullg=E5rd <mans@mansr.co=
m>
>>>>> wrote:
>>>>> I noticed thanks to DWC_PARAMS that burst size is hardcoded to 32
>>>>> items on this board, however registers for SATA program it to 64.=
 I
>>>>> remember that I got no interrupt when I programmed transfer width
>>>>> wrongly (64 bits against 32 bits) when I ported dw_dmac to be use=
d
>>>>> on
>>>>> Intel SoCs.
>>>>
>>>> One more thing, I have a patch to monitor DMA IO, we may check wha=
t
>>>> exactly the values are written / read  in DMA. I can share it
>>>> tomorrow.
>>>
>>> As promised the patch I have to debug IO of DW DMA. Didn't check th=
ough
>>> if it applies cleanly on top of recent vanilla kernel.
>
> So, the original driver (with patch from M=E5ns) works, right?

Looks that way to me.  At least it's able to read the partition table.
What happens after that is hard to tell, but I don't see any obvious
errors.

--=20
M=E5ns Rullg=E5rd
