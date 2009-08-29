From: Mark Lord <liml@rtr.ca>
Subject: Re: CF to SATA bridge support
Date: Sat, 29 Aug 2009 12:10:22 -0400
Message-ID: <4A9952EE.8080701@rtr.ca>
References: <43479bc90908071059o2ce5ac94v1d9d959e3af44326@mail.gmail.com>	 <4A7CEF3B.9090506@gmail.com>	 <43479bc90908081135i229d4061k9d461444d3600645@mail.gmail.com> <43479bc90908090923h40305e14mf726d30fbed0733f@mail.gmail.com> <4A80219D.7070708@rtr.ca> <4A9931B2.2020003@rtr.ca> <4A995070.4020108@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:56710 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbZH2QKV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Aug 2009 12:10:21 -0400
In-Reply-To: <4A995070.4020108@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mathieu GELI <mathieu.geli@gmail.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

The ancient 16MB Lexar PIO-only CF-Card did not fare so well.
It crapped out similar to how Mathieu reported,
with lots of HSM errors on WRITEs.  READs were fine, though.

HOTPLUGGING NOW:
[  461.060770] ata11: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[  461.060774] ata11: edma_err_cause=00000010 pp_flags=00000000, dev connect
[  461.060778] ata11: SError: { PHYRdyChg DevExch }
[  461.060785] ata11: hard resetting link
[  461.816019] ata11: SATA link down (SStatus 0 SControl 300)
[  461.816026] ata11: EH complete
[  464.644462] ata12: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[  464.644465] ata12: edma_err_cause=00000010 pp_flags=00000000, dev connect
[  464.644469] ata12: SError: { PHYRdyChg DevExch }
[  464.644475] ata12: hard resetting link
[  465.524031] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  465.552206] ata12.00: CFA: LEXAR ATA_FLASH, V1.00, max PIO3
[  465.552210] ata12.00: 32128 sectors, multi 0: LBA 
[  465.552225] ata12.00: applying bridge limits
[  465.564244] ata12.00: configured for PIO3 (device error ignored)
[  465.588253] ata12.00: configured for PIO3 (device error ignored)
[  465.588258] ata12: EH complete
[  465.588360] scsi 11:0:0:0: Direct-Access     ATA      LEXAR ATA_FLASH  V1.0 PQ: 0 ANSI: 5
[  465.588501] sd 11:0:0:0: [sdb] 32128 512-byte hardware sectors: (16.4 MB/15.6 MiB)
[  465.588521] sd 11:0:0:0: [sdb] Write Protect is off
[  465.588524] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  465.588555] sd 11:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  465.588661] sd 11:0:0:0: [sdb] 32128 512-byte hardware sectors: (16.4 MB/15.6 MiB)
[  465.588680] sd 11:0:0:0: [sdb] Write Protect is off
[  465.588683] sd 11:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  465.588713] sd 11:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[  465.588717]  sdb:<4>ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.617448]  sdb1
[  465.617586] sd 11:0:0:0: [sdb] Attached SCSI removable disk
[  465.617665] sd 11:0:0:0: Attached scsi generic sg2 type 0

UBUNTU NOW TRIES TO AUTOMOUNT THE PARTITIONS:
[  465.632756] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.646726] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.654445] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.662477] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.670420] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.688374] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.694437] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.702436] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata
[  465.710438] ata12: sata_mv: attempting PIO w/multiple DRQ: this may fail due to h/w errata

OKAY, MOUNTED.  NOW WE TRY TO WRITE/SYNC SOME DATA:
[  511.784629] ata12.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  511.784634] ata12.00: edma_err_cause=00001000 pp_flags=00000000
[  511.784640] ata12.00: cmd 30/00:01:41:00:00/00:00:00:00:00/e0 tag 0 pio 512 out
[  511.784642]          res 58/00:01:41:00:00/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
[  511.784645] ata12.00: status: { DRDY DRQ }
[  511.784651] ata12: hard resetting link
[  512.260030] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  512.300230] ata12.00: configured for PIO3 (device error ignored)
[  512.324235] ata12.00: configured for PIO3 (device error ignored)
[  512.324242] ata12: EH complete
[  512.332131] ata12.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  512.332134] ata12.00: edma_err_cause=00001000 pp_flags=00000000
[  512.332140] ata12.00: cmd 30/00:01:41:00:00/00:00:00:00:00/e0 tag 0 pio 512 out
[  512.332141]          res 58/00:01:41:00:00/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
[  512.332145] ata12.00: status: { DRDY DRQ }
[  512.332149] ata12: hard resetting link
[  512.808029] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  512.848229] ata12.00: configured for PIO3 (device error ignored)
[  512.872229] ata12.00: configured for PIO3 (device error ignored)
[  512.872236] ata12: EH complete
[  512.880136] ata12.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  512.880140] ata12.00: edma_err_cause=00001000 pp_flags=00000000
[  512.880145] ata12.00: cmd 30/00:01:41:00:00/00:00:00:00:00/e0 tag 0 pio 512 out
[  512.880147]          res 58/00:01:41:00:00/00:00:00:00:00/e0 Emask 0x2 (HSM violation)
[  512.880150] ata12.00: status: { DRDY DRQ }
[  512.880154] ata12: hard resetting link
[  513.356029] ata12: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  513.396229] ata12.00: configured for PIO3 (device error ignored)
[  513.420229] ata12.00: configured for PIO3 (device error ignored)
[  513.420237] ata12: EH complete
[  513.428128] ata12: limiting SATA link speed to 1.5 Gbps
[  513.428132] ata12.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
[  513.428135] ata12.00: edma_err_cause=00001000 pp_flags=00000000
[  513.428140] ata12.00: cmd 30/00:01:41:00:00/00:00:00:00:00/e0 tag 0 pio 512 out
[  513.428142]          res 58/00:01:41:00:00/00:00:00:00:00/e0 Emask 0x2 (HSM violation)

On the surface of things, I'd say that, yes, this is the multiple-DRQ
errata biting us.  The Marvell chips don't synchronize ATA status
register updates correctly with DRQ and interrupts.  So a special
polling sequence is supposed to be required to make it all play nicely.

And the current sata_mv doesn't do that (yet).

So I suppose we'll have to clone ata_pio_task() and ata_sff_hsm_move()
and hack them for the funky Marvell errata to get this to work correctly.
That's a LOT of code, which is why I was/am hesitant to do it before now.

Anyone else want to have a go at it?
I can describe the exact protocol sequence required
for avoiding the errata issues.
