From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Fri, 16 May 2008 12:54:52 -0400
Message-ID: <482DBC5C.3020904@rtr.ca>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4357 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbYEPQyx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 May 2008 12:54:53 -0400
In-Reply-To: <482DBA62.4020209@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Mark Lord wrote:
>> Tejun,
>>
>> Since enabling PMP support in sata_mv, there have been some recent
>> reports of not all drives being found on a PM.
..
> Mmmm.. one strange thing from the logs.
> sata_mv reports "unexpected device interrupt" in a few places,
> and then triggers EH to recover from it.
> This could be what is causing the PMP enumerations to partially fail.
> 
> I wonder why we're getting interrupts when supposedly idle/polling ?
> Did something in libata miss reading ata_status to clear an IRQ ?
..

Here, I've hacked my local copy of sata_mv to NOT trigger EH
when it gets an unexpected device interrupt.  This is how the driver
has been for years, until recently.

With this change, all drives on the PM are found (no surprise).

So I guess the questions are:

1. Where are these unexpected interrupts coming from?

The implication is that a command is being issued without NIEN=1,
*or* the ata_status is not being read (to clear the pending IRQ)
before we clear NIEN for a subsequent command.

2. What to do about them in the driver?

I'm worried that if sata_mv just ignores them (as in my local hack here/below),
then nothing will ever clear them, and a single-core system could get stuck.
Dunno if that actually happens or not, but it looks like a real risk (?).
Then again, the pre-PMP code has been like this for ages..

Here's the successful enumeration log:

[ 3190.597239] sata_mv 0000:03:00.0: version 1.20
[ 3190.597239] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[ 3190.597239] sata_mv 0000:03:00.0: Applying 60X1C0 workarounds to unknown rev
[ 3190.597239] sata_mv 0000:03:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[ 3190.597239] PCI: Setting latency timer of device 0000:03:00.0 to 64
[ 3190.597239] scsi30 : sata_mv
[ 3190.600374] scsi31 : sata_mv
[ 3190.600572] scsi32 : sata_mv
[ 3190.600572] scsi33 : sata_mv
[ 3190.600603] ata31: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff422000 irq 19
[ 3190.600609] ata32: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff424000 irq 19
[ 3190.600614] ata33: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff426000 irq 19
[ 3190.600619] ata34: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff428000 irq 19
[ 3191.092385] ata31: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3191.145741] ata31.00: ATA-7: ST3750640NS, 3.BAF, max UDMA/133
[ 3191.145747] ata31.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3191.205747] ata31.00: configured for UDMA/133
[ 3191.682378] ata32: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3191.692406] ata32.00: ATA-8: Hitachi HDP725050GLA360, GM4OA50E, max UDMA/133
[ 3191.692412] ata32.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3191.712415] ata32.00: configured for UDMA/133
[ 3192.032372] ata33: SATA link down (SStatus 0 SControl 300)
[ 3192.385758] ata34: SATA link down (SStatus 0 SControl 300)
[ 3192.389043] scsi 30:0:0:0: Direct-Access     ATA      ST3750640NS      3.BA PQ: 0 ANSI: 5
[ 3192.389663] sd 30:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 3192.389706] sd 30:0:0:0: [sdb] Write Protect is off
[ 3192.389711] sd 30:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3192.389786] sd 30:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3192.389964] sd 30:0:0:0: [sdb] 1465149168 512-byte hardware sectors (750156 MB)
[ 3192.390006] sd 30:0:0:0: [sdb] Write Protect is off
[ 3192.390012] sd 30:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[ 3192.390087] sd 30:0:0:0: [sdb] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[ 3192.390117]  sdb: sdb1
[ 3192.406753] sd 30:0:0:0: [sdb] Attached SCSI disk
[ 3192.406753] sd 30:0:0:0: Attached scsi generic sg2 type 0
[ 3192.406753] scsi 31:0:0:0: Direct-Access     ATA      Hitachi HDP72505 GM4O PQ: 0 ANSI: 5
[ 3192.406753] sd 31:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 3192.406753] sd 31:0:0:0: [sdc] Write Protect is off
[ 3192.406753] sd 31:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3192.406753] sd 31:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3192.406753] sd 31:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[ 3192.406753] sd 31:0:0:0: [sdc] Write Protect is off
[ 3192.406753] sd 31:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[ 3192.406753] sd 31:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3192.406753]  sdc: sdc1
[ 3192.447470] sd 31:0:0:0: [sdc] Attached SCSI disk
[ 3192.447675] sd 31:0:0:0: Attached scsi generic sg3 type 0

Now we power on the silimage PM with four drives:

[ 3203.788382] ata34: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xe frozen
[ 3203.788382] ata34: edma_err_cause=00000010 pp_flags=00000000, dev connect
[ 3203.788382] ata34: SError: { PHYRdyChg DevExch }
[ 3203.788382] ata34: hard resetting link
[ 3205.212576] ata34: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3205.215881] ata34.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[ 3205.215881] ata34.00: hard resetting link
[ 3211.248459] ata34.15: link is slow to respond, please be patient (ready=0)
[ 3217.065728] ata34.00: SRST failed (errno=-16)

Here's another interrupt that should not have happened.
This time, I've modified sata_mv to just log it and continue,
rather than retriggering EH because of it:

[ 3217.066157] ata34: unexpected device interrupt while polling
[ 3217.066614] ata34.00: hard resetting link
[ 3223.727152] ata34.15: link is slow to respond, please be patient (ready=0)
[ 3229.305615] ata34.00: SRST failed (errno=-16)

And another one:

[ 3229.306080] ata34: unexpected device interrupt while polling
[ 3229.306539] ata34.00: hard resetting link
[ 3230.127157] ata34.01: hard resetting link
[ 3230.447156] ata34.02: hard resetting link
[ 3236.683279] ata34.15: link is slow to respond, please be patient (ready=0)
[ 3242.556778] ata34.02: SRST failed (errno=-16)

And another one:

[ 3242.557198] ata34: unexpected device interrupt while polling
[ 3242.557653] ata34.02: hard resetting link
[ 3245.299215] ata34.03: hard resetting link
[ 3245.772551] ata34.04: hard resetting link
[ 3246.245884] ata34.05: hard resetting link
[ 3246.579045] ata34.02: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 3246.579415] ata34.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3246.592802] ata34.02: configured for UDMA/133
[ 3246.599460] ata34.03: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 3246.599821] ata34.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3246.619054] ata34.03: configured for UDMA/133
[ 3246.632379] ata34.04: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 3246.632741] ata34.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3246.639470] ata34.04: configured for UDMA/133
[ 3246.639968] ata34: PMP SError.N set for some ports, repeating recovery
[ 3246.642325] ata34.00: hard resetting link
[ 3250.196291] ata34.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
[ 3250.196667] ata34.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[ 3250.202966] ata34.00: configured for UDMA/133
[ 3250.222964] ata34.02: configured for UDMA/133
[ 3250.236298] ata34.03: configured for UDMA/133
[ 3250.262550] ata34.04: configured for UDMA/133
[ 3250.263054] ata34: EH complete
[ 3252.299461] scsi 33:0:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 3252.309626] sd 33:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.309626] sd 33:0:0:0: [sdd] Write Protect is off
[ 3252.309626] sd 33:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3252.309626] sd 33:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.309626] sd 33:0:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.309626] sd 33:0:0:0: [sdd] Write Protect is off
[ 3252.309626] sd 33:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[ 3252.309626] sd 33:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.309626]  sdd: sdd1
[ 3252.325039] sd 33:0:0:0: [sdd] Attached SCSI disk
[ 3252.325235] sd 33:0:0:0: Attached scsi generic sg4 type 0
[ 3252.326722] scsi 33:2:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 3252.327808] sd 33:2:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.327851] sd 33:2:0:0: [sde] Write Protect is off
[ 3252.327856] sd 33:2:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3252.327932] sd 33:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.328092] sd 33:2:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.328135] sd 33:2:0:0: [sde] Write Protect is off
[ 3252.328139] sd 33:2:0:0: [sde] Mode Sense: 00 3a 00 00
[ 3252.328217] sd 33:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.328245]  sde: sde1
[ 3252.351141] sd 33:2:0:0: [sde] Attached SCSI disk
[ 3252.351141] sd 33:2:0:0: Attached scsi generic sg5 type 0
[ 3252.351141] scsi 33:3:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 3252.351141] sd 33:3:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.351171] sd 33:3:0:0: [sdf] Write Protect is off
[ 3252.351175] sd 33:3:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 3252.351249] sd 33:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.351412] sd 33:3:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.351453] sd 33:3:0:0: [sdf] Write Protect is off
[ 3252.351457] sd 33:3:0:0: [sdf] Mode Sense: 00 3a 00 00
[ 3252.354476] sd 33:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.354476]  sdf: sdf1
[ 3252.361143] sd 33:3:0:0: [sdf] Attached SCSI disk
[ 3252.361143] sd 33:3:0:0: Attached scsi generic sg6 type 0
[ 3252.361246] scsi 33:4:0:0: Direct-Access     ATA      ST3400832AS      3.03 PQ: 0 ANSI: 5
[ 3252.364481] sd 33:4:0:0: [sdg] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.364481] sd 33:4:0:0: [sdg] Write Protect is off
[ 3252.364481] sd 33:4:0:0: [sdg] Mode Sense: 00 3a 00 00
[ 3252.364481] sd 33:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.364481] sd 33:4:0:0: [sdg] 781422768 512-byte hardware sectors (400088 MB)
[ 3252.364481] sd 33:4:0:0: [sdg] Write Protect is off
[ 3252.364481] sd 33:4:0:0: [sdg] Mode Sense: 00 3a 00 00
[ 3252.364481] sd 33:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 3252.364481]  sdg: sdg1
[ 3252.386139] sd 33:4:0:0: [sdg] Attached SCSI disk
[ 3252.386139] sd 33:4:0:0: Attached scsi generic sg7 type 0

Success, all four PMP drives found.
