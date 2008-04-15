From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv & pmp support
Date: Tue, 15 Apr 2008 15:59:00 -0400
Message-ID: <48050904.1040808@rtr.ca>
References: <47FA4AFF.2010209@gmail.com> <48003C04.4040508@garzik.org> <48023462.1050305@rtr.ca> <4803C429.6070201@rtr.ca> <4803C850.9010901@rtr.ca> <48040DC8.1050907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:3709 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbYDOT7B (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Apr 2008 15:59:01 -0400
In-Reply-To: <48040DC8.1050907@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Hello, again.
> 
> Mark Lord wrote:
>> Mmm... here's what the same port multiplier does when connected to
>> a sata_sil24 card I have here.  This does seem to be an awful lot
>> of kernel log spamming for hotplugging a 4-drive port-multiplier.  ??
> 
> Indeed.  Was it like this before the big changes?
> 
>> [34326.979383] sata_sil24 0000:0d:00.0: version 1.1
>> [34326.979423] PCI: Enabling device 0000:0d:00.0 (0000 -> 0003)
>> [34326.979433] ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 19 (level, 
>> low) -> IRQ 19
>> [34326.979506] PCI: Setting latency timer of device 0000:0d:00.0 to 64
>> [34326.979699] scsi2 : sata_sil24
>> [34326.980312] scsi3 : sata_sil24
>> [34326.980375] ata3: SATA max UDMA/100 host m128@0xefa04000 port 
>> 0xefa00000 irq 19
>> [34326.980381] ata4: SATA max UDMA/100 host m128@0xefa04000 port 
>> 0xefa02000 irq 19
>> [33875.296258] ata3: SATA link down (SStatus 0 SControl 0)
>> [33877.348890] ata4: SATA link down (SStatus 0 SControl 0)
>> [33891.301792] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa 
>> frozen
>> [33891.301792] ata3: irq_stat 0x00b40090, PHY RDY changed
>> [33891.301792] ata3: hard resetting link
>> [33893.472639] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [33893.473083] ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 
>> ports, feat 0x1/0x9
> 
> Okay, SIMG 3726.
> 
>> [33893.473581] ata3.00: hard resetting link
>> [33893.896674] ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
>> [33893.896737] ata3.01: hard resetting link
>> [33894.334126] ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [33894.334126] ata3.02: hard resetting link
>> [33894.753536] ata3.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [33894.753604] ata3.03: hard resetting link
>> [33895.190559] ata3.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [33895.190623] ata3.04: hard resetting link
>> [33895.627372] ata3.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [33895.627383] ata3.05: hard resetting link
>> [33895.945716] ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
>> [33895.946640] ata3.00: ATA-7: ST3400832AS, 3.03, max UDMA/133
>> [33895.946646] ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 
>> 31/32)
>> [33895.947720] ata3.00: configured for UDMA/100
..

Okay, there's the problem, or at least the symptoms.
With sata_mv, I see "soft resetting link" messages there (above),
rather than the desired "hard resetting link".

I wonder why that is?

And another oddity:  on initial module load, sata_mv never finds the PM,
until I rmmod and then insmod again.  Always on the second try.

It's almost as if the hard/soft reset functions were reversed (?).

Gahd.. I wish I could just post the source and have you point out my silliness therein (!)
(Marvell's lawyers forbid such until somebody there clears it).


> Can you also post the log from sata_mv reset failures?

Sure, here it is, with a bunch of extraneous debug messages tossed in.
I've temporarily cloned (no changes) a few libata functions from the softreset
paths, to make it easier to add debug messages inside them, as per below:

insmod sata_mv
[   56.917762] sata_mv 0000:02:00.0: version 1.20
[   56.918205] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[   56.918256] sata_mv 0000:02:00.0: Applying 60X1C0 workarounds to unknown rev
[   56.918311] sata_mv 0000:02:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[   56.918322] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   56.918439] ata4294967295: mv_eh_freeze()
[   56.918557] ata4294967295: mv_eh_freeze()
[   56.918683] ata4294967295: mv_eh_freeze()
[   56.918797] ata4294967295: mv_eh_freeze()
[   56.918884] scsi40 : sata_mv
[   56.919086] scsi41 : sata_mv
[   56.919273] scsi42 : sata_mv
[   56.919461] scsi43 : sata_mv
[   56.919588] ata41: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff422000 irq 19
[   56.919594] ata42: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff424000 irq 19
[   56.919599] ata43: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff426000 irq 19
[   56.919605] ata44: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff428000 irq 19
[   43.304007] ata41: mv_eh_freeze()
[   43.304007] ata41: mv_hardreset
[   43.304007] ata41: mv_pmp_select(15)
[   43.364017] ata41: mv_hardreset rc=0, online=0
[   43.364031] ata41: SATA link down (SStatus 0 SControl 300)
[   43.364038] ata41: mv_eh_thaw()
[   43.364067] ata42: mv_eh_freeze()
[   43.364075] ata42: mv_hardreset
[   43.364518] ata42: mv_pmp_select(15)
[   43.414013] ata42: mv_hardreset rc=0, online=0
[   43.414025] ata42: SATA link down (SStatus 0 SControl 300)
[   43.414030] ata42: mv_eh_thaw()
[   43.414053] ata43: mv_eh_freeze()
[   43.414060] ata43: mv_hardreset
[   43.414503] ata43: mv_pmp_select(15)
[   43.467344] ata43: mv_hardreset rc=0, online=0
[   43.467357] ata43: SATA link down (SStatus 0 SControl 300)
[   43.467362] ata43: mv_eh_thaw()
[   43.467391] ata44: mv_eh_freeze()
[   43.467399] ata44: mv_hardreset
[   43.467843] ata44: mv_pmp_select(15)
[   43.517340] ata44: mv_hardreset rc=0, online=0
[   43.517351] ata44: SATA link down (SStatus 0 SControl 300)
[   43.517356] ata44: mv_eh_thaw()
[   88.369413] ata41: mv_eh_freeze()
[   88.370539] ata42: mv_eh_freeze()
[   88.371568] ata43: mv_eh_freeze()
[   88.373255] ata44: mv_eh_freeze()
[   88.375395] ACPI: PCI interrupt for device 0000:02:00.0 disabled
rmmod sata_mv
insmod sata_mv
[   93.729740] sata_mv 0000:02:00.0: version 1.20
[   93.731147] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
[   93.731621] sata_mv 0000:02:00.0: Applying 60X1C0 workarounds to unknown rev
[   93.732052] sata_mv 0000:02:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[   93.732802] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   93.733267] ata4294967295: mv_eh_freeze()
[   93.733632] ata4294967295: mv_eh_freeze()
[   93.734004] ata4294967295: mv_eh_freeze()
[   93.734370] ata4294967295: mv_eh_freeze()
[   93.734706] scsi44 : sata_mv
[   93.735728] scsi45 : sata_mv
[   43.613987] scsi46 : sata_mv
[   43.613987] scsi47 : sata_mv
[   43.613987] ata45: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff422000 irq 19
[   43.613987] ata46: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff424000 irq 19
[   43.613987] ata47: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff426000 irq 19
[   43.613987] ata48: SATA max UDMA/133 mmio m1048576@0xff400000 port 0xff428000 irq 19
[   43.613999] ata45: mv_eh_freeze()
[   43.614005] ata45: mv_hardreset
[   43.614449] ata45: mv_pmp_select(15)
[   43.667331] ata45: mv_hardreset rc=0, online=0
[   43.667343] ata45: SATA link down (SStatus 0 SControl 300)
[   43.667349] ata45: mv_eh_thaw()
[   43.667376] ata46: mv_eh_freeze()
[   43.667382] ata46: mv_hardreset
[   43.667825] ata46: mv_pmp_select(15)
[   43.713994] ata46: mv_hardreset rc=0, online=0
[   43.714005] ata46: SATA link down (SStatus 0 SControl 300)
[   43.714010] ata46: mv_eh_thaw()
[   43.714036] ata47: mv_eh_freeze()
[   43.714041] ata47: mv_hardreset
[   43.714484] ata47: mv_pmp_select(15)
[   43.760658] ata47: mv_hardreset rc=0, online=0
[   43.760668] ata47: SATA link down (SStatus 0 SControl 300)
[   43.760673] ata47: mv_eh_thaw()
[   43.760698] ata48: mv_eh_freeze()
[   43.760704] ata48: mv_hardreset
[   43.761147] ata48: mv_pmp_select(15)
[   43.807322] ata48: mv_hardreset rc=-11, online=1
[   43.807328] ata48: mv_softreset
[   43.807331] ata48: local_ata_sff_softreset
[   43.807335] ata48: local_ata_bus_softreset: doing SRST on port 15
[   43.807381] ata48: local_ata_sff_wait_after_reset
[   43.813984] ata48: local_ata_wait_ready
[   43.820674] ata48: classes[0]=5
[   43.820682] ata48: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   43.820689] ata48: mv_eh_thaw()
[   43.820695] ata48: sata_pmp_read(0)
[   43.820700] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.820804] ata48: sata_pmp_read(1)
[   43.820808] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.820909] ata48: sata_pmp_read(2)
[   43.820913] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.821013] ata48: sata_pmp_read(32)
[   43.821017] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.821117] ata48: sata_pmp_read(33)
[   43.821121] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.821221] ata48: sata_pmp_read(64)
[   43.821225] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.821325] ata48: sata_pmp_read(96)
[   43.821329] ata48: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.821430] ata48: sata_pmp_write(33,0x00010000)
[   43.821434] ata48: qc_issue(PIO, ata_op=0xe8, pmp=15)
[   43.824030] ata48.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[   43.824034] ata48.15: Asynchronous notification not supported, hotplug won't
[   43.824035]          work on fan-out ports. Use warm-plug instead.
[   43.824456] ata48.00: sata_pmp_read(2)
[   43.824461] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.824561] ata48.01: sata_pmp_read(2)
[   43.824566] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.824664] ata48.02: sata_pmp_read(2)
[   43.824669] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.824767] ata48.03: sata_pmp_read(2)
[   43.824772] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.824870] ata48.04: sata_pmp_read(2)
[   43.824874] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.824972] ata48.05: sata_pmp_read(2)
[   43.824976] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.825075] ata48.15: sata_pmp_read(0)
[   43.825079] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   43.825185] ata48.00: soft resetting link
[   43.825187] ata48.00: mv_softreset
[   43.825190] ata48: mv_pmp_select(0)
[   43.825194] ata48.00: local_ata_sff_softreset
[   43.825198] ata48: local_ata_bus_softreset: doing SRST on port 0
[   43.825245] ata48.15: local_ata_sff_wait_after_reset
[   43.863979] ata48.15: local_ata_wait_ready
[   44.823925] ata48.15: local_ata_wait_ready: link is slow to respond, please be patient (ready=0)
[   45.757200] ata48.00: SRST failed (errno=-16)
[   45.757253] ata48.00: sata_pmp_read(0)
[   45.757257] ata48: mv_pmp_select(15)
[   45.757261] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   45.757362] ata48.00: soft resetting link
[   45.757365] ata48.00: mv_softreset
[   45.757368] ata48: mv_pmp_select(0)
[   45.757372] ata48.00: local_ata_sff_softreset
[   45.757375] ata48: local_ata_bus_softreset: doing SRST on port 0
[   45.757422] ata48.15: local_ata_sff_wait_after_reset
[   45.773855] ata48.15: local_ata_wait_ready
[   46.730468] ata48.15: local_ata_wait_ready: link is slow to respond, please be patient (ready=0)
[   47.653744] ata48.00: SRST failed (errno=-16)
[   47.653794] ata48.00: sata_pmp_read(0)
[   47.653799] ata48: mv_pmp_select(15)
[   47.653802] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   47.653904] ata48.00: soft resetting link
[   47.653906] ata48.00: mv_softreset
[   47.653909] ata48: mv_pmp_select(0)
[   47.653913] ata48.00: local_ata_sff_softreset
[   47.653917] ata48: local_ata_bus_softreset: doing SRST on port 0
[   47.653963] ata48.15: local_ata_sff_wait_after_reset
[   47.670399] ata48.15: local_ata_wait_ready
[   48.620345] ata48.15: local_ata_wait_ready: link is slow to respond, please be patient (ready=0)
[   54.423305] ata48.00: SRST failed (errno=-16)
[   54.423359] ata48.00: sata_pmp_read(0)
[   54.423364] ata48: mv_pmp_select(15)
[   54.423369] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   54.423474] ata48.00: sata_pmp_read(0)
[   54.423479] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   54.423580] ata48.00: limiting SATA link speed to 1.5 Gbps
[   54.423583] ata48.00: soft resetting link
[   54.423585] ata48.00: mv_softreset
[   54.423588] ata48: mv_pmp_select(0)
[   54.423593] ata48.00: local_ata_sff_softreset
[   54.423597] ata48: local_ata_bus_softreset: doing SRST on port 0
[   54.423643] ata48.15: local_ata_sff_wait_after_reset
[   54.443292] ata48.15: local_ata_wait_ready
[   55.363244] ata48.00: SRST failed (errno=-16)
[   55.363293] ata48.00: sata_pmp_read(0)
[   55.363298] ata48: mv_pmp_select(15)
[   55.363301] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.363405] ata48.00: reset failed, giving up
[   55.363454] ata48: mv_eh_freeze()
[   55.363460] ata48.15: hard resetting link
[   55.363464] ata48.15: mv_hardreset
[   55.363908] ata48: mv_pmp_select(15)
[   55.406568] ata48.15: mv_hardreset rc=-11, online=1
[   55.406574] ata48.15: mv_softreset
[   55.406578] ata48.15: local_ata_sff_softreset
[   55.406583] ata48: local_ata_bus_softreset: doing SRST on port 15
[   55.406629] ata48.15: local_ata_sff_wait_after_reset
[   55.416571] ata48.15: local_ata_wait_ready
[   55.426587] ata48.15: classes[0]=5
[   55.426595] ata48.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   55.426602] ata48: mv_eh_thaw()
[   55.426610] ata48.15: sata_pmp_read(0)
[   55.426615] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.426716] ata48.15: sata_pmp_read(1)
[   55.426721] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.426821] ata48.15: sata_pmp_read(2)
[   55.426825] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.426925] ata48.15: sata_pmp_read(32)
[   55.426929] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.427029] ata48.15: sata_pmp_read(33)
[   55.427033] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.427134] ata48.15: sata_pmp_read(64)
[   55.427138] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.427238] ata48.15: sata_pmp_read(96)
[   55.427242] ata48.15: qc_issue(PIO, ata_op=0xe4, pmp=15)
[   55.427343] ata48.15: sata_pmp_write(33,0x00010000)
[   55.427347] ata48.15: qc_issue(PIO, ata_op=0xe8, pmp=15)
[   55.429940] ata48.01: soft resetting link
[   55.429943] ata48.01: mv_softreset
[   55.429946] ata48: mv_pmp_select(1)
[   55.429949] ata48.01: local_ata_sff_softreset
[   55.429953] ata48: local_ata_bus_softreset: doing SRST on port 1
[   55.429999] ata48.15: local_ata_sff_wait_after_reset
[   55.436561] ata48.15: local_ata_wait_ready

