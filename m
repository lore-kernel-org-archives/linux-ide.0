From: Mark Lord <liml@rtr.ca>
Subject: Re: BUG() with MV88SX6081 and other problems
Date: Wed, 21 Jun 2006 00:04:20 -0400
Message-ID: <4498C544.7080907@rtr.ca>
References: <20060617191703.45e6f348@localhost> <87f94c370606201053l55f85236kf7f3c1177c49a576@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:9104 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751978AbWFUEEV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Jun 2006 00:04:21 -0400
In-Reply-To: <87f94c370606201053l55f85236kf7f3c1177c49a576@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Freemyer <greg.freemyer@gmail.com>
Cc: Tom Wirschell <linux-ide@wirschell.nl>, linux-ide@vger.kernel.org

Greg Freemyer wrote:
> Mark,
> 
> Can you give an update of where the Marvell driver stands
> "experimental" vs. functional and if BUG() calls like below are still
> expected in 2.6.17 release?
> 
> Thanks
> Greg
> 
> On 6/17/06, Tom Wirschell <linux-ide@wirschell.nl> wrote:
>> I'm using the 2.6.17-rc6-mm2 kernel on a system with the following
>> components:
>> Asus PSCH-L Mobo (e7210+6300ESB)
>> Intel P4 3.0GHz, HT enabled
>> SuperMicro AOC-SAT2-MV8 (MV88SX6081)
>> Antec TruePower II 550Watt power supply
>> 2x Western Digital Caviar SE 2000JB (PATA)
>> 9x Western Digital Caviar 2000JD (SATA)
>> APC Back-UPS CS 650
>>
>> I've got an issue with this config when running in RAID mode, but I'll
>> get to that in a bit. First off, when I boot up, the Marvell chip spits
>> out the following BUG:
>>
>> sata_mv 0000:02:02.0: version 0.7
>> sata_mv 0000:02:02.0: 32 slots 8 ports SCSI mode IRQ via INTx
>> ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF88A2120 bmdma 0x0 irq 24
>> ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF88A4120 bmdma 0x0 irq 24
>> ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF88A6120 bmdma 0x0 irq 24
>> ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF88A8120 bmdma 0x0 irq 24
>> ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF88B2120 bmdma 0x0 irq 24
>> ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF88B4120 bmdma 0x0 irq 24
>> ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF88B6120 bmdma 0x0 irq 24
>> ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF88B8120 bmdma 0x0 irq 24
>> ata3: no device found (phy stat 00000000)
>> scsi2 : sata_mv
>> BUG: warning at drivers/scsi/sata_mv.c:1921/__msleep()
>>  [<c02587a2>] __mv_phy_reset+0x3b1/0x3b6
>>  [<c0259266>] mv_scr_write+0xe/0x40
>>  [<c0258861>] mv_err_intr+0x80/0xa7
>>  [<c02590bb>] mv_interrupt+0x2d8/0x3e0
>>  [<c0135af8>] handle_IRQ_event+0x2e/0x5a
>>  [<c0136b85>] handle_fasteoi_irq+0x61/0x9e
>>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>>  [<c0104a16>] do_IRQ+0x55/0x81
>>  =======================
>>  [<c0102ce6>] common_interrupt+0x1a/0x20
>>  [<c01017f7>] mwait_idle+0x29/0x42
>>  [<c01017b9>] cpu_idle+0x5e/0x73
>>  [<c039271a>] start_kernel+0x2ff/0x375
>>  [<c03921bc>] unknown_bootoption+0x0/0x25f
..

The sata_mv driver is still marked as EXPERIMENTAL in the kernel config,
but I believe it should be darned close to production-usable.

I really don't understand the traceback above -- that's not a possible
calling sequence in the source code.  You do have frame-pointers
enabled in the kernel .config, right?  Weird.

>> ata10: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>> ata10: status=0xd0 { Busy }
>> ata10: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
>> ata10: status=0xd0 { Busy }
>> BUG: warning at drivers/scsi/sata_mv.c:1233/mv_qc_issue()
>>  [<c0258db3>] mv_qc_issue+0xf3/0x123
>>  [<c024fa39>] ata_qc_issue+0xa9/0x4f3
>>  [<c02549d2>] ata_scsi_rw_xlat+0x247/0x3af
>>  [<c0242b73>] scsi_done+0x0/0x16
>>  [<c0253aeb>] ata_scsi_translate+0x6e/0x122
>>  [<c0254420>] ata_scsi_queuecmd+0x56/0x126
>>  [<c025478b>] ata_scsi_rw_xlat+0x0/0x3af
>>  [<c0242b73>] scsi_done+0x0/0x16
>>  [<c0243491>] scsi_dispatch_cmd+0x169/0x310
>>  [<c0248694>] scsi_request_fn+0x1bf/0x350
>>  [<c01fd71c>] blk_run_queue+0x58/0x70
>>  [<c0247ca3>] scsi_queue_insert+0x6d/0xa6
>>  [<c01fe0fe>] blk_done_softirq+0x54/0x61
>>  [<c011e24d>] __do_softirq+0x75/0xdc
>>  [<c0104a95>] do_softirq+0x53/0x9e
>>  =======================
>>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>>  [<c0104a1d>] do_IRQ+0x5c/0x81
>>  [<c0102ce6>] common_interrupt+0x1a/0x20
>>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d
>> BUG: warning at drivers/scsi/sata_mv.c:649/mv_start_dma()
>>  [<c0258dde>] mv_qc_issue+0x11e/0x123
>>  [<c024fa39>] ata_qc_issue+0xa9/0x4f3
>>  [<c02549d2>] ata_scsi_rw_xlat+0x247/0x3af
>>  [<c0242b73>] scsi_done+0x0/0x16
>>  [<c0253aeb>] ata_scsi_translate+0x6e/0x122
>>  [<c0254420>] ata_scsi_queuecmd+0x56/0x126
>>  [<c025478b>] ata_scsi_rw_xlat+0x0/0x3af
>>  [<c0242b73>] scsi_done+0x0/0x16
>>  [<c0243491>] scsi_dispatch_cmd+0x169/0x310
>>  [<c0248694>] scsi_request_fn+0x1bf/0x350
>>  [<c01fd71c>] blk_run_queue+0x58/0x70
>>  [<c0247ca3>] scsi_queue_insert+0x6d/0xa6
>>  [<c01fe0fe>] blk_done_softirq+0x54/0x61
>>  [<c011e24d>] __do_softirq+0x75/0xdc
>>  [<c0104a95>] do_softirq+0x53/0x9e
>>  =======================
>>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>>  [<c0104a1d>] do_IRQ+0x5c/0x81
>>  [<c0102ce6>] common_interrupt+0x1a/0x20
>>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d

Another really messed up traceback.  Can you turn on a few
more kernel options to make this readable, please?
Like CONFIG_FRAME_POINTER=y and CONFIG_UNWIND_INFO=y
and anything else that looks good .  :)

Thanks
