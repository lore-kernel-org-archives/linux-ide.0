From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 08:33:58 -0400
Message-ID: <5673FD36.4050502@candw.ms>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
 <yw1x1tanffqg.fsf@unicorn.mansr.com>
 <1450364395.30729.136.camel@linux.intel.com>
 <yw1x60zxds5k.fsf@unicorn.mansr.com>
 <1450367702.30729.146.camel@linux.intel.com>
 <yw1xk2odcb87.fsf@unicorn.mansr.com>
 <1450371184.30729.175.camel@linux.intel.com> <5672F77F.4010306@candw.ms>
 <yw1xfuz1c5xy.fsf@unicorn.mansr.com> <567302E8.5050303@candw.ms>
 <yw1x7fkcdi2a.fsf@unicorn.mansr.com> <5673061A.4070700@candw.ms>
 <yw1x37v0df86.fsf@unicorn.mansr.com> <56732C04.9040100@candw.ms>
 <yw1xvb7wbowu.fsf@unicorn.mansr.com> <5673F277.2050607@candw.ms>
 <yw1xegekarp9.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp754.redcondor.net ([208.80.206.54]:50037 "EHLO
	smtp754.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbbLRMeW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2015 07:34:22 -0500
In-Reply-To: <yw1xegekarp9.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/18/2015 8:04 AM, M=C3=A5ns Rullg=C3=A5rd wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/17/2015 8:06 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>
>>>> On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>
>>>>>> On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>
>>>>>>>> On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>>>
>>>>>>>>>> I have been running my machine mostly configured for pciex1 =
 thus with
>>>>>>>>>> the sata_dwc disabled.
>>>>>>>>>> The changes to sata_dwc-460ex do cause an oops.
>>>>>>>>>> I will try to give more detailed info over this weekend .
>>>>>>>>> The driver as is upstream would do that since it unconditiona=
lly
>>>>>>>>> dereferences a null pointer in the probe function.  My patch =
fixes that
>>>>>>>>> as a side-effect.
>>>>>>>>>
>>>>>>>> patching file drivers/ata/Kconfig
>>>>>>>>
>>>>>>>> Hunk #1 FAILED at 296.
>>>>>>> [...]
>>>>>>>
>>>>>>>> root@julian-VirtualBox:/usr/src/linux-3.18.25#
>>>>>>> The patch is against 4.4-rc5.
>>>>>>>
>>>>>>     CC      drivers/ata/sata_dwc_460ex.o
>>>>>>
>>>>>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =C3=A2=E2=82=
=AC=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2 has initializer but i=
ncomplete type
>>>>>>
>>>>>>     static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>>>>>                   ^
>>>>> It builds, albeit with an unrelated warning, using the attached c=
onfig.
>>>>> Maybe there's a missing config dependency somewhere.
>>>>>
>>>> I am attempting to cross compile under Ubuntu 14.04 X86 in Virtual=
box
>>>> with your .config.
>>>> 4.4.0-rc5 builds ok with no patches applied .
>>>> Once your patch is applied it fails to build .
>>>>
>>>> CC      drivers/ata/sata_dwc_460ex.o
>>>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =E2=80=98sata=
_dwc_dma_dws=E2=80=99 has initializer but incomplete type
>>>>    static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>>>                  ^
>>> Bizarre.  This is what it looks like here:
>>>
>>> mru@unicorn:/tmp/linux-sata$ git status
>>> On branch sata-dwc
>>> nothing to commit, working directory clean
>>> mru@unicorn:/tmp/linux-sata$ git describe
>>> v4.4-rc5
>>> mru@unicorn:/tmp/linux-sata$ sha1sum /tmp/0001-ata-sata_dwc_460ex-u=
se-dmas-DT-property-to-find-dma-.patch
>>> e300971aa483390f82de2e9120dc16e460e74feb  /tmp/0001-ata-sata_dwc_46=
0ex-use-dmas-DT-property-to-find-dma-.patch
>>> mru@unicorn:/tmp/linux-sata$ git am /tmp/0001-ata-sata_dwc_460ex-us=
e-dmas-DT-property-to-find-dma-.patch
>>> Applying: ata: sata_dwc_460ex: use "dmas" DT property to find dma c=
hannel
>>> mru@unicorn:/tmp/linux-sata$ sha1sum .config
>>> 4e7615b8d2fa9a1c4b4ae9ffc363aefcaf3789ca  .config
>>> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpo=
werpc64-none-linux-gnu- oldconfig
>>>     HOSTCC  scripts/basic/fixdep
>>>     HOSTCC  scripts/kconfig/conf.o
>>>     SHIPPED scripts/kconfig/zconf.tab.c
>>>     SHIPPED scripts/kconfig/zconf.lex.c
>>>     SHIPPED scripts/kconfig/zconf.hash.c
>>>     HOSTCC  scripts/kconfig/zconf.tab.o
>>>     HOSTLD  scripts/kconfig/conf
>>> scripts/kconfig/conf  --oldconfig Kconfig
>>> #
>>> # configuration written to .config
>>> #
>>> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpo=
werpc64-none-linux-gnu- drivers/ata/sata_dwc_460ex.o
>>> scripts/kconfig/conf  --silentoldconfig Kconfig
>>>     CHK     include/config/kernel.release
>>>     UPD     include/config/kernel.release
>>>     WRAP    arch/powerpc/include/generated/asm/clkdev.h
>>>     WRAP    arch/powerpc/include/generated/asm/div64.h
>>>     WRAP    arch/powerpc/include/generated/asm/irq_regs.h
>>>     WRAP    arch/powerpc/include/generated/asm/irq_work.h
>>>     WRAP    arch/powerpc/include/generated/asm/local64.h
>>>     WRAP    arch/powerpc/include/generated/asm/mcs_spinlock.h
>>>     WRAP    arch/powerpc/include/generated/asm/preempt.h
>>>     WRAP    arch/powerpc/include/generated/asm/rwsem.h
>>>     WRAP    arch/powerpc/include/generated/asm/vtime.h
>>>     CHK     include/generated/uapi/linux/version.h
>>>     UPD     include/generated/uapi/linux/version.h
>>>     CHK     include/generated/utsrelease.h
>>>     UPD     include/generated/utsrelease.h
>>>     CC      kernel/bounds.s
>>>     CHK     include/generated/bounds.h
>>>     UPD     include/generated/bounds.h
>>>     CHK     include/generated/timeconst.h
>>>     UPD     include/generated/timeconst.h
>>>     CC      arch/powerpc/kernel/asm-offsets.s
>>>     CHK     include/generated/asm-offsets.h
>>>     UPD     include/generated/asm-offsets.h
>>>     CALL    scripts/checksyscalls.sh
>>>     HOSTCC  scripts/dtc/dtc.o
>>>     HOSTCC  scripts/dtc/flattree.o
>>>     HOSTCC  scripts/dtc/fstree.o
>>>     HOSTCC  scripts/dtc/data.o
>>>     HOSTCC  scripts/dtc/livetree.o
>>>     HOSTCC  scripts/dtc/treesource.o
>>>     HOSTCC  scripts/dtc/srcpos.o
>>>     HOSTCC  scripts/dtc/checks.o
>>>     HOSTCC  scripts/dtc/util.o
>>>     SHIPPED scripts/dtc/dtc-lexer.lex.c
>>>     SHIPPED scripts/dtc/dtc-parser.tab.h
>>>     HOSTCC  scripts/dtc/dtc-lexer.lex.o
>>>     SHIPPED scripts/dtc/dtc-parser.tab.c
>>>     HOSTCC  scripts/dtc/dtc-parser.tab.o
>>>     HOSTLD  scripts/dtc/dtc
>>>     CC      scripts/mod/empty.o
>>>     HOSTCC  scripts/mod/mk_elfconfig
>>>     MKELF   scripts/mod/elfconfig.h
>>>     HOSTCC  scripts/mod/modpost.o
>>>     CC      scripts/mod/devicetable-offsets.s
>>>     GEN     scripts/mod/devicetable-offsets.h
>>>     HOSTCC  scripts/mod/file2alias.o
>>>     HOSTCC  scripts/mod/sumversion.o
>>>     HOSTLD  scripts/mod/modpost
>>>     HOSTCC  scripts/kallsyms
>>>     CC      drivers/ata/sata_dwc_460ex.o
>>> drivers/ata/sata_dwc_460ex.c: In function 'dma_dwc_xfer_setup':
>>> drivers/ata/sata_dwc_460ex.c:383:20: warning: cast from pointer to =
integer of different size [-Wpointer-to-int-cast]
>>>     dma_addr_t addr =3D (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
>>>                       ^
>>> mru@unicorn:/tmp/linux-sata$
>>>
>>> Patch file and .config attached.
>>>
>>> Looking into that warning, I doubt it works as is, but that's not c=
aused
>>> by my patch.  I can try to come up with a fix, but again, I can't t=
est it.
>>>
>> Builds now. Using my own .config.
> What changed?
I may have messed up the patch initially .
>
>> [    4.784199] sata-dwc 4bffd1000.sata: id 0, controller version 1.8=
2
>> [    4.791186] scsi host0: sata-dwc
>> [    4.794830] ata1: SATA max UDMA/133 irq 36
>> [    4.799463] sata_sil 0001:00:04.0: Applying R_ERR on DMA activate=
 FIS errata fix
>> [    4.807959] scsi host1: sata_sil
>> [    4.811662] scsi host2: sata_sil
>> [    4.815242] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd8=
4280080 irq 21
>> [    4.822990] ata3: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd8=
42800c0 irq 21
>>
>> [    5.143502] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300=
)
>> [    5.164367] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310=
)
>> [    5.185174] ppc-of-ohci 4bffd0000.usb: irq 32, io mem 0x4bffd0000
>> [    5.206125] Unable to handle kernel paging request for data at ad=
dress 0x00000000
>> [    5.228546] Faulting instruction address: 0xc043a2c8
>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
> Well, that's not good.  Can you translate that address to a line of c=
ode?
>
need some guidance on method .

