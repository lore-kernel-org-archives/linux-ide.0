From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Fri, 16 May 2008 12:46:26 -0400
Message-ID: <482DBA62.4020209@rtr.ca>
References: <482DB79F.2030204@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3269 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbYEPQq2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 May 2008 12:46:28 -0400
In-Reply-To: <482DB79F.2030204@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun,
> 
> Since enabling PMP support in sata_mv, there have been some recent
> reports of not all drives being found on a PM.
> 
> I can reproduce this here myself, too:
> 
> (1) silicon image PM with four drives attached.
> (2) power-down the PM.
> (3) rmmod sata_mv ; modprobe sata_mv (latest upstream).
> (4) plug (power off) PM into sata_mv card (7042 chipset).
> (5) power on the PM.
> (6) watch only 2-3 of the four drives get found.
> 
> If the PM was already powered on in advance, then all drives are found.
> sata_mv relies entirely on libata-*.c for PMP resets/enumerations,
> so I'm not sure that the problem is in sata_mv.
> 
> Any ideas?
..

Mmmm.. one strange thing from the logs.
sata_mv reports "unexpected device interrupt" in a few places,
and then triggers EH to recover from it.
This could be what is causing the PMP enumerations to partially fail.

I wonder why we're getting interrupts when supposedly idle/polling ?
Did something in libata miss reading ata_status to clear an IRQ ?

Here's the original (failing) log:

[ 1222.304368] sata_mv 0000:03:00.0: version 1.20
[ 1222.304796] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[ 1222.304887] sata_mv 0000:03:00.0: Applying 60X1C0 workarounds to unknown rev
[ 1222.304942] sata_mv 0000:03:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[ 1222.304954] PCI: Setting latency timer of device 0000:03:00.0 to 64
[ 1222.307587] scsi14 : sata_mv
[ 1222.307587] scsi15 : sata_mv
[ 1222.307587] scsi16 : sata_mv
[ 1222.307718] scsi17 : sata_mv
[ 1222.307718] ata15: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff422000 irq 19
[ 1222.307718] ata16: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff424000 irq 19
[ 1222.307718] ata17: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff426000 irq 19
[ 1222.307718] ata18: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff428000 irq 19
[ 1222.849717] ata15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1222.893000] ata15.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 1222.893000] ata15.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1222.893000] ata15.00: failed to set xfermode (err_mask=0x40)
[ 1222.893000] ata15: failed to recover some devices, retrying in 5 secs
[ 1229.574577] ata15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1229.621209] ata15.00: failed to set xfermode (err_mask=0x40)
[ 1229.621209] ata15: limiting SATA link speed to 1.5 Gbps
[ 1229.621209] ata15.00: limiting speed to UDMA/133:PIO3
[ 1229.621209] ata15: failed to recover some devices, retrying in 5 secs
[ 1236.859860] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1236.896494] ata15.00: failed to set xfermode (err_mask=0x40)
[ 1236.896494] ata15.00: disabled

Note the "unexpected device interrupt while idle" error, which triggers EH:

[ 1237.399858] ata15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen t4
[ 1237.400393] ata15: unexpected device interrupt while idle
[ 1237.400796] ata15: hard resetting link
[ 1237.901885] ata15: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1237.901901] ata15: EH complete
[ 1238.385209] ata16: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1238.385183] ata16.00: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 1238.385183] ata16.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1238.385183] ata16.00: failed to set xfermode (err_mask=0x40)
[ 1238.385183] ata16: failed to recover some devices, retrying in 5 secs
[ 1245.329460] ata16: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1245.336654] ata16.00: failed to set xfermode (err_mask=0x40)
[ 1245.349426] ata16: limiting SATA link speed to 1.5 Gbps
[ 1245.349430] ata16.00: limiting speed to UDMA/133:PIO3
[ 1245.349433] ata16: failed to recover some devices, retrying in 5 secs
[ 1252.526624] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1252.533808] ata16.00: failed to set xfermode (err_mask=0x40)
[ 1252.533864] ata16.00: disabled

Note the "unexpected device interrupt while idle" error, which triggers EH:

[ 1253.176196] ata16: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen t4
[ 1253.176290] ata16: unexpected device interrupt while idle
[ 1253.176349] ata16: hard resetting link
[ 1253.649543] ata16: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 1253.649559] ata16: EH complete
[ 1253.982862] ata17: SATA link down (SStatus 0 SControl 300)
[ 1254.302862] ata18: SATA link down (SStatus 0 SControl 300)
[ 1314.600817] ACPI: PCI interrupt for device 0000:03:00.0 disabled
[ 1316.843654] sata_mv 0000:03:00.0: version 1.20
[ 1316.843654] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[ 1316.843654] sata_mv 0000:03:00.0: Applying 60X1C0 workarounds to unknown rev
[ 1316.843654] sata_mv 0000:03:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[ 1316.843654] PCI: Setting latency timer of device 0000:03:00.0 to 64
[ 1316.843654] scsi18 : sata_mv
[ 1316.845591] scsi19 : sata_mv
[ 1316.847159] scsi20 : sata_mv
[ 1316.848918] scsi21 : sata_mv
[ 1316.848918] ata19: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff422000 irq 19
[ 1316.848918] ata20: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff424000 irq 19
[ 1316.848918] ata21: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff426000 irq 19
[ 1316.848918] ata22: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff428000 irq 19
[ 1317.319523] ata19: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1317.372879] ata19.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 1317.372886] ata19.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1317.449552] ata19.00: configured for UDMA/133
[ 1318.025102] ata20: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1318.041775] ata20.00: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 1318.041781] ata20.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1318.060953] ata20.00: configured for UDMA/133
[ 1318.396766] ata21: SATA link down (SStatus 0 SControl 300)
[ 1318.740937] ata22: SATA link down (SStatus 0 SControl 300)
[ 1318.590882] scsi 18:0:0:0: Direct-Access     ATA      ST3750640NS      3.BA PQ: 0 ANSI: 5
[ 1318.590882] sd 18:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1318.590882] sd 18:0:0:0: [sdb] Write Protect is off
[ 1318.590882] sd 18:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1318.590882] sd 18:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1318.590882] sd 18:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 1318.590882] sd 18:0:0:0: [sdb] Write Protect is off
[ 1318.590882] sd 18:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 1318.590882] sd 18:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 1318.590882]  sdb: sdb1
[ 1318.764651] sd 18:0:0:0: [sdb] Attached SCSI disk
[ 1318.767985] sd 18:0:0:0: Attached scsi generic sg2 type 0
[ 1318.767985] scsi 19:0:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
[ 1318.767985] sd 19:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1318.767985] sd 19:0:0:0: [sdc] Write Protect is off
[ 1318.767985] sd 19:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1318.767985] sd 19:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1318.771070] sd 19:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 1318.771070] sd 19:0:0:0: [sdc] Write Protect is off
[ 1318.771070] sd 19:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 1318.771070] sd 19:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1318.771070]  sdc: sdc1
[ 1318.795749] sd 19:0:0:0: [sdc] Attached SCSI disk
[ 1318.795749] sd 19:0:0:0: Attached scsi generic sg3 type 0

Those drives (above) are directly attached to the marvell controller.
Now, below, we power on the silimage PM with four additional drives.

[ 1341.310527] ata22: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[ 1341.312815] ata22: edma_err_cause=00000010 pp_flags=00000000, dev connect
[ 1341.313286] ata22: SError: { PHYRdyChg DevExch }
[ 1341.313561] ata22: hard resetting link
[ 1342.852379] ata22: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1342.853584] ata22.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[ 1342.855237] ata22.00: hard resetting link
[ 1343.335991] ata22.01: hard resetting link
[ 1344.075666] ata22.02: hard resetting link
[ 1350.898092] ata22.15: link is slow to respond, please be patient (ready=0)
[ 1357.122516] ata22.02: SRST failed (errno=-16)
[ 1357.122961] ata22.02: failed to read SCR 0 (Emask=0x100)
[ 1357.123309] ata22.02: reset failed, giving up
[ 1357.123653] ata22.15: hard resetting link
[ 1357.649204] ata22.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 1357.650414] ata22.03: hard resetting link
[ 1364.843567] ata22.15: link is slow to respond, please be patient (ready=0)
[ 1367.988474] ata22.04: hard resetting link
[ 1368.461807] ata22.05: hard resetting link
[ 1368.788713] ata22.03: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 1368.789078] ata22.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1368.802056] ata22.03: configured for UDMA/133
[ 1368.808714] ata22.04: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 1368.809075] ata22.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1368.822052] ata22.04: configured for UDMA/133
[ 1368.822548] ata22: PMP SError.N set for some ports, repeating recovery
[ 1368.823052] ata22.00: hard resetting link
[ 1373.304201] ata22.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 1373.304574] ata22.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 1373.317543] ata22.00: configured for UDMA/133
[ 1373.474220] ata22.03: configured for UDMA/133
[ 1373.488812] ata22.04: configured for UDMA/133

Note the "unexpected device interrupt while polling" error, which triggers EH:

[ 1373.489906] ata22.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1 t4
[ 1373.490384] ata22.15: unexpected device interrupt while polling
[ 1373.495008] ata22: EH complete
[ 1373.495374] scsi 21:0:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 1373.496005] sd 21:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.496048] sd 21:0:0:0: [sdd] Write Protect is off
[ 1373.496052] sd 21:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1373.496127] sd 21:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.496418] sd 21:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.496459] sd 21:0:0:0: [sdd] Write Protect is off
[ 1373.496463] sd 21:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 1373.496539] sd 21:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.496568]  sdd: sdd1
[ 1373.516434] sd 21:0:0:0: [sdd] Attached SCSI disk
[ 1373.517411] sd 21:0:0:0: Attached scsi generic sg4 type 0
[ 1373.518343] scsi 21:3:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 1373.520255] sd 21:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.520300] sd 21:3:0:0: [sde] Write Protect is off
[ 1373.520306] sd 21:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 1373.520382] sd 21:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.520546] sd 21:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.520590] sd 21:3:0:0: [sde] Write Protect is off
[ 1373.520595] sd 21:3:0:0: [sde] Mode Sense: 00 3a 00 00
[ 1373.520673] sd 21:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.520703]  sde: sde1
[ 1373.532356] sd 21:3:0:0: [sde] Attached SCSI disk
[ 1373.532356] sd 21:3:0:0: Attached scsi generic sg5 type 0
[ 1373.532393] scsi 21:4:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 1373.532393] sd 21:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.532393] sd 21:4:0:0: [sdf] Write Protect is off
[ 1373.532393] sd 21:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1373.532393] sd 21:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.532393] sd 21:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[ 1373.532393] sd 21:4:0:0: [sdf] Write Protect is off
[ 1373.532393] sd 21:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 1373.532393] sd 21:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1373.532423]  sdf: sdf1
[ 1373.563088] sd 21:4:0:0: [sdf] Attached SCSI disk
[ 1373.564928] sd 21:4:0:0: Attached scsi generic sg6 type 0

Only 3/4 drives were found on the PM.

