From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Sat, 19 Dec 2015 19:07:15 +0000
Message-ID: <yw1xio3u8dgc.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5675A84F.2070208@candw.ms> (Julian Margetson's message of "Sat,
	19 Dec 2015 14:56:15 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Julian Margetson <runaway@candw.ms> writes:

> On 12/19/2015 1:19 PM, M=E5ns Rullg=E5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>> On 12/19/2015 1:05 PM, M=E5ns Rullg=E5rd wrote:
>>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>>
>>>>> On Sat, Dec 19, 2015 at 5:40 PM, M=E5ns Rullg=E5rd <mans@mansr.co=
m> wrote:
>>>>>
>>>>>> OK, I've found something.  The dma setup errors are benign, caus=
ed by
>>>>>> the driver calling dmaengine_prep_slave_sg() even for non-dma
>>>>>> operations.
>>>>> I suppose the following is a quick fix to avoid preparing descrip=
tor
>>>>> for non-DMA operations (not tested anyhow)
>>>>>
>>>>> a/drivers/ata/sata_dwc_460ex.c
>>>>> +++ b/drivers/ata/sata_dwc_460ex.c
>>>>> @@ -1041,6 +1041,9 @@ static void sata_dwc_qc_prep_by_tag(struct
>>>>> ata_queued_cmd *qc, u8 tag)
>>>>>                   __func__, ap->port_no, get_dma_dir_descript(qc-=
>dma_dir),
>>>>>                    qc->n_elem);
>>>>>
>>>>> +       if (!is_slave_direction(qc->dma_dir))
>>>>> +               return;
>>>>> +
>>>>>           desc =3D dma_dwc_xfer_setup(qc);
>>>>>           if (!desc) {
>>>>>                   dev_err(ap->dev, "%s: dma_dwc_xfer_setup return=
s NULL\n",
>>>> I already have a better patch sitting here.
>>>>
>>>>>> The real error is the lock recursion that's reported
>>>>>> later.  I wasn't seeing it since I was running a UP non-preempt =
kernel.
>>>>>> With lock debugging enabled, I get the same error.  This patch s=
hould
>>>>>> fix it.
>>>>>> -       spin_lock_irqsave(&ap->host->lock, flags);
>>>>>>           hsdevp->cmd_issued[tag] =3D cmd_issued;
>>>>>> -       spin_unlock_irqrestore(&ap->host->lock, flags);
>>>>>> +
>>>>> This will create a second empty line, though I don't care it is s=
o minor.
>>>> The patch leaves one blank line before the following block comment=
=2E  I
>>>> think it looks better that way.
>>>>
>>> Still can't get the patch applied .
>> Sorry, didn't realise it conflicted with an intervening patch I had =
in
>> my tree.  Try this one.
>>
>
>
> =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D PuTTY log 2015.12.19 =
14:44:52 =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D
>
> U-Boot 2015.a (May 16 2015 - 14:20:11)
>
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=3D231 OPB=3D115 EBC=
=3D115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + SATA-2
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE1: successfully set as root-complex
>         02  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-VirtualB=
ox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #1 PREEMPT Sat Dec 19=
 14:25:55 AST 2015
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff=
]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000=
07fffffff]
> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 cont=
exts
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.=
  Total pages: 522752
> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3DttyS0,=
115200 console=3Dtty1 dw_dmac_core.dyndbg dw_dmac.dyndbg

Please add ignore_log_level.

--=20
M=E5ns Rullg=E5rd
