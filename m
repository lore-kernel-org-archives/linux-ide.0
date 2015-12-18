From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 14:27:52 +0000
Message-ID: <yw1xy4cral1z.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1x1tanffqg.fsf@unicorn.mansr.com>
	<1450364395.30729.136.camel@linux.intel.com>
	<yw1x60zxds5k.fsf@unicorn.mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<5673FD36.4050502@candw.ms> <yw1xa8p8apsw.fsf@unicorn.mansr.com>
	<56740F9F.5020500@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56740F9F.5020500@candw.ms> (Julian Margetson's message of "Fri,
	18 Dec 2015 09:52:31 -0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Julian Margetson <runaway@candw.ms> writes:

> On 12/18/2015 8:45 AM, M=E5ns Rullg=E5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>>>> Builds now. Using my own .config.
>>>> What changed?
>>> I may have messed up the patch initially .
>> Probably.  Let's pretend it never happened.
>>
>>>>> [    4.784199] sata-dwc 4bffd1000.sata: id 0, controller version =
1.82
>>>>> [    4.791186] scsi host0: sata-dwc
>>>>> [    4.794830] ata1: SATA max UDMA/133 irq 36
>>>>> [    4.799463] sata_sil 0001:00:04.0: Applying R_ERR on DMA activ=
ate FIS errata fix
>>>>> [    4.807959] scsi host1: sata_sil
>>>>> [    4.811662] scsi host2: sata_sil
>>>>> [    4.815242] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0=
xd84280080 irq 21
>>>>> [    4.822990] ata3: SATA max UDMA/100 mmio m512@0xd84280000 tf 0=
xd842800c0 irq 21
>>>>>
>>>>> [    5.143502] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
300)
>>>>> [    5.164367] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl =
310)
>>>>> [    5.185174] ppc-of-ohci 4bffd0000.usb: irq 32, io mem 0x4bffd0=
000
>>>>> [    5.206125] Unable to handle kernel paging request for data at=
 address 0x00000000
>>>>> [    5.228546] Faulting instruction address: 0xc043a2c8
>>>>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>>>>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
>>>> Well, that's not good.  Can you translate that address to a line o=
f code?
>>>>
>>> need some guidance on method .
>> Enable CONFIG_DEBUG_INFO, then use this command:
>>
>> $ addr2line -e vmlinux 0xc043a2c8
>>
>> Obviously substitute the actual crashing address if it changes.
>>
> addr2line -e vmlinux 0xc044b41c
> arch/powerpc/lib/copy_32.S:?

There's obviously a mismatch somewhere since we know that
sata_dwc_qc_issue isn't in copy_32.S.  Please post the full crash repor=
t
you got this address from.

--=20
M=E5ns Rullg=E5rd
