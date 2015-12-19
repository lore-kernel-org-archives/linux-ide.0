From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Sat, 19 Dec 2015 04:34:24 +0200
Message-ID: <CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms>
	<yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms>
	<yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms>
	<yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms>
	<yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms>
	<yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com>
	<5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com>
	<56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com>
	<56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:32786 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbbLSCeZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2015 21:34:25 -0500
In-Reply-To: <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Julian Margetson <runaway@candw.ms>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Dec 19, 2015 at 1:16 AM, M=C3=A5ns Rullg=C3=A5rd <mans@mansr.co=
m> wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/18/2015 6:33 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>
>>>> On 12/18/2015 1:18 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>
>>>>>> On 12/18/2015 8:49 AM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>>>>>
>>>>>>>>>> [    5.206125] Unable to handle kernel paging request for da=
ta at
>>>>>>>>>> address 0x00000000
>>>>>>>>>> [    5.228546] Faulting instruction address: 0xc043a2c8
>>>>>>>>>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>>>>>>>>>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x20=
4
>>>>>>>>> Well, that's not good.  Can you translate that address to a l=
ine of
>>>>>>>>> code?
>>>>>>>> Besides that, can you enable DYNAMIC_DEBUG in the config and a=
ppend
>>>>>>>> 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?
>>>>>>> Enabling debug messages in the sata_dwc driver might also be in=
formative.
>>>>>>>
>>>>>> Changed the sata-dwc to a module .
>>>>>>
>>>>>> [   18.475140] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag:=
 dma_dwc_xfer_setup returns NULL
>>>>>> [   18.535698] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag:=
 dma_dwc_xfer_setup returns NULL
>>>>> That's strange.  The only way that can happen is if
>>>>> dmaengine_prep_slave_sg() return NULL, and that really shouldn't =
be
>>>>> happening.  Did you turn on debug messages in dw_dma?  You can en=
able
>>>>> some extra debug messages by adding "#define VERBOSE_DEBUG" at th=
e top
>>>>> of drivers/dma/dw/core.c
>>>>>
>>>> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>>> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>>> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>> Could you post the entire kernel log?  There might be important
>>> information before the errors start.
>>>
>>
>>
>> =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D PuTTY log 2015.12.18=
 15:01:48 =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D
>> [    0.000000] Using Canyonlands machine description
>> [    0.000000] Initializing cgroup subsys cpu
>> [    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-Virtual=
Box) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #8 PREEMPT Fri Dec 1=
8 13:36:34 AST 2015
>> [    0.000000] Zone ranges:
>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff=
]
>> [    0.000000]   Normal   empty
>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff=
]
>> [    0.000000] Movable zone start for each node
>> [    0.000000] Early memory node ranges
>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007ffffff=
f]
>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000=
007fffffff]
>> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 con=
texts
>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on=
=2E  Total pages: 522752
>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3DttyS0=
,115200 console=3Dtty0 dw_dmac_core.dyndbg dw_dmac.dyndbg

I would suggest to use console=3Dtty1 instead of console=3Dtty0.

>
> [...]
>
>> [   13.643415] systemd[1]: Mounted Configuration File System.
>> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma=
_dwc_xfer_setup returns NULL
>> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma=
_dwc_xfer_setup returns NULL
>> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma=
_dwc_xfer_setup returns NULL
>
> This log is weird.  The sata_dwc_probe() function prints several thin=
gs
> (one using dev_notice()), for instance this:
>
>         /* Read the ID and Version Registers */
>         idr =3D in_le32(&hsdev->sata_dwc_regs->idr);
>         versionr =3D in_le32(&hsdev->sata_dwc_regs->versionr);
>         dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n"=
,
>                    idr, ver[0], ver[1], ver[2]);
>
> The dw_dma_probe() function also prints a line:
>
>         dev_info(chip->dev, "DesignWare DMA Controller, %d channels\n=
",
>                  pdata->nr_channels);
>
> These messages are nowhere to be seen in your log, nor are numerous
> others that really must appear before before sata_dwc_qc_prep_by_tag(=
)
> can be called.
>

It would be better to add 'ignore_loglevel' to the cmdline as well.

> I'd like to note that the driver works on my Sigma Designs based syst=
em
> using a different DMA controller, so it's not completely broken.  The
> DMA driver could still be faulty, but that still doesn't explain the
> missing kernel messages.
>
> --
> M=C3=A5ns Rullg=C3=A5rd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



--=20
With Best Regards,
Andy Shevchenko
