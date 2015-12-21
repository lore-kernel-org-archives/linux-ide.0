From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 19:55:53 +0200
Message-ID: <CAHp75VfQ6jWm+W1kHh-4zqV28wF4OCCrBfSX8jXxsEcEYSsw5Q@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com>
	<56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms>
	<yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com>
	<56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com>
	<5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com>
	<5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com>
	<5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com>
	<5676E906.1060603@candw.ms>
	<yw1xpoy16jlt.fsf@unicorn.mansr.com>
	<CAHp75Vedczfn7B-tOEVZi2dOExW8FiAGGA7iTkpuC2wBrsK68g@mail.gmail.com>
	<CAHp75VfaHvBHhTjQVMNdOYA2kEdus-XpH6E=9i1HPSKTa-2ffA@mail.gmail.com>
	<1450716497.30729.232.camel@linux.intel.com>
	<56783636.80901@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35673 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbLURzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 12:55:55 -0500
In-Reply-To: <56783636.80901@candw.ms>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Dec 21, 2015 at 7:26 PM, Julian Margetson <runaway@candw.ms> wr=
ote:
> On 12/21/2015 12:48 PM, Andy Shevchenko wrote:
>>
>> On Sun, 2015-12-20 at 22:55 +0200, Andy Shevchenko wrote:
>>>
>>> On Sun, Dec 20, 2015 at 10:17 PM, Andy Shevchenko
>>> <andy.shevchenko@gmail.com> wrote:
>>>>
>>>> On Sun, Dec 20, 2015 at 8:49 PM, M=C3=A5ns Rullg=C3=A5rd <mans@man=
sr.com>
>>>> wrote:
>>>> I noticed thanks to DWC_PARAMS that burst size is hardcoded to 32
>>>> items on this board, however registers for SATA program it to 64. =
I
>>>> remember that I got no interrupt when I programmed transfer width
>>>> wrongly (64 bits against 32 bits) when I ported dw_dmac to be used
>>>> on
>>>> Intel SoCs.
>>>
>>> One more thing, I have a patch to monitor DMA IO, we may check what
>>> exactly the values are written / read  in DMA. I can share it
>>> tomorrow.
>>
>> As promised the patch I have to debug IO of DW DMA. Didn't check tho=
ugh
>> if it applies cleanly on top of recent vanilla kernel.

So, the original driver (with patch from M=C3=A5ns) works, right?

--=20
With Best Regards,
Andy Shevchenko
