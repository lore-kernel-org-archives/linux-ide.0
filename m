From: Julian Margetson <runaway@candw.ms>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find
 dma channel
Date: Fri, 18 Dec 2015 07:48:07 -0400
Message-ID: <5673F277.2050607@candw.ms>
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
 <yw1xvb7wbowu.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp618.redcondor.net ([208.80.206.18]:35196 "EHLO
	smtp618.redcondor.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbbLRLsd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2015 06:48:33 -0500
In-Reply-To: <yw1xvb7wbowu.fsf@unicorn.mansr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/17/2015 8:06 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
> Julian Margetson <runaway@candw.ms> writes:
>
>> On 12/17/2015 3:53 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>
>>>> On 12/17/2015 2:51 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>
>>>>>> On 12/17/2015 1:59 PM, M=C3=A5ns Rullg=C3=A5rd wrote:
>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>
>>>>>>>> I have been running my machine mostly configured for pciex1  t=
hus with
>>>>>>>> the sata_dwc disabled.
>>>>>>>> The changes to sata_dwc-460ex do cause an oops.
>>>>>>>> I will try to give more detailed info over this weekend .
>>>>>>> The driver as is upstream would do that since it unconditionall=
y
>>>>>>> dereferences a null pointer in the probe function.  My patch fi=
xes that
>>>>>>> as a side-effect.
>>>>>>>
>>>>>> patching file drivers/ata/Kconfig
>>>>>>
>>>>>> Hunk #1 FAILED at 296.
>>>>> [...]
>>>>>
>>>>>> root@julian-VirtualBox:/usr/src/linux-3.18.25#
>>>>> The patch is against 4.4-rc5.
>>>>>
>>>>    CC      drivers/ata/sata_dwc_460ex.o
>>>>
>>>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =C3=A2=E2=82=AC=
=CB=9Csata_dwc_dma_dws=C3=A2=E2=82=AC=E2=84=A2 has initializer but inco=
mplete type
>>>>
>>>>    static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>>>                  ^
>>> It builds, albeit with an unrelated warning, using the attached con=
fig.
>>> Maybe there's a missing config dependency somewhere.
>>>
>> I am attempting to cross compile under Ubuntu 14.04 X86 in Virtualbo=
x
>> with your .config.
>> 4.4.0-rc5 builds ok with no patches applied .
>> Once your patch is applied it fails to build .
>>
>> CC      drivers/ata/sata_dwc_460ex.o
>> drivers/ata/sata_dwc_460ex.c:198:15: error: variable =E2=80=98sata_d=
wc_dma_dws=E2=80=99 has initializer but incomplete type
>>   static struct dw_dma_slave sata_dwc_dma_dws =3D {
>>                 ^
> Bizarre.  This is what it looks like here:
>
> mru@unicorn:/tmp/linux-sata$ git status
> On branch sata-dwc
> nothing to commit, working directory clean
> mru@unicorn:/tmp/linux-sata$ git describe
> v4.4-rc5
> mru@unicorn:/tmp/linux-sata$ sha1sum /tmp/0001-ata-sata_dwc_460ex-use=
-dmas-DT-property-to-find-dma-.patch
> e300971aa483390f82de2e9120dc16e460e74feb  /tmp/0001-ata-sata_dwc_460e=
x-use-dmas-DT-property-to-find-dma-.patch
> mru@unicorn:/tmp/linux-sata$ git am /tmp/0001-ata-sata_dwc_460ex-use-=
dmas-DT-property-to-find-dma-.patch
> Applying: ata: sata_dwc_460ex: use "dmas" DT property to find dma cha=
nnel
> mru@unicorn:/tmp/linux-sata$ sha1sum .config
> 4e7615b8d2fa9a1c4b4ae9ffc363aefcaf3789ca  .config
> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowe=
rpc64-none-linux-gnu- oldconfig
>    HOSTCC  scripts/basic/fixdep
>    HOSTCC  scripts/kconfig/conf.o
>    SHIPPED scripts/kconfig/zconf.tab.c
>    SHIPPED scripts/kconfig/zconf.lex.c
>    SHIPPED scripts/kconfig/zconf.hash.c
>    HOSTCC  scripts/kconfig/zconf.tab.o
>    HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf  --oldconfig Kconfig
> #
> # configuration written to .config
> #
> mru@unicorn:/tmp/linux-sata$ make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowe=
rpc64-none-linux-gnu- drivers/ata/sata_dwc_460ex.o
> scripts/kconfig/conf  --silentoldconfig Kconfig
>    CHK     include/config/kernel.release
>    UPD     include/config/kernel.release
>    WRAP    arch/powerpc/include/generated/asm/clkdev.h
>    WRAP    arch/powerpc/include/generated/asm/div64.h
>    WRAP    arch/powerpc/include/generated/asm/irq_regs.h
>    WRAP    arch/powerpc/include/generated/asm/irq_work.h
>    WRAP    arch/powerpc/include/generated/asm/local64.h
>    WRAP    arch/powerpc/include/generated/asm/mcs_spinlock.h
>    WRAP    arch/powerpc/include/generated/asm/preempt.h
>    WRAP    arch/powerpc/include/generated/asm/rwsem.h
>    WRAP    arch/powerpc/include/generated/asm/vtime.h
>    CHK     include/generated/uapi/linux/version.h
>    UPD     include/generated/uapi/linux/version.h
>    CHK     include/generated/utsrelease.h
>    UPD     include/generated/utsrelease.h
>    CC      kernel/bounds.s
>    CHK     include/generated/bounds.h
>    UPD     include/generated/bounds.h
>    CHK     include/generated/timeconst.h
>    UPD     include/generated/timeconst.h
>    CC      arch/powerpc/kernel/asm-offsets.s
>    CHK     include/generated/asm-offsets.h
>    UPD     include/generated/asm-offsets.h
>    CALL    scripts/checksyscalls.sh
>    HOSTCC  scripts/dtc/dtc.o
>    HOSTCC  scripts/dtc/flattree.o
>    HOSTCC  scripts/dtc/fstree.o
>    HOSTCC  scripts/dtc/data.o
>    HOSTCC  scripts/dtc/livetree.o
>    HOSTCC  scripts/dtc/treesource.o
>    HOSTCC  scripts/dtc/srcpos.o
>    HOSTCC  scripts/dtc/checks.o
>    HOSTCC  scripts/dtc/util.o
>    SHIPPED scripts/dtc/dtc-lexer.lex.c
>    SHIPPED scripts/dtc/dtc-parser.tab.h
>    HOSTCC  scripts/dtc/dtc-lexer.lex.o
>    SHIPPED scripts/dtc/dtc-parser.tab.c
>    HOSTCC  scripts/dtc/dtc-parser.tab.o
>    HOSTLD  scripts/dtc/dtc
>    CC      scripts/mod/empty.o
>    HOSTCC  scripts/mod/mk_elfconfig
>    MKELF   scripts/mod/elfconfig.h
>    HOSTCC  scripts/mod/modpost.o
>    CC      scripts/mod/devicetable-offsets.s
>    GEN     scripts/mod/devicetable-offsets.h
>    HOSTCC  scripts/mod/file2alias.o
>    HOSTCC  scripts/mod/sumversion.o
>    HOSTLD  scripts/mod/modpost
>    HOSTCC  scripts/kallsyms
>    CC      drivers/ata/sata_dwc_460ex.o
> drivers/ata/sata_dwc_460ex.c: In function 'dma_dwc_xfer_setup':
> drivers/ata/sata_dwc_460ex.c:383:20: warning: cast from pointer to in=
teger of different size [-Wpointer-to-int-cast]
>    dma_addr_t addr =3D (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
>                      ^
> mru@unicorn:/tmp/linux-sata$
>
> Patch file and .config attached.
>
> Looking into that warning, I doubt it works as is, but that's not cau=
sed
> by my patch.  I can try to come up with a fix, but again, I can't tes=
t it.
>
Builds now. Using my own .config.

[    4.784199] sata-dwc 4bffd1000.sata: id 0, controller version 1.82
[    4.791186] scsi host0: sata-dwc
[    4.794830] ata1: SATA max UDMA/133 irq 36
[    4.799463] sata_sil 0001:00:04.0: Applying R_ERR on DMA activate FI=
S=20
errata fix
[    4.807959] scsi host1: sata_sil
[    4.811662] scsi host2: sata_sil
[    4.815242] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf=20
0xd84280080 irq 21
[    4.822990] ata3: SATA max UDMA/100 mmio m512@0xd84280000 tf=20
0xd842800c0 irq 21

[    5.143502] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.164367] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    5.185174] ppc-of-ohci 4bffd0000.usb: irq 32, io mem 0x4bffd0000
[    5.206125] Unable to handle kernel paging request for data at=20
address 0x00000000
[    5.228546] Faulting instruction address: 0xc043a2c8
[    5.248577] Vector: 300 (Data Access) at [eddafae0]
[    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
[    5.289439]     lr: c0427c34: ata_qc_issue+0x338/0x3a0
[    5.309708]     sp: eddafb90
[    5.327573]    msr: 21000
[    5.345108]    dar: 0
[    5.362242]  dsisr: 0
[    5.379257]   current =3D 0xedda85c0
[    5.397452]     pid   =3D 81, comm =3D scsi_eh_0
[    5.416599] enter ? for help
[    5.434346] [eddafbe0] c0427c34 ata_qc_issue+0x338/0x3a0
[    5.454892] [eddafc10] c0427f0c ata_exec_internal_sg+0x270/0x47c
[    5.476090] [eddafc80] c042818c ata_exec_internal+0x74/0x7c
[    5.496645] [eddafcc0] c042839c ata_dev_read_id+0x150/0x4e0
[    5.517001] [eddafd40] c0434b4c ata_eh_recover+0xfac/0x1088
[    5.537210] [eddafdd0] c043516c ata_do_eh+0x4c/0x9c
[    5.556724] [eddafe00] c0434e10 ata_scsi_port_error_handler+0x148/0x=
3a4
[    5.578026] [eddafe30] c04350f0 ata_scsi_error+0x84/0xb4
[    5.597878] [eddafe60] c0410844 scsi_error_handler+0xa4/0x44c
[    5.618242] [eddafed0] c0038938 kthread+0xc8/0xcc
[    5.637383] [eddaff40] c000ad90 ret_from_kernel_thread+0x5c/0x64
[    5.657798] mon>  <no input ...>
[    7.675523] Oops: Kernel access of bad area, sig: 11 [#1]
[    7.695357] PREEMPT Canyonlands
[    7.712998] Modules linked in:
[    7.730338] CPU: 0 PID: 81 Comm: scsi_eh_0 Not tainted=20
4.4.0-rc5-Sam460ex #2
[    7.751933] task: edda85c0 ti: eddae000 task.ti: eddae000
[    7.771844] NIP: c043a2c8 LR: c0427c34 CTR: c043a210
[    7.791229] REGS: eddafae0 TRAP: 0300   Not tainted (4.4.0-rc5-Sam46=
0ex)
[    7.812519] MSR: 00021000 <CE,ME>  CR: 24000022  XER: 20000000
[    7.833197] DEAR: 00000000 ESR: 00000000
GPR00: c0427c34 eddafb90 edda85c0 00000000 00000000 00000000 ee3c1724=20
00000000
GPR08: ffffffff 00000004 00000002 eddafc10 22000022 00000000 00000001=20
c09314dc
GPR16: fafbfcfd 00000000 00000001 00000000 00000000 00029000 00000200=20
eddafc18
GPR24: 000000ec 00000000 00000000 edcba7d0 edcae200 00000000 ee3c0000=20
ee3c1700
[    7.939668] NIP [c043a2c8] sata_dwc_qc_issue+0xb8/0x204
[    7.959417] LR [c0427c34] ata_qc_issue+0x338/0x3a0
[    7.978735] Call Trace:
[    7.995605] [eddafb90] [00000006] 0x6 (unreliable)
[    8.015009] [eddafbe0] [c0427c34] ata_qc_issue+0x338/0x3a0
[    8.035078] [eddafc10] [c0427f0c] ata_exec_internal_sg+0x270/0x47c
[    8.055763] [eddafc80] [c042818c] ata_exec_internal+0x74/0x7c
[    8.075824] [eddafcc0] [c042839c] ata_dev_read_id+0x150/0x4e0
[    8.095822] [eddafd40] [c0434b4c] ata_eh_recover+0xfac/0x1088
[    8.115762] [eddafdd0] [c043516c] ata_do_eh+0x4c/0x9c
[    8.134973] [eddafe00] [c0434e10] ata_scsi_port_error_handler+0x148/=
0x3a4
[    8.155945] [eddafe30] [c04350f0] ata_scsi_error+0x84/0xb4
[    8.175503] [eddafe60] [c0410844] scsi_error_handler+0xa4/0x44c
[    8.195428] [eddafed0] [c0038938] kthread+0xc8/0xcc
[    8.214218] [eddaff40] [c000ad90] ret_from_kernel_thread+0x5c/0x64
[    8.234351] Instruction dump:
[    8.251202] 91010018 9121001c 39200000 99210030 39200040 807c0104=20
91210028 9121002c
[    8.273517] 39200004 91410008 91210020 91210024 <81230000> 81290084=20
2f890000 419e0010
[    8.296123] ---[ end trace 63c0d319677b6964 ]---
[    8.315133]
[    8.330746] note: scsi_eh_0[81] exited with preempt_count 1
[    8.402946] ata2.00: ATA-8: WDC WD5000AAKS-00V1A0, 05.01D05, max UDM=
A/133
[    8.444867] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/=
32)
[    8.474873] usb 1-1: new high-speed USB device number 2 using ppc-of=
-ehci
[    8.521159] ata2.00: configured for UDMA/100


[   11.324174] usb-storage 1-1.7:1.0: USB Mass Storage device detected
[   11.351056] scsi host3: usb-storage 1-1.7:1.0
[   12.377078] scsi 3:0:0:0: Direct-Access     Generic  Ultra HS-COMBO =
 =20
1.98 PQ: 0 ANSI: 0
[   12.406742] sd 3:0:0:0: Attached scsi generic sg0 type 0
[   12.434765] sd 3:0:0:0: [sda] Attached SCSI removable disk

Boot ends here and wont go any further.


