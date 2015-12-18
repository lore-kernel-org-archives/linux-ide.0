From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Fri, 18 Dec 2015 23:16:41 +0000
Message-ID: <yw1xlh8r9wkm.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<1450367702.30729.146.camel@linux.intel.com>
	<yw1xk2odcb87.fsf@unicorn.mansr.com>
	<1450371184.30729.175.camel@linux.intel.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:49107 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbbLRXQo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2015 18:16:44 -0500
In-Reply-To: <56748D85.4060108@candw.ms> (Julian Margetson's message of "Fri,
	18 Dec 2015 18:49:41 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Julian Margetson <runaway@candw.ms> writes:

> On 12/18/2015 6:33 PM, M=E5ns Rullg=E5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>> On 12/18/2015 1:18 PM, M=E5ns Rullg=E5rd wrote:
>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>
>>>>> On 12/18/2015 8:49 AM, M=E5ns Rullg=E5rd wrote:
>>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>>>>
>>>>>>>>> [    5.206125] Unable to handle kernel paging request for dat=
a at
>>>>>>>>> address 0x00000000
>>>>>>>>> [    5.228546] Faulting instruction address: 0xc043a2c8
>>>>>>>>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>>>>>>>>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x204
>>>>>>>> Well, that's not good.  Can you translate that address to a li=
ne of
>>>>>>>> code?
>>>>>>> Besides that, can you enable DYNAMIC_DEBUG in the config and ap=
pend
>>>>>>> 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?
>>>>>> Enabling debug messages in the sata_dwc driver might also be inf=
ormative.
>>>>>>
>>>>> Changed the sata-dwc to a module .
>>>>>
>>>>> [   18.475140] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: =
dma_dwc_xfer_setup returns NULL
>>>>> [   18.535698] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: =
dma_dwc_xfer_setup returns NULL
>>>> That's strange.  The only way that can happen is if
>>>> dmaengine_prep_slave_sg() return NULL, and that really shouldn't b=
e
>>>> happening.  Did you turn on debug messages in dw_dma?  You can ena=
ble
>>>> some extra debug messages by adding "#define VERBOSE_DEBUG" at the=
 top
>>>> of drivers/dma/dw/core.c
>>>>
>>> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dm=
a_dwc_xfer_setup returns NULL
>>> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dm=
a_dwc_xfer_setup returns NULL
>>> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dm=
a_dwc_xfer_setup returns NULL
>> Could you post the entire kernel log?  There might be important
>> information before the errors start.
>>
>
>
> =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D PuTTY log 2015.12.18 =
15:01:48 =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-VirtualB=
ox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #8 PREEMPT Fri Dec 18=
 13:36:34 AST 2015
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
115200 console=3Dtty0 dw_dmac_core.dyndbg dw_dmac.dyndbg

[...]

> [   13.643415] systemd[1]: Mounted Configuration File System.
> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_=
dwc_xfer_setup returns NULL
> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_=
dwc_xfer_setup returns NULL
> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: dma_=
dwc_xfer_setup returns NULL

This log is weird.  The sata_dwc_probe() function prints several things
(one using dev_notice()), for instance this:

	/* Read the ID and Version Registers */
	idr =3D in_le32(&hsdev->sata_dwc_regs->idr);
	versionr =3D in_le32(&hsdev->sata_dwc_regs->versionr);
	dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c\n",
		   idr, ver[0], ver[1], ver[2]);

The dw_dma_probe() function also prints a line:

	dev_info(chip->dev, "DesignWare DMA Controller, %d channels\n",
		 pdata->nr_channels);

These messages are nowhere to be seen in your log, nor are numerous
others that really must appear before before sata_dwc_qc_prep_by_tag()
can be called.

I'd like to note that the driver works on my Sigma Designs based system
using a different DMA controller, so it's not completely broken.  The
DMA driver could still be faulty, but that still doesn't explain the
missing kernel messages.

--=20
M=E5ns Rullg=E5rd
