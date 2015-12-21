From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Mon, 21 Dec 2015 09:18:41 -0400
Message-ID: <5677FC31.1030305@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
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
 <yw1xa8p47h3w.fsf@unicorn.mansr.com>
 <CAHp75VeT6ZssxiD-c3SqZgAcL5vFuvv4H5AVPz8sypuGkuvqRg@mail.gmail.com>
 <5677D447.40906@candw.ms> <yw1xsi2w574t.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp687.redcondor.net ([208.80.206.87]:42283 "EHLO
	smtp687.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbbLUNTG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 08:19:06 -0500
In-Reply-To: <yw1xsi2w574t.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Viresh Kumar <viresh.linux@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/21/2015 8:16 AM, M=E5ns Rullg=E5rd wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/21/2015 4:40 AM, Andy Shevchenko wrote:
>>> +Viresh
>>>
>>> On Mon, Dec 21, 2015 at 2:58 AM, M=E5ns Rullg=E5rd <mans@mansr.com>=
 wrote:
>>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>>
>>>>> On Sun, Dec 20, 2015 at 8:49 PM, M=E5ns Rullg=E5rd <mans@mansr.co=
m> wrote:
>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>> On 12/20/2015 1:11 PM, M=E5ns Rullg=E5rd wrote:
>>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED
>>>>>> Well, that didn't help.  I still think it's part of the problem,=
 but
>>>>>> something else must be wrong as well.  The various Master Select=
 fields
>>>>>> look like a good place to start.
>>>>> Master number (which is here would be either 1 or 0) should not a=
ffect
>>>>> as long as they are connected to the same AHB bus (I would be
>>>>> surprised if they are not).
>>>> I think they are not.  The relevant part of the block diagram for =
the
>>>> 460EX looks something like this:
>>>>
>>>>         +-----+
>>>>         | CPU |
>>>>         +-----+
>>>>            |
>>>>    +---------------+
>>>>    |      BUS      |
>>>>    +---------------+
>>>>       |         |
>>>>    +-----+   +-----+
>>>>    | DMA |   | RAM |
>>>>    +-----+   +-----+
>>>>       |
>>>>    +------+
>>>>    | SATA |
>>>>    +------+
>>>>
>>>> The DMA-SATA link is private and ignores the address, which is the=
 only
>>>> reason the driver can possibly work (it's programming a CPU virtua=
l
>>>> address there).
>>> If you look at the original code the SMS and DMS are programmed
>>> statically independent on DMA direction, so LLP is programmed alway=
s
>>> to master 1. I don't think your scheme is reflecting this right. I
>>> could imagine two AHB buses, one of them connects CPU, SATA and RAM=
,
>>> and the other CPU and DMA.
>>>
>>> In any case on all Intel SoCs and AVR32, and as far as I can tell o=
n
>>> Spear13xx (Viresh?) there is not a case, that's why I hardly imagin=
e
>>> that the problem is in master numbers by themselves.
>>>
>>>>>> Also, the manual says the LLP_SRC_EN
>>>>>> and LLP_DST_EN flags should be cleared on the last in a chain of=
 blocks.
>>>>>> The old sata_dwc driver does this whereas dw_dma does not.
>>>>> Easy to fix, however I can't get how it might affect.
>>>>   From the Atmel doc:
>>>>
>>>>     In Table 17-1 on page 185, all other combinations of LLPx.LOC =
=3D 0,
>>>>     CTLx.LLP_S_EN, CFGx.RELOAD_SR, CTLx.LLP_D_EN, and CFGx.RELOAD_=
DS are
>>>>     illegal, and causes indeterminate or erroneous behavior.
>>> I will check Synospys documentation later on.
>>>
>>>> Most likely nothing happens, but I think it ought to be fixed.  In=
 fact,
>>>> I have a patch already.
>>> Good. Send with Fixes tag if it's upstream ready.
>>>
>>>> Come to think of it, I have an AVR32 dev somewhere.  Maybe I shoul=
d dust
>>>> it off.
>>> I have ATNGW100.
>>>
>>> P.S. Anyway we have to ask Julian to try the kernel with
>>> 8b3444852a2b58129 reverted.
>>>
>> git revert 8b3444852a2b58129
>> error: could not revert 8b34448... sata_dwc_460ex: move to generic D=
MA driver
>> hint: after resolving the conflicts, mark the corrected paths
>> hint: with 'git add <paths>' or 'git rm <paths>'
>> hint: and commit the result with 'git commit'
> Yeah, that won't work since there are numerous changes afterward.  Ju=
st
> revert the entire file back to 4.0 like this:
>
> $ git checkout v4.0 drivers/ata/sata_dwc_460ex.c
>
  CC [M]  drivers/ata/sata_dwc_460ex.o
drivers/ata/sata_dwc_460ex.c:467:36: error: macro "dma_request_channel"=
=20
requires 3 arguments, but only 1 given
  static int dma_request_channel(void)
                                     ^
drivers/ata/sata_dwc_460ex.c:468:1: error: expected =E2=80=98=3D=E2=80=99=
, =E2=80=98,=E2=80=99,=20
=E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=
=80=99 before =E2=80=98{=E2=80=99 token
  {
  ^
drivers/ata/sata_dwc_460ex.c: In function =E2=80=98dma_dwc_xfer_setup=E2=
=80=99:
drivers/ata/sata_dwc_460ex.c:758:31: error: macro "dma_request_channel"=
=20
requires 3 arguments, but only 1 given
   dma_ch =3D dma_request_channel();
                                ^
drivers/ata/sata_dwc_460ex.c:758:11: error: =E2=80=98dma_request_channe=
l=E2=80=99=20
undeclared (first use in this function)
   dma_ch =3D dma_request_channel();
            ^
drivers/ata/sata_dwc_460ex.c:758:11: note: each undeclared identifier i=
s=20
reported only once for each function it appears in
drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_dma_filter=E2=
=80=99:
drivers/ata/sata_dwc_460ex.c:1282:35: error: =E2=80=98struct=20
sata_dwc_device_port=E2=80=99 has no member named =E2=80=98dws=E2=80=99
   struct dw_dma_slave *dws =3D hsdevp->dws;
                                    ^
drivers/ata/sata_dwc_460ex.c: In function =E2=80=98sata_dwc_port_start=E2=
=80=99:
drivers/ata/sata_dwc_460ex.c:1325:17: warning: unused variable=20
=E2=80=98mask=E2=80=99 [-Wunused-variable]
   dma_cap_mask_t mask;
                  ^
drivers/ata/sata_dwc_460ex.c: At top level:
drivers/ata/sata_dwc_460ex.c:345:28: warning: =E2=80=98sata_dwc_dma_dws=
=E2=80=99=20
defined but not used [-Wunused-variable]
  static struct dw_dma_slave sata_dwc_dma_dws =3D {
                             ^
drivers/ata/sata_dwc_460ex.c:1279:13: warning: =E2=80=98sata_dwc_dma_fi=
lter=E2=80=99=20
defined but not used [-Wunused-function]
  static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
              ^
make[2]: *** [drivers/ata/sata_dwc_460ex.o] Error 1
make[1]: *** [drivers/ata] Error 2
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....


