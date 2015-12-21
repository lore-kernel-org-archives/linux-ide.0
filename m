From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 19:24:12 +0200
Message-ID: <CAHp75Vcin1GXpYm-air5fV5B+jiMnB9hoByCqOvbDgd5pHRRJA@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
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
	<CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
	<yw1xwps8577f.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <yw1xwps8577f.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Mon, Dec 21, 2015 at 2:15 PM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>
>> +Viresh
>>
>> On Mon, Dec 21, 2015 at 2:58 AM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr=
=2Ecom> wrote:
>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>
>>>> On Sun, Dec 20, 2015 at 8:49 PM, M=C3=A5ns Rullg=C3=A5rd <mans@man=
sr.com> wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>> On 12/20/2015 1:11 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>
>>>>>> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED
>>>>>
>>>>> Well, that didn't help.  I still think it's part of the problem, =
but
>>>>> something else must be wrong as well.  The various Master Select =
fields
>>>>> look like a good place to start.
>>>>
>>>> Master number (which is here would be either 1 or 0) should not af=
fect
>>>> as long as they are connected to the same AHB bus (I would be
>>>> surprised if they are not).
>>>
>>> I think they are not.  The relevant part of the block diagram for t=
he
>>> 460EX looks something like this:
>>>
>>>       +-----+
>>>       | CPU |
>>>       +-----+
>>>          |
>>>  +---------------+
>>>  |      BUS      |
>>>  +---------------+
>>>     |         |
>>>  +-----+   +-----+
>>>  | DMA |   | RAM |
>>>  +-----+   +-----+
>>>     |
>>>  +------+
>>>  | SATA |
>>>  +------+
>>>
>>> The DMA-SATA link is private and ignores the address, which is the =
only
>>> reason the driver can possibly work (it's programming a CPU virtual
>>> address there).
>>
>> If you look at the original code the SMS and DMS are programmed
>> statically independent on DMA direction, so LLP is programmed always
>> to master 1. I don't think your scheme is reflecting this right. I
>> could imagine two AHB buses, one of them connects CPU, SATA and RAM,
>> and the other CPU and DMA.
>
> Check the code again.  The original code swaps SMS and DMS depending =
on
> direction, and it sets LMS to 1.  Put differently, it always sets the
> memory side 1 and the device side to 0.  The dw_dma driver sets SMS a=
nd
> DMS to the src/dst_master values provided through dma_request_channel=
()
> regardless of the current direction and LMS always zero.

I used to have a patch to implement this in dw_dmac driver. However, I
dropped it at some point. Seems we need it back and now I possible
have a good explanation why.

> If those
> values didn't matter, why would the fields exist in the first place?

Because someone can have more than one AHB bus on the system and
connect DMA to all of them (up to 4).

>> In any case on all Intel SoCs and AVR32, and as far as I can tell on
>> Spear13xx (Viresh?) there is not a case, that's why I hardly imagine
>> that the problem is in master numbers by themselves.
>
> The 460EX is a PowerPC system.  Expect unusual topologies.

Yeah, that's right.

>>>>> Also, the manual says the LLP_SRC_EN
>>>>> and LLP_DST_EN flags should be cleared on the last in a chain of =
blocks.
>>>>> The old sata_dwc driver does this whereas dw_dma does not.
>>>>
>>>> Easy to fix, however I can't get how it might affect.
>>>
>>> From the Atmel doc:
>>>
>>>   In Table 17-1 on page 185, all other combinations of LLPx.LOC =3D=
 0,
>>>   CTLx.LLP_S_EN, CFGx.RELOAD_SR, CTLx.LLP_D_EN, and CFGx.RELOAD_DS =
are
>>>   illegal, and causes indeterminate or erroneous behavior.
>>
>> I will check Synospys documentation later on.

Yes, we have to clear those bits. I will do a patch or you already have=
 one?

>>> Most likely nothing happens, but I think it ought to be fixed.  In =
fact,
>>> I have a patch already.
>>
>> Good. Send with Fixes tag if it's upstream ready.
>>
>>> Come to think of it, I have an AVR32 dev somewhere.  Maybe I should=
 dust
>>> it off.
>>
>> I have ATNGW100.
>
> I have an AT32ATK1006.  Can you suggest a good test to exercise the D=
MA
> engine?

On that board I tried MMC (the only available user for me), though it
is not reliable, I also tried the dmatest module.

--=20
With Best Regards,
Andy Shevchenko
