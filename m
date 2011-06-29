From: Marc MERLIN <marc@merlins.org>
Subject: Re: sata_mv WARNING: at drivers/ata/libata-sff.c:1322
Date: Wed, 29 Jun 2011 08:07:13 -0700
Message-ID: <20110629150713.GG10580@merlins.org>
References: <20110626070820.GC24867@merlins.org> <20110626090309.GA12200@mtj.dyndns.org> <4E076E9E.9080400@pobox.com> <20110629034125.GC32153@merlins.org> <4E0AA1C1.6020406@pobox.com> <20110629050341.GB10580@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:40810 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1F2PHT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jun 2011 11:07:19 -0400
Content-Disposition: inline
In-Reply-To: <20110629050341.GB10580@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <mlord@pobox.com>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Larry Li <lil@marvell.com>, hbailey@marvell.com

On Tue, Jun 28, 2011 at 10:03:41PM -0700, Marc MERLIN wrote:
> On Tue, Jun 28, 2011 at 11:53:37PM -0400, Mark Lord wrote:
> > On 11-06-28 11:41 PM, Marc MERLIN wrote:
> > ..
> > > So it seems it was a false alarm after all, I'll report back if I have
> > > problems again, but it looks like it's working solidly and for what it's
> > > worth with 5 drives and software raid 5, I can both read and write files
> > > at about 115MB/s, which isn't too shabby :)
> > 
> > Mmm.. power everything OFF, wait a few seconds,
> > then power on and verify that it all still works.
> 
> Yep, it does (even powered off the power supply to the MB that isn't truly
> off otherwise).

Mmh, although the card works fine now, I did notice 3 libata-sff errors
in my boot log.
Once boot is finished, there are no more errors.

The card is:
02:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

>From the errors, should I try swapping the card considering it otherwise
works fine after boot, or is the problem elsewhere?
Can the 3 warnings just be ignored, or are they important?

So I suppose this is also why my kernel gets tainted?
kernel: Pid: 1636, comm: scsi_eh_9 Tainted: G        W   2.6.39.1-core2-volpreempt-noide-hm64-20110620 #2

kernel: sata_mv 0000:02:00.0: version 1.28
kernel: sata_mv 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
kernel: sata_mv 0000:02:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
kernel: sata_mv 0000:02:00.0: setting latency timer to 64
kernel: scsi8 : sata_mv
kernel: scsi9 : sata_mv
kernel: scsi10 : sata_mv
kernel: scsi11 : sata_mv
kernel: ata9: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb822000 irq 16
kernel: ata10: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb824000 irq 16
kernel: ata11: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb826000 irq 16
kernel: ata12: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb828000 irq 16
kernel: ata9: SATA link down (SStatus 0 SControl 300)
kernel: ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
kernel: ata10.00: hard resetting link
kernel: ata10.01: hard resetting link
kernel: ata10.01: link resume succeeded after 1 retries
kernel: ata10.02: hard resetting link
kernel: ata10.02: link resume succeeded after 1 retries
kernel: ata10.03: hard resetting link
kernel: ata10.03: link resume succeeded after 1 retries
kernel: ata10.04: hard resetting link
kernel: ata10.05: hard resetting link
kernel: ata10.00: ATA-7: ST3500630AS, 3.AAK, max UDMA/133
kernel: ata10.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata10.00: configured for UDMA/133
kernel: ata10.01: qc timeout (cmd 0x27)
kernel: ata10.01: failed to read native max address (err_mask=0x4)
kernel: ata10.01: HPA support seems broken, skipping HPA handling
kernel: ata10.15: hard resetting link
kernel: ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ------------[ cut here ]------------
kernel: WARNING: at drivers/ata/libata-sff.c:1322 ata_sff_queue_pio_task+0x26/0x44()
kernel: Hardware name: System Product Name
kernel: Modules linked in: keyspan ati_remote visor pl2303 ftdi_sio pci_hotplug soundcore backlight option processor usb_wwan rtc_cmos thermal_sys rtc_core hwmon parport_pc button snd_page_alloc parport usbserial wmi i2c_i801 evdev rtc_lib sata_mv pcspkr intel_agp intel_gtt agpgart tpm_tis r8169 iTCO_wdt iTCO_vendor_support xhci_hcd ehci_hcd usbcore
kernel: Pid: 1636, comm: scsi_eh_9 Not tainted 2.6.39.1-core2-volpreempt-noide-hm64-20110620 #2
kernel: Call Trace:
kernel:  [<c0133599>] warn_slowpath_common+0x60/0x75
kernel:  [<c01335bd>] warn_slowpath_null+0xf/0x13
kernel:  [<c0370812>] ata_sff_queue_pio_task+0x26/0x44
kernel:  [<c0370946>] ata_sff_qc_issue+0x116/0x14d
kernel:  [<c03709d6>] ata_bmdma_qc_issue+0x59/0x156
kernel:  [<f844650b>] mv_qc_issue+0x441/0x44d [sata_mv]
kernel:  [<c028ea13>] ? vsnprintf+0x80/0x2d7
kernel:  [<c014b5bb>] ? up+0x2b/0x2f
kernel:  [<c036309d>] ata_qc_issue+0x30b/0x329
kernel:  [<c03638c2>] ata_exec_internal_sg+0x27f/0x4a0
kernel:  [<c036f84b>] ? ata_sff_tf_read+0x53/0xde
kernel:  [<c0363b41>] ata_exec_internal+0x5e/0x66
kernel:  [<c036a0a3>] ? ata_eh_done+0x12/0x18
kernel:  [<c037213a>] sata_pmp_read+0x66/0x9d
kernel:  [<c0372197>] sata_pmp_read_gscr+0x26/0x65
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c03727b8>] sata_pmp_error_handler+0x2ff/0xa42
kernel:  [<c01289e3>] ? dequeue_task_fair+0x1fc/0x204
kernel:  [<c03704f9>] ? ata_sff_drain_fifo+0x5a/0x5a
kernel:  [<f8445f41>] ? mv_port_start+0x19f/0x19f [sata_mv]
kernel:  [<f8445c50>] ? mv_pmp_hardreset+0x8c/0x8c [sata_mv]
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c044194d>] ? __mutex_lock_slowpath+0x1f2/0x1fa
kernel:  [<c013cadd>] ? lock_timer_base+0x1f/0x3e
kernel:  [<f8445bbf>] mv_pmp_error_handler+0x60/0x65 [sata_mv]
kernel:  [<c036e283>] ata_scsi_port_error_handler+0x206/0x522
kernel:  [<c01448f6>] ? cancel_delayed_work_sync+0xb/0xd
kernel:  [<c036e60c>] ata_scsi_error+0x6d/0x8f
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c032ae1a>] scsi_error_handler+0x103/0x507
kernel:  [<c012750b>] ? complete+0x34/0x3e
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c01476c0>] kthread+0x64/0x69
kernel:  [<c014765c>] ? kthread_worker_fn+0x119/0x119
kernel:  [<c0443bbe>] kernel_thread_helper+0x6/0xd
kernel: ---[ end trace cdcd2b0b3f6829ed ]---
kernel: ata10.00: hard resetting link
kernel: ata10.01: hard resetting link
kernel: ata10.01: link resume succeeded after 1 retries
kernel: ata10.02: hard resetting link
kernel: ata10.02: link resume succeeded after 1 retries
kernel: ata10.03: hard resetting link
kernel: ata10.03: link resume succeeded after 1 retries
kernel: ata10.04: hard resetting link
kernel: ata10.04: link resume succeeded after 1 retries
kernel: ata10.05: hard resetting link
kernel: ata10.00: configured for UDMA/133
kernel: ata10.01: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
kernel: ata10.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata10.01: configured for UDMA/133
kernel: ata10.02: qc timeout (cmd 0x27)
kernel: ata10.02: failed to read native max address (err_mask=0x4)
kernel: ata10.02: HPA support seems broken, skipping HPA handling
kernel: ata10.15: hard resetting link
kernel: ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ------------[ cut here ]------------
kernel: WARNING: at drivers/ata/libata-sff.c:1322 ata_sff_queue_pio_task+0x26/0x44()
kernel: Hardware name: System Product Name
kernel: Modules linked in: keyspan ati_remote visor pl2303 ftdi_sio pci_hotplug soundcore backlight option processor usb_wwan rtc_cmos thermal_sys rtc_core hwmon parport_pc button snd_page_alloc parport usbserial wmi i2c_i801 evdev rtc_lib sata_mv pcspkr intel_agp intel_gtt agpgart tpm_tis r8169 iTCO_wdt iTCO_vendor_support xhci_hcd ehci_hcd usbcore
kernel: Pid: 1636, comm: scsi_eh_9 Tainted: G        W   2.6.39.1-core2-volpreempt-noide-hm64-20110620 #2
kernel: Call Trace:
kernel:  [<c0133599>] warn_slowpath_common+0x60/0x75
kernel:  [<c01335bd>] warn_slowpath_null+0xf/0x13
kernel:  [<c0370812>] ata_sff_queue_pio_task+0x26/0x44
kernel:  [<c0370946>] ata_sff_qc_issue+0x116/0x14d
kernel:  [<c03709d6>] ata_bmdma_qc_issue+0x59/0x156
kernel:  [<f844650b>] mv_qc_issue+0x441/0x44d [sata_mv]
kernel:  [<c028ea13>] ? vsnprintf+0x80/0x2d7
kernel:  [<c014b5bb>] ? up+0x2b/0x2f
kernel:  [<c036309d>] ata_qc_issue+0x30b/0x329
kernel:  [<c03638c2>] ata_exec_internal_sg+0x27f/0x4a0
kernel:  [<c036f84b>] ? ata_sff_tf_read+0x53/0xde
kernel:  [<c0363b41>] ata_exec_internal+0x5e/0x66
kernel:  [<c036a0a3>] ? ata_eh_done+0x12/0x18
kernel:  [<c037213a>] sata_pmp_read+0x66/0x9d
kernel:  [<c0372197>] sata_pmp_read_gscr+0x26/0x65
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c03727b8>] sata_pmp_error_handler+0x2ff/0xa42
kernel:  [<c01289e3>] ? dequeue_task_fair+0x1fc/0x204
kernel:  [<c03704f9>] ? ata_sff_drain_fifo+0x5a/0x5a
kernel:  [<f8445f41>] ? mv_port_start+0x19f/0x19f [sata_mv]
kernel:  [<f8445c50>] ? mv_pmp_hardreset+0x8c/0x8c [sata_mv]
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c044194d>] ? __mutex_lock_slowpath+0x1f2/0x1fa
kernel:  [<c013cadd>] ? lock_timer_base+0x1f/0x3e
kernel:  [<f8445bbf>] mv_pmp_error_handler+0x60/0x65 [sata_mv]
kernel:  [<c036e283>] ata_scsi_port_error_handler+0x206/0x522
kernel:  [<c01448f6>] ? cancel_delayed_work_sync+0xb/0xd
kernel:  [<c036e60c>] ata_scsi_error+0x6d/0x8f
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c032ae1a>] scsi_error_handler+0x103/0x507
kernel:  [<c012750b>] ? complete+0x34/0x3e
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c01476c0>] kthread+0x64/0x69
kernel:  [<c014765c>] ? kthread_worker_fn+0x119/0x119
kernel:  [<c0443bbe>] kernel_thread_helper+0x6/0xd
kernel: ---[ end trace cdcd2b0b3f6829ee ]---
kernel: ata10.00: hard resetting link
kernel: ata10.01: hard resetting link
kernel: ata10.01: link resume succeeded after 1 retries
kernel: ata10.02: hard resetting link
kernel: ata10.02: link resume succeeded after 1 retries
kernel: ata10.03: hard resetting link
kernel: ata10.03: link resume succeeded after 1 retries
kernel: ata10.04: hard resetting link
kernel: ata10.04: link resume succeeded after 1 retries
kernel: ata10.05: hard resetting link
kernel: ata10.00: configured for UDMA/133
kernel: ata10.01: configured for UDMA/133
kernel: ata10.02: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
kernel: ata10.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata10.02: configured for UDMA/133
kernel: ata10.03: qc timeout (cmd 0x27)
kernel: ata10.03: failed to read native max address (err_mask=0x4)
kernel: ata10.03: HPA support seems broken, skipping HPA handling
kernel: ata10.15: hard resetting link
kernel: ata10.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ------------[ cut here ]------------
kernel: WARNING: at drivers/ata/libata-sff.c:1322 ata_sff_queue_pio_task+0x26/0x44()
kernel: Hardware name: System Product Name
kernel: Modules linked in: keyspan ati_remote visor pl2303 ftdi_sio pci_hotplug soundcore backlight option processor usb_wwan rtc_cmos thermal_sys rtc_core hwmon parport_pc button snd_page_alloc parport usbserial wmi i2c_i801 evdev rtc_lib sata_mv pcspkr intel_agp intel_gtt agpgart tpm_tis r8169 iTCO_wdt iTCO_vendor_support xhci_hcd ehci_hcd usbcore
kernel: Pid: 1636, comm: scsi_eh_9 Tainted: G        W   2.6.39.1-core2-volpreempt-noide-hm64-20110620 #2
kernel: Call Trace:
kernel:  [<c0133599>] warn_slowpath_common+0x60/0x75
kernel:  [<c01335bd>] warn_slowpath_null+0xf/0x13
kernel:  [<c0370812>] ata_sff_queue_pio_task+0x26/0x44
kernel:  [<c0370946>] ata_sff_qc_issue+0x116/0x14d
kernel:  [<c03709d6>] ata_bmdma_qc_issue+0x59/0x156
kernel:  [<f844650b>] mv_qc_issue+0x441/0x44d [sata_mv]
kernel:  [<c028ea13>] ? vsnprintf+0x80/0x2d7
kernel:  [<c014b5bb>] ? up+0x2b/0x2f
kernel:  [<c036309d>] ata_qc_issue+0x30b/0x329
kernel:  [<c03638c2>] ata_exec_internal_sg+0x27f/0x4a0
kernel:  [<c036f84b>] ? ata_sff_tf_read+0x53/0xde
kernel:  [<c0363b41>] ata_exec_internal+0x5e/0x66
kernel:  [<c036a0a3>] ? ata_eh_done+0x12/0x18
kernel:  [<c037213a>] sata_pmp_read+0x66/0x9d
kernel:  [<c0372197>] sata_pmp_read_gscr+0x26/0x65
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c03727b8>] sata_pmp_error_handler+0x2ff/0xa42
kernel:  [<c01289e3>] ? dequeue_task_fair+0x1fc/0x204
kernel:  [<c03704f9>] ? ata_sff_drain_fifo+0x5a/0x5a
kernel:  [<f8445f41>] ? mv_port_start+0x19f/0x19f [sata_mv]
kernel:  [<f8445c50>] ? mv_pmp_hardreset+0x8c/0x8c [sata_mv]
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c044194d>] ? __mutex_lock_slowpath+0x1f2/0x1fa
kernel:  [<c013cadd>] ? lock_timer_base+0x1f/0x3e
kernel:  [<f8445bbf>] mv_pmp_error_handler+0x60/0x65 [sata_mv]
kernel:  [<c036e283>] ata_scsi_port_error_handler+0x206/0x522
kernel:  [<c01448f6>] ? cancel_delayed_work_sync+0xb/0xd
kernel:  [<c036e60c>] ata_scsi_error+0x6d/0x8f
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c032ae1a>] scsi_error_handler+0x103/0x507
kernel:  [<c012750b>] ? complete+0x34/0x3e
kernel:  [<c032ad17>] ? scsi_eh_get_sense+0x16d/0x16d
kernel:  [<c01476c0>] kthread+0x64/0x69
kernel:  [<c014765c>] ? kthread_worker_fn+0x119/0x119
kernel:  [<c0443bbe>] kernel_thread_helper+0x6/0xd
kernel: ---[ end trace cdcd2b0b3f6829ef ]---
kernel: ata10.00: hard resetting link
kernel: ata10.01: hard resetting link
kernel: ata10.01: link resume succeeded after 1 retries
kernel: ata10.02: hard resetting link
kernel: ata10.02: link resume succeeded after 1 retries
kernel: ata10.03: hard resetting link
kernel: ata10.03: link resume succeeded after 1 retries
kernel: ata10.04: hard resetting link
kernel: ata10.04: link resume succeeded after 1 retries
kernel: ata10.05: hard resetting link
kernel: ata10.00: configured for UDMA/133
kernel: ata10.01: configured for UDMA/133
kernel: ata10.02: configured for UDMA/133
kernel: ata10.03: ATA-7: ST3500630AS, 3.AAE, max UDMA/133
kernel: ata10.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata10.03: configured for UDMA/133
kernel: ata10.04: ATA-7: ST3750640AS, 3.AAK, max UDMA/133
kernel: ata10.04: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata10.04: configured for UDMA/133
kernel: ata10: EH complete
kernel: scsi 9:0:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
kernel: sd 9:0:0:0: [sdc] 976773168 512-byte logical blocks: (500 GB/465 GiB)
kernel: sd 9:0:0:0: [sdc] Write Protect is off
kernel: sd 9:0:0:0: [sdc] Mode Sense: 00 3a 00 00
kernel: sd 9:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 9:1:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
kernel: sd 9:1:0:0: [sdd] 976773168 512-byte logical blocks: (500 GB/465 GiB)
kernel: sd 9:1:0:0: [sdd] Write Protect is off
kernel: sd 9:1:0:0: [sdd] Mode Sense: 00 3a 00 00
kernel: sd 9:1:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 9:2:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
kernel: sd 9:2:0:0: [sde] 976773168 512-byte logical blocks: (500 GB/465 GiB)
kernel: sd 9:2:0:0: [sde] Write Protect is off
kernel: sd 9:2:0:0: [sde] Mode Sense: 00 3a 00 00
kernel: sd 9:2:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 9:3:0:0: Direct-Access     ATA      ST3500630AS      3.AA PQ: 0 ANSI: 5
kernel: sd 9:3:0:0: [sdf] 976773168 512-byte logical blocks: (500 GB/465 GiB)
kernel: sd 9:3:0:0: [sdf] Write Protect is off
kernel: sd 9:3:0:0: [sdf] Mode Sense: 00 3a 00 00
kernel: sd 9:3:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 9:4:0:0: Direct-Access     ATA      ST3750640AS      3.AA PQ: 0 ANSI: 5
kernel: sd 9:4:0:0: [sdg] 1465149168 512-byte logical blocks: (750 GB/698 GiB)
kernel: sd 9:4:0:0: [sdg] Write Protect is off
kernel: sd 9:4:0:0: [sdg] Mode Sense: 00 3a 00 00
kernel: sd 9:4:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel:  sdc: sdc1
kernel: sd 9:0:0:0: [sdc] Attached SCSI disk
kernel:  sdg: sdg1 sdg2
kernel: sd 9:4:0:0: [sdg] Attached SCSI disk
kernel:  sdd: sdd1
kernel: sd 9:1:0:0: [sdd] Attached SCSI disk
kernel:  sde: sde1
kernel:  sdf: sdf1
kernel: sd 9:2:0:0: [sde] Attached SCSI disk
kernel: sd 9:3:0:0: [sdf] Attached SCSI disk
kernel: ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ata11.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
kernel: ata11.00: hard resetting link
kernel: ata11.01: hard resetting link
kernel: ata11.02: hard resetting link
kernel: ata11.03: hard resetting link
kernel: ata11.04: hard resetting link
kernel: ata11.05: hard resetting link
kernel: ata11.00: ATA-8: WDC WD20EADS-00W4B0, 01.00A01, max UDMA/133
kernel: ata11.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata11.00: configured for Uel kernel: ata11.02: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
kernel: ata11.02: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata11.02: configured for UDMA/133
kernel: ata11.03: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
kernel: ata11.03: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata11.03: configured for UDMA/133
kernel: ata11.04: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
kernel: ata11.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
kernel: ata11.04: configured for UDMA/133
kernel: ata11: EH complete
kernel: scsi 10:0:0:0: Direct-Access     ATA      WDC WD20EADS-00W 01.0 PQ: 0 ANSI: 5
kernel: sd 10:0:0:0: [sdh] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
kernel: sd 10:0:0:0: [sdh] Write Protect is off
kernel: sd 10:0:0:0: [sdh] Mode Sense: 00 3a 00 00
kernel: sd 10:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 10:1:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
kernel: sd 10:1:0:0: [sdi] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
kernel: sd 10:1:0:0: [sdi] Write Protect is off
kernel: sd 10:1:0:0: [sdi] Mode Sense: 00 3a 00 00
kernel: sd 10:1:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 10:2:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
kernel: sd 10:2:0:0: [sdj] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
kernel: sd 10:2:0:0: [sdj] Write Protect is off
kernel: sd 10:2:0:0: [sdj] Mode Sense: 00 3a 00 00
kernel: sd 10:2:0:0: [sdj] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 10:3:0:0: Direct-Access     ATA      WDC WD20EADS-00R 01.0 PQ: 0 ANSI: 5
kernel: sd 10:3:0:0: [sdk] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
kernel: sd 10:3:0:0: [sdk] Write Protect is off
kernel: sd 10:3:0:0: [sdk] Mode Sense: 00 3a 00 00
kernel: sd 10:3:0:0: [sdk] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel: scsi 10:4:0:0: Direct-Access     ATA      WDC WD20EADS-00S 01.0 PQ: 0 ANSI: 5
kernel: sd 10:4:0:0: [sdl] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
kernel: sd 10:4:0:0: [sdl] Write Protect is off
kernel: sd 10:4:0:0: [sdl] Mode Sense: 00 3a 00 00
kernel: sd 10:4:0:0: [sdl] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
kernel:  sdi: sdi1
kernel: sd 10:1:0:0: [sdi] Attached SCSI disk
kernel:  sdk: sdk1
kernel: sd 10:3:0:0: [sdk] Attached SCSI disk
kernel:  sdl: sdl1
kernel: sd 10:4:0:0: [sdl] Attached SCSI disk
kernel:  sdj: sdj1
kernel: sd 10:2:0:0: [sdj] Attached SCSI disk
kernel: ata12: SATA link down (SStatus 0 SControl 300)
kernel:  sdh: sdh1
kernel: sd 10:0:0:0: [sdh] Attached SCSI disk


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
