From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [PATCH 1/3] ata: sata_dwc_460ex: use "dmas" DT property to find dma channel
Date: Sun, 20 Dec 2015 18:49:34 +0000
Message-ID: <yw1xpoy16jlt.fsf@unicorn.mansr.com>
References: <1450221935-6034-1-git-send-email-mans@mansr.com>
	<yw1xtwnfad4y.fsf@unicorn.mansr.com> <56745BA4.1090607@candw.ms>
	<yw1xpoy39yl1.fsf@unicorn.mansr.com> <56748D85.4060108@candw.ms>
	<yw1xlh8r9wkm.fsf@unicorn.mansr.com>
	<CAHp75VfnTp=ob9reLuUSu-AaBwDhfJWKo1kjgNWnHuC5HgL=bw@mail.gmail.com>
	<567541EE.9010308@candw.ms> <yw1x60zua1ld.fsf@unicorn.mansr.com>
	<CAHp75Vdhpoqp2SeVz-MCbTVdG7V38hwW3wVCN0YPaoazyZNHOw@mail.gmail.com>
	<yw1xwpsa8j2x.fsf@unicorn.mansr.com> <56758F33.20804@candw.ms>
	<yw1xsi2y8ifa.fsf@unicorn.mansr.com> <5675A84F.2070208@candw.ms>
	<yw1xio3u8dgc.fsf@unicorn.mansr.com> <5675BB2F.6060107@candw.ms>
	<CAHp75VdVStVWpucOVkoZHkR3zz034LvRJMQpJk-eLhoA8pjGFg@mail.gmail.com>
	<yw1xegei893o.fsf@unicorn.mansr.com> <5675C452.2080206@candw.ms>
	<yw1xy4cp6o4o.fsf@unicorn.mansr.com> <5676E906.1060603@candw.ms>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from unicorn.mansr.com ([81.2.72.234]:52328 "EHLO unicorn.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbbLTStm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Dec 2015 13:49:42 -0500
In-Reply-To: <5676E906.1060603@candw.ms> (Julian Margetson's message of "Sun,
	20 Dec 2015 13:44:38 -0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Julian Margetson <runaway@candw.ms> writes:

> On 12/20/2015 1:11 PM, M=E5ns Rullg=E5rd wrote:
>> Julian Margetson <runaway@candw.ms> writes:
>>
>>> On 12/19/2015 4:41 PM, M=E5ns Rullg=E5rd wrote:
>>>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>>>
>>>>> On Sat, Dec 19, 2015 at 10:16 PM, Julian Margetson <runaway@candw=
=2Ems> wrote:
>>>>>> On 12/19/2015 3:07 PM, M=E5ns Rullg=E5rd wrote:
>>>>>>> Julian Margetson <runaway@candw.ms> writes:
>>>>>>>> Total pages: 522752
>>>>>>>> [    0.000000] Kernel command line: root=3D/dev/sda8 console=3D=
ttyS0,115200
>>>>>>>> console=3Dtty1 dw_dmac_core.dyndbg dw_dmac.dyndbg
>>>>>>> Please add ignore_log_level.
>>>>>>>
>>>>>> Had to truncate the kernel command line to add it.
>>>>> I guess M=E5ns meant 'ignore_loglevel'
>>>> Obviously.  I can never remember where the underscores go.
>>> [   18.362244] sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks:=
 (500 GB/465 GiB)
>>> [   18.372454] sd 3:0:0:0: Attached scsi generic sg3 type 0
>>> [   18.405433] sd 3:0:0:0: [sdc] Write Protect is off
>>> [   18.420654] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
>>> [   18.461731] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: =
enabled, doesn't support DPO or FUA
>>> [   18.502918] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: po=
rt=3D0 dma dir=3Dfrom device n_elem=3D1
>>> [   18.511807] dma dma0chan0: dwc_prep_slave_sg
>>> [   18.516083] dma dma0chan0: scanned 1 descriptors on freelist
>>> [   18.521753] sata-dwc 4bffd1000.sata: dma_dwc_xfer_setup sg: 0xed=
eaa800, count: 1 addr: 0xfffffffff6a14400
>>> [   18.531327] sata-dwc 4bffd1000.sata: sata_dwc_qc_issue: tag=3D0 =
ap->link.sactive =3D 0x00000001 sactive=3D0x00000001
>>> [   18.541359] sata-dwc 4bffd1000.sata: sata_dwc_exec_command_by_ta=
g cmd(0x60): READ FPDMA QUEUED tag=3D0
>>> [   18.553703] sata-dwc 4bffd1000.sata: sata_dwc_isr intpr=3D0x0000=
0082 active_tag=3D-84148995
>>> [   18.561717] sata-dwc 4bffd1000.sata: sata_dwc_isr: NEWFP tag=3D0
>>> [   18.567561] sata-dwc 4bffd1000.sata: sata_dwc_bmdma_start_by_tag=
 qc=3Ded2340b8 tag: 0 cmd: 0x60 dma_dir: from device start_dma? 1
>>> [   18.579043] sata-dwc 4bffd1000.sata: taskfile cmd: 0x60 protocol=
: ATA NCQ flags: 0x17 device: 40
>>> [   18.587836] sata-dwc 4bffd1000.sata: feature: 0x08 nsect: 0x0 lb=
al: 0x0 lbam: 0x0 lbah: 0x0
>>> [   18.596196] sata-dwc 4bffd1000.sata: hob_feature: 0x00 hob_nsect=
: 0x0 hob_lbal: 0x0 hob_lbam: 0x0 hob_lbah: 0x0
>>> [   18.606292] dma dma0chan0: dwc_tx_submit: queued 2
>>> [   18.611091] dma dma0chan0: dwc_dostart_first_queued: started 2
>>> [   48.748614] ata3: lost interrupt (Status 0x40)
>> Now we're getting somewhere.  The dma transfer is set up and initiat=
ed,
>> but then nothing happens.  Comparing the old sata_dwc driver, from
>> before the switch to dmaengine, with the dw_dma driver, I noticed an
>> obvious problem: the descriptors are filled in using the wrong byte
>> order.  This patch might fix that.
>
> [   18.534844] ata3.00: configured for UDMA/133
> [   18.538182] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5000AAK=
S-0 3B01 PQ: 0 ANSI: 5
> [   18.539025] sd 3:0:0:0: [sdc] 976773168 512-byte logical blocks: (=
500 GB/465 GiB)
> [   18.539236] sd 3:0:0:0: [sdc] Write Protect is off
> [   18.539245] sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> [   18.539338] sd 3:0:0:0: [sdc] Write cache: enabled, read cache: en=
abled, doesn't support DPO or FUA
> [   18.540049] sd 3:0:0:0: Attached scsi generic sg3 type 0
> [   18.540362] sata-dwc 4bffd1000.sata: sata_dwc_qc_prep_by_tag: port=
=3D0 dma dir=3Dfrom device n_elem=3D1
> [   18.540370] dma dma0chan0: dwc_prep_slave_sg
> [   18.540378] dma dma0chan0: scanned 1 descriptors on freelist
> [   18.540387] sata-dwc 4bffd1000.sata: dma_dwc_xfer_setup sg: 0xed37=
f200, count: 1 addr: 0xfffffffff6a18400
> [   18.540395] sata-dwc 4bffd1000.sata: sata_dwc_qc_issue: tag=3D0 ap=
->link.sactive =3D 0x00000001 sactive=3D0x00000001
> [   18.540426] sata-dwc 4bffd1000.sata: sata_dwc_exec_command_by_tag =
cmd(0x60): READ FPDMA QUEUED tag=3D0
> [   18.556592] sata-dwc 4bffd1000.sata: sata_dwc_isr intpr=3D0x000000=
82 active_tag=3D-84148995
> [   18.556599] sata-dwc 4bffd1000.sata: sata_dwc_isr: NEWFP tag=3D0
> [   18.556609] sata-dwc 4bffd1000.sata: sata_dwc_bmdma_start_by_tag q=
c=3Ded2180b8 tag: 0 cmd: 0x60 dma_dir: from device start_dma? 1
> [   18.556616] sata-dwc 4bffd1000.sata: taskfile cmd: 0x60 protocol: =
ATA NCQ flags: 0x17 device: 40
> [   18.556623] sata-dwc 4bffd1000.sata: feature: 0x08 nsect: 0x0 lbal=
: 0x0 lbam: 0x0 lbah: 0x0
> [   18.556631] sata-dwc 4bffd1000.sata: hob_feature: 0x00 hob_nsect: =
0x0 hob_lbal: 0x0 hob_lbam: 0x0 hob_lbah: 0x0
> [   18.556639] dma dma0chan0: dwc_tx_submit: queued 2
> [   18.556646] dma dma0chan0: dwc_dostart_first_queued: started 2
> [   48.748634] ata3: lost interrupt (Status 0x40)
> [   48.753465] sata-dwc 4bffd1000.sata: sata_dwc_scr_read: id=3D3 reg=
=3D1 val=3Dval=3D0x00000000
> [   48.761369] ata3.00: exception Emask 0x0 SAct 0x1 SErr 0x0 action =
0x6 frozen
> [   48.769671] ata3.00: failed command: READ FPDMA QUEUED

Well, that didn't help.  I still think it's part of the problem, but
something else must be wrong as well.  The various Master Select fields
look like a good place to start.  Also, the manual says the LLP_SRC_EN
and LLP_DST_EN flags should be cleared on the last in a chain of blocks=
=2E
The old sata_dwc driver does this whereas dw_dma does not.

It might be worthwhile to try reverting drivers/ata/sata_dwc_460ex.c to
v4.0 (leaving the rest at 4.4-rc5) just to make sure that's a good
reference.  I've verified that this builds.

--=20
M=E5ns Rullg=E5rd
