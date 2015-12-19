From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Sat, 19 Dec 2015 15:40:30 +0000
Message-ID: <yw1x60zua1ld.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<5672F77F.4010306@candw.ms> <yw1xfuz1c5xy.fsf@unicorn.mansr.com>
	<567302E8.5050303@candw.ms> <yw1x7fkcdi2a.fsf@unicorn.mansr.com>
	<5673061A.4070700@candw.ms> <yw1x37v0df86.fsf@unicorn.mansr.com>
	<56732C04.9040100@candw.ms> <yw1xvb7wbowu.fsf@unicorn.mansr.com>
	<5673F277.2050607@candw.ms> <yw1xegekarp9.fsf@unicorn.mansr.com>
	<1450441395.30729.203.camel@linux.intel.com>
	<yw1x37uzc45t.fsf@unicorn.mansr.com> <5674271B.9090308@candw.ms>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:50322 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbbLSPkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Dec 2015 10:40:33 -0500
In-Reply-To: <567541EE.9010308@candw.ms> (Julian Margetson's message of "Sat,
	19 Dec 2015 07:39:26 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Julian Margetson <runaway@candw.ms> writes:

> On 12/18/2015 10:34 PM, Andy Shevchenko wrote:
>> On Sat, Dec 19, 2015 at 1:16 AM, M=E5ns Rullg=E5rd <mans@mansr.com> =
wrote:
>>> Julian Margetson <runaway@candw.ms> writes:
>>>
>>>> On 12/18/2015 6:33 PM, M=E5ns Rullg=E5rd wrote:
>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>
>>>>>> On 12/18/2015 1:18 PM, M=E5ns Rullg=E5rd wrote:
>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>
>>>>>>>> On 12/18/2015 8:49 AM, M=E5ns Rullg=E5rd wrote:
>>>>>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>>>>>>>>>
>>>>>>>>>>>> [    5.206125] Unable to handle kernel paging request for =
data at
>>>>>>>>>>>> address 0x00000000
>>>>>>>>>>>> [    5.228546] Faulting instruction address: 0xc043a2c8
>>>>>>>>>>>> [    5.248577] Vector: 300 (Data Access) at [eddafae0]
>>>>>>>>>>>> [    5.268658]     pc: c043a2c8: sata_dwc_qc_issue+0xb8/0x=
204
>>>>>>>>>>> Well, that's not good.  Can you translate that address to a=
 line of
>>>>>>>>>>> code?
>>>>>>>>>> Besides that, can you enable DYNAMIC_DEBUG in the config and=
 append
>>>>>>>>>> 'dw_dmac_core.dyndbg dw_dmac.dyndbg' to the kernel cmdline?
>>>>>>>>> Enabling debug messages in the sata_dwc driver might also be =
informative.
>>>>>>>>>
>>>>>>>> Changed the sata-dwc to a module .
>>>>>>>>
>>>>>>>> [   18.475140] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_ta=
g: dma_dwc_xfer_setup returns NULL
>>>>>>>> [   18.535698] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_ta=
g: dma_dwc_xfer_setup returns NULL
>>>>>>> That's strange.  The only way that can happen is if
>>>>>>> dmaengine_prep_slave_sg() return NULL, and that really shouldn'=
t be
>>>>>>> happening.  Did you turn on debug messages in dw_dma?  You can =
enable
>>>>>>> some extra debug messages by adding "#define VERBOSE_DEBUG" at =
the top
>>>>>>> of drivers/dma/dw/core.c
>>>>>>>
>>>>>> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag:=
 dma_dwc_xfer_setup returns NULL
>>>>>> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag:=
 dma_dwc_xfer_setup returns NULL
>>>>>> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag:=
 dma_dwc_xfer_setup returns NULL
>>>>> Could you post the entire kernel log?  There might be important
>>>>> information before the errors start.
>>>>>
>>>>
>>>> =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D PuTTY log 2015.12.=
18 15:01:48 =3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D~=3D
>>>> [    0.000000] Using Canyonlands machine description
>>>> [    0.000000] Initializing cgroup subsys cpu
>>>> [    0.000000] Linux version 4.4.0-rc5-Sam460ex (root@julian-Virtu=
alBox) (gcc version 4.8.2 (Ubuntu 4.8.2-16ubuntu3) ) #8 PREEMPT Fri Dec=
 18 13:36:34 AST 2015
>>>> [    0.000000] Zone ranges:
>>>> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffff=
ff]
>>>> [    0.000000]   Normal   empty
>>>> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffff=
ff]
>>>> [    0.000000] Movable zone start for each node
>>>> [    0.000000] Early memory node ranges
>>>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007ffff=
fff]
>>>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000=
00007fffffff]
>>>> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 c=
ontexts
>>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping =
on.  Total pages: 522752
>>>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3Dtty=
S0,115200 console=3Dtty0 dw_dmac_core.dyndbg dw_dmac.dyndbg
>> I would suggest to use console=3Dtty1 instead of console=3Dtty0.
>>
>>> [...]
>>>
>>>> [   13.643415] systemd[1]: Mounted Configuration File System.
>>>> [   17.526173] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>>> [   17.600124] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>>> [   17.662978] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: d=
ma_dwc_xfer_setup returns NULL
>>> This log is weird.  The sata_dwc_probe() function prints several th=
ings
>>> (one using dev_notice()), for instance this:
>>>
>>>          /* Read the ID and Version Registers */
>>>          idr =3D in_le32(&hsdev->sata_dwc_regs->idr);
>>>          versionr =3D in_le32(&hsdev->sata_dwc_regs->versionr);
>>>          dev_notice(&ofdev->dev, "id %d, controller version %c.%c%c=
\n",
>>>                     idr, ver[0], ver[1], ver[2]);
>>>
>>> The dw_dma_probe() function also prints a line:
>>>
>>>          dev_info(chip->dev, "DesignWare DMA Controller, %d channel=
s\n",
>>>                   pdata->nr_channels);
>>>
>>> These messages are nowhere to be seen in your log, nor are numerous
>>> others that really must appear before before sata_dwc_qc_prep_by_ta=
g()
>>> can be called.
>>>
>> It would be better to add 'ignore_loglevel' to the cmdline as well.

OK, I've found something.  The dma setup errors are benign, caused by
the driver calling dmaengine_prep_slave_sg() even for non-dma
operations.  The real error is the lock recursion that's reported
later.  I wasn't seeing it since I was running a UP non-preempt kernel.
With lock debugging enabled, I get the same error.  This patch should
fix it.

---8<---
=46rom 94c4769d2171ce66079fd486a45e09dd64db62c0 Mon Sep 17 00:00:00 200=
1
=46rom: Mans Rullgard <mans@mansr.com>
Date: Sat, 19 Dec 2015 15:26:23 +0000
Subject: [PATCH] ata: sata_dwc_460ex: remove incorrect locking

This lock is already taken in ata_scsi_queuecmd() a few levels up the
call stack so attempting to take it here is an error.  Moreover, it is
pointless in the first place since it only protects a single, atomic
assignment.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.=
c
index 799df86..5696f39 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1001,16 +1001,14 @@ static void sata_dwc_exec_command_by_tag(struct=
 ata_port *ap,
 					 struct ata_taskfile *tf,
 					 u8 tag, u32 cmd_issued)
 {
-	unsigned long flags;
 	struct sata_dwc_device_port *hsdevp =3D HSDEVP_FROM_AP(ap);
 	struct sata_dwc_device *hsdev =3D HSDEV_FROM_AP(ap);
=20
 	dev_dbg(ap->dev, "%s cmd(0x%02x): %s tag=3D%d\n", __func__, tf->comma=
nd,
 		ata_get_cmd_descript(tf->command), tag);
=20
-	spin_lock_irqsave(&ap->host->lock, flags);
 	hsdevp->cmd_issued[tag] =3D cmd_issued;
-	spin_unlock_irqrestore(&ap->host->lock, flags);
+
 	/*
 	 * Clear SError before executing a new command.
 	 * sata_dwc_scr_write and read can not be used here. Clearing the PM
--=20
2.6.3

--=20
M=E5ns Rullg=E5rd
