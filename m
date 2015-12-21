From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 10:40:01 +0200
Message-ID: <CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
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
	<yw1xa8p47h3w.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34572 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbbLUIkC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 03:40:02 -0500
In-Reply-To: <yw1xa8p47h3w.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Viresh Kumar <viresh.linux@gmail.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

+Viresh

On Mon, Dec 21, 2015 at 2:58 AM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> On Sun, Dec 20, 2015 at 8:49 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr=
=2Ecom> wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>> On 12/20/2015 1:11 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>
>>>> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED
>>>
>>> Well, that didn't help.  I still think it's part of the problem, bu=
t
>>> something else must be wrong as well.  The various Master Select fi=
elds
>>> look like a good place to start.
>>
>> Master number (which is here would be either 1 or 0) should not affe=
ct
>> as long as they are connected to the same AHB bus (I would be
>> surprised if they are not).
>
> I think they are not.  The relevant part of the block diagram for the
> 460EX looks something like this:
>
>       +-----+
>       | CPU |
>       +-----+
>          |
>  +---------------+
>  |      BUS      |
>  +---------------+
>     |         |
>  +-----+   +-----+
>  | DMA |   | RAM |
>  +-----+   +-----+
>     |
>  +------+
>  | SATA |
>  +------+
>
> The DMA-SATA link is private and ignores the address, which is the on=
ly
> reason the driver can possibly work (it's programming a CPU virtual
> address there).

If you look at the original code the SMS and DMS are programmed
statically independent on DMA direction, so LLP is programmed always
to master 1. I don't think your scheme is reflecting this right. I
could imagine two AHB buses, one of them connects CPU, SATA and RAM,
and the other CPU and DMA.

In any case on all Intel SoCs and AVR32, and as far as I can tell on
Spear13xx (Viresh?) there is not a case, that's why I hardly imagine
that the problem is in master numbers by themselves.

>>> Also, the manual says the LLP_SRC_EN
>>> and LLP_DST_EN flags should be cleared on the last in a chain of bl=
ocks.
>>> The old sata_dwc driver does this whereas dw_dma does not.
>>
>> Easy to fix, however I can't get how it might affect.
>
> From the Atmel doc:
>
>   In Table 17-1 on page 185, all other combinations of LLPx.LOC =3D 0=
,
>   CTLx.LLP_S_EN, CFGx.RELOAD_SR, CTLx.LLP_D_EN, and CFGx.RELOAD_DS ar=
e
>   illegal, and causes indeterminate or erroneous behavior.

I will check Synospys documentation later on.

> Most likely nothing happens, but I think it ought to be fixed.  In fa=
ct,
> I have a patch already.

Good. Send with Fixes tag if it's upstream ready.

> Come to think of it, I have an AVR32 dev somewhere.  Maybe I should d=
ust
> it off.

I have ATNGW100.

P.S. Anyway we have to ask Julian to try the kernel with
8b3444852a2b58129 reverted.

--=20
With Best Regards,
Andy Shevchenko
