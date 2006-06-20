From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: BUG() with MV88SX6081 and other problems
Date: Tue, 20 Jun 2006 13:53:12 -0400
Message-ID: <87f94c370606201053l55f85236kf7f3c1177c49a576@mail.gmail.com>
References: <20060617191703.45e6f348@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:51191 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750742AbWFTRxO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 13:53:14 -0400
Received: by nf-out-0910.google.com with SMTP id y25so1453343nfb
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 10:53:13 -0700 (PDT)
In-Reply-To: <20060617191703.45e6f348@localhost>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Wirschell <linux-ide@wirschell.nl>
Cc: linux-ide@vger.kernel.org

Mark,

Can you give an update of where the Marvell driver stands
"experimental" vs. functional and if BUG() calls like below are still
expected in 2.6.17 release?

Thanks
Greg

On 6/17/06, Tom Wirschell <linux-ide@wirschell.nl> wrote:
> I'm using the 2.6.17-rc6-mm2 kernel on a system with the following
> components:
> Asus PSCH-L Mobo (e7210+6300ESB)
> Intel P4 3.0GHz, HT enabled
> SuperMicro AOC-SAT2-MV8 (MV88SX6081)
> Antec TruePower II 550Watt power supply
> 2x Western Digital Caviar SE 2000JB (PATA)
> 9x Western Digital Caviar 2000JD (SATA)
> APC Back-UPS CS 650
>
> I've got an issue with this config when running in RAID mode, but I'll
> get to that in a bit. First off, when I boot up, the Marvell chip spits
> out the following BUG:
>
> sata_mv 0000:02:02.0: version 0.7
> sata_mv 0000:02:02.0: 32 slots 8 ports SCSI mode IRQ via INTx
> ata3: SATA max UDMA/133 cmd 0x0 ctl 0xF88A2120 bmdma 0x0 irq 24
> ata4: SATA max UDMA/133 cmd 0x0 ctl 0xF88A4120 bmdma 0x0 irq 24
> ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF88A6120 bmdma 0x0 irq 24
> ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF88A8120 bmdma 0x0 irq 24
> ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF88B2120 bmdma 0x0 irq 24
> ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF88B4120 bmdma 0x0 irq 24
> ata9: SATA max UDMA/133 cmd 0x0 ctl 0xF88B6120 bmdma 0x0 irq 24
> ata10: SATA max UDMA/133 cmd 0x0 ctl 0xF88B8120 bmdma 0x0 irq 24
> ata3: no device found (phy stat 00000000)
> scsi2 : sata_mv
> BUG: warning at drivers/scsi/sata_mv.c:1921/__msleep()
>  [<c02587a2>] __mv_phy_reset+0x3b1/0x3b6
>  [<c0259266>] mv_scr_write+0xe/0x40
>  [<c0258861>] mv_err_intr+0x80/0xa7
>  [<c02590bb>] mv_interrupt+0x2d8/0x3e0
>  [<c0135af8>] handle_IRQ_event+0x2e/0x5a
>  [<c0136b85>] handle_fasteoi_irq+0x61/0x9e
>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>  [<c0104a16>] do_IRQ+0x55/0x81
>  =======================
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c01017f7>] mwait_idle+0x29/0x42
>  [<c01017b9>] cpu_idle+0x5e/0x73
>  [<c039271a>] start_kernel+0x2ff/0x375
>  [<c03921bc>] unknown_bootoption+0x0/0x25f
> ata4.00: cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003
> 88:407f ata4.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
> ata4.00: configured for UDMA/133
> scsi3 : sata_mv
> ata5.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
> 88:203f ata5.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata5.00: configured for UDMA/100
> scsi4 : sata_mv
> ata6.00: cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003
> 88:407f ata6.00: ATA-6, max UDMA/133, 390721968 sectors: LBA48
> ata6.00: configured for UDMA/133
> scsi5 : sata_mv
> ata7.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
> 88:203f ata7.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata7.00: configured for UDMA/100
> scsi6 : sata_mv
> ata8.00: cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003
> 88:203f ata8.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata8.00: configured for UDMA/100
> scsi7 : sata_mv
> ata9.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003
> 88:203f ata9.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata9.00: configured for UDMA/100
> scsi8 : sata_mv
> ata10.00: cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003
> 88:203f ata10.00: ATA-6, max UDMA/100, 390721968 sectors: LBA48
> ata10.00: configured for UDMA/100
> scsi9 : sata_mv
>   Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-22K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-22K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-60K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-00K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>   Vendor: ATA       Model: WDC WD2000JD-60K  Rev: 08.0
>   Type:   Direct-Access                      ANSI SCSI revision: 05
>
> It seems minor though, as the system just keeps going without any sign
> of trouble.
>
> My plan with this machine is to run a poor-man's RAID5 array on it using
> these harddisks. I'm running the 2 PATA drives plus 2 SATA drives off
> the Intel 6300ESB chipset. The remaining 7 drives (8 once I get it
> stable) are to run off this Marvell chip.
>
> The problem is that for some strange reason after a varying amount of
> time one of the SATA drives in the array out of the blue decides to
> power off. There's nothing in the SMART log of the drive or anything,
> it just up and quits.
> I've asked some Western Digital support people who basically tell me my
> RAID card is being too impatient and shutting down the drive when it
> takes too long to respond, and that I should've bought their Raid
> Edition drives. Never mind of course that I'm using software RAID as
> the array spans 2 very different controllers, one of which isn't even
> hardware RAID capable.
> I've then asked the dm-devel list, but the people there didn't have an
> explanation for why this would happen either.
>
> The motherboard has a Promise S150 TX4 controller for 4 additional SATA
> ports and I had initially bought a separate PCI-X S150 TX4 controller
> card to be able to drive another 4 drives for the array. The powering
> down problem was happening on this setup aswell, but when it happened
> it was a lot more messy than with this Marvel card. The system would
> lock up and not respond to anything anymore. If people are interested,
> I'd be happy to setup that config and rerun my test. It's 100%
> reproducible within 24 hours.
>
> My test that has so far been 100% effective at triggering this problem.
> What I do is this: I create a degraded RAID array using all SATA drives
> and 1 PATA drive (need the other PATA drive for the OS for now), and
> then copy over 200 gigs of data from another machine at about 20 MB/s.
> About 60% of the time that's all it takes. If the array is still going
> strong, I then make copies of this 200 gb set of files until I fill up
> the array or a drive dies. So far I've never managed to get past 4
> copies.
>
> Once one of the drives dies the following ends up in the logs:
>
> ata10: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata10: status=0xd0 { Busy }
> ata10: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata10: status=0xd0 { Busy }
> BUG: warning at drivers/scsi/sata_mv.c:1233/mv_qc_issue()
>  [<c0258db3>] mv_qc_issue+0xf3/0x123
>  [<c024fa39>] ata_qc_issue+0xa9/0x4f3
>  [<c02549d2>] ata_scsi_rw_xlat+0x247/0x3af
>  [<c0242b73>] scsi_done+0x0/0x16
>  [<c0253aeb>] ata_scsi_translate+0x6e/0x122
>  [<c0254420>] ata_scsi_queuecmd+0x56/0x126
>  [<c025478b>] ata_scsi_rw_xlat+0x0/0x3af
>  [<c0242b73>] scsi_done+0x0/0x16
>  [<c0243491>] scsi_dispatch_cmd+0x169/0x310
>  [<c0248694>] scsi_request_fn+0x1bf/0x350
>  [<c01fd71c>] blk_run_queue+0x58/0x70
>  [<c0247ca3>] scsi_queue_insert+0x6d/0xa6
>  [<c01fe0fe>] blk_done_softirq+0x54/0x61
>  [<c011e24d>] __do_softirq+0x75/0xdc
>  [<c0104a95>] do_softirq+0x53/0x9e
>  =======================
>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d
> BUG: warning at drivers/scsi/sata_mv.c:649/mv_start_dma()
>  [<c0258dde>] mv_qc_issue+0x11e/0x123
>  [<c024fa39>] ata_qc_issue+0xa9/0x4f3
>  [<c02549d2>] ata_scsi_rw_xlat+0x247/0x3af
>  [<c0242b73>] scsi_done+0x0/0x16
>  [<c0253aeb>] ata_scsi_translate+0x6e/0x122
>  [<c0254420>] ata_scsi_queuecmd+0x56/0x126
>  [<c025478b>] ata_scsi_rw_xlat+0x0/0x3af
>  [<c0242b73>] scsi_done+0x0/0x16
>  [<c0243491>] scsi_dispatch_cmd+0x169/0x310
>  [<c0248694>] scsi_request_fn+0x1bf/0x350
>  [<c01fd71c>] blk_run_queue+0x58/0x70
>  [<c0247ca3>] scsi_queue_insert+0x6d/0xa6
>  [<c01fe0fe>] blk_done_softirq+0x54/0x61
>  [<c011e24d>] __do_softirq+0x75/0xdc
>  [<c0104a95>] do_softirq+0x53/0x9e
>  =======================
>  [<c0136b24>] handle_fasteoi_irq+0x0/0x9e
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d
> ata10: no device found (phy stat 00000000)
> ata10: translated ATA stat/err 0x7f/00 to SCSI SK/ASC/ASCQ 0x4/00/00
> ata10: status=0x7f { DriveReady DeviceFault SeekComplete DataRequest
> CorrectedError Index Error } sd 9:0:0:0: SCSI error: return code =
> 0x8000002 sdi: Current: sense key: Hardware Error
>     Additional sense: No additional sense information
> end_request: I/O error, dev sdi, sector 97727380
> raid5: Disk failure on sdi2, disabling device. Operation continuing on
> 9 devices sd 9:0:0:0: SCSI error: return code = 0x40000
> end_request: I/O error, dev sdi, sector 97727388
>
> If I then unmount the md0 device and stop it with mdadm I see the
> following repeated in the logs for each drive in the array:
> md: unbind<sdi2>
> md: export_rdev(sdi2)
> BUG: warning at fs/block_dev.c:1109/__blkdev_put()
>  [<c015c3c4>] __blkdev_put+0x16b/0x1ae
>  [<c027e171>] export_rdev+0x71/0x7e
>  [<c027e17e>] unbind_rdev_from_array+0x0/0x8b
>  [<c027e211>] kick_rdev_from_array+0x8/0x10
>  [<c027e23c>] export_array+0x23/0x91
>  [<c027fe38>] do_md_stop+0x1e2/0x2f7
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0283dda>] md_ioctl+0x688/0x164e
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c028007b>] do_md_run+0x12e/0x7a0
>  [<c015c73e>] do_open+0x227/0x377
>  [<c016165e>] do_lookup+0x47/0x132
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c01ff178>] blkdev_driver_ioctl+0x55/0x5e
>  [<c01ff43c>] blkdev_ioctl+0x2bb/0x78f
>  [<c0153895>] get_unused_fd+0x53/0xb8
>  [<c01637d8>] do_path_lookup+0xac/0x237
>  [<c0140320>] readahead_cache_hit+0x22/0x6f
>  [<c013a8a1>] filemap_nopage+0x40c/0x4fb
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c015d95e>] cp_new_stat64+0xfd/0x10f
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c015bd55>] block_ioctl+0x18/0x1d
>  [<c015bd3d>] block_ioctl+0x0/0x1d
>  [<c016557f>] do_ioctl+0x1f/0x6d
>  [<c016561d>] vfs_ioctl+0x50/0x279
>  [<c015618d>] fget_light+0xb/0x70
>  [<c016587a>] sys_ioctl+0x34/0x52
>  [<c02e80b7>] syscall_call+0x7/0xb
>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d
> BUG: warning at fs/block_dev.c:1128/__blkdev_put()
>  [<c015c402>] __blkdev_put+0x1a9/0x1ae
>  [<c027e171>] export_rdev+0x71/0x7e
>  [<c027e17e>] unbind_rdev_from_array+0x0/0x8b
>  [<c027e211>] kick_rdev_from_array+0x8/0x10
>  [<c027e23c>] export_array+0x23/0x91
>  [<c027fe38>] do_md_stop+0x1e2/0x2f7
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0283dda>] md_ioctl+0x688/0x164e
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c028007b>] do_md_run+0x12e/0x7a0
>  [<c015c73e>] do_open+0x227/0x377
>  [<c016165e>] do_lookup+0x47/0x132
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c0102ce6>] common_interrupt+0x1a/0x20
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c01ff178>] blkdev_driver_ioctl+0x55/0x5e
>  [<c01ff43c>] blkdev_ioctl+0x2bb/0x78f
>  [<c0153895>] get_unused_fd+0x53/0xb8
>  [<c01637d8>] do_path_lookup+0xac/0x237
>  [<c0140320>] readahead_cache_hit+0x22/0x6f
>  [<c013a8a1>] filemap_nopage+0x40c/0x4fb
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c015d95e>] cp_new_stat64+0xfd/0x10f
>  [<c0104a1d>] do_IRQ+0x5c/0x81
>  [<c015bd55>] block_ioctl+0x18/0x1d
>  [<c015bd3d>] block_ioctl+0x0/0x1d
>  [<c016557f>] do_ioctl+0x1f/0x6d
>  [<c016561d>] vfs_ioctl+0x50/0x279
>  [<c015618d>] fget_light+0xb/0x70
>  [<c016587a>] sys_ioctl+0x34/0x52
>  [<c02e80b7>] syscall_call+0x7/0xb
>  [<c02e007b>] xfrm_sk_policy_lookup+0x1ba/0x34d
>
> If anybody has any idea what might be causing a drive in this array to
> just shut down as it's being used, I'd be mighty interested. If you
> want me to try a patch or anything to see if we can get some of these
> BUG()s out, that's fine aswell. And again, I'd be happy to rerun this
> with the 2 Promise controllers (PDC20319), but so far I've tried that
> setup with a 2.6.16.14+ kernel and that one locked _hard_ once a drive
> decided to shut down.
>
> Kind regards,
>
> Tom Wirschell
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
