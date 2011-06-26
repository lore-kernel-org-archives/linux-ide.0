From: Marc MERLIN <marc@merlins.org>
Subject: decoding PMP errors with Marvel SATA controller
Date: Sun, 26 Jun 2011 00:08:20 -0700
Message-ID: <20110626070820.GC24867@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:39038 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1FZHIY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 26 Jun 2011 03:08:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

Howdy

I have a dual sil PMP which has been working well enough, and recently moved
to a new Motherboard.

I had to switch my sil3128 to a sil3132 (PCI-X to PCIe) and it seems to work
ok.
I was however trying to switch to a Marvell card that's supposed to be
faster, but I get errors like these on it:

I think my cables are ok since they work with the sil3132.
I also notice that the real error seems to be with the PMP itself
(ata9.15 SError: { BadCRC Handshk } ) and that the rest is just noise.

Is my Marvell card somewhat bad or incompatible with my PMP?

I have 2.6.39.1

gargamel kernel: sata_mv 0000:02:00.0: version 1.28
gargamel kernel: sata_mv 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
gargamel kernel: sata_mv 0000:02:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
gargamel kernel: sata_mv 0000:02:00.0: setting latency timer to 64
gargamel kernel: scsi8 : sata_mv
gargamel kernel: scsi9 : sata_mv
gargamel kernel: scsi10 : sata_mv
gargamel kernel: scsi11 : sata_mv
gargamel kernel: ata9: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb822000 irq 16
gargamel kernel: ata10: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb824000 irq 16
gargamel kernel: ata11: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb826000 irq 16
gargamel kernel: ata12: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb828000 irq 16

gargamel kernel: ata10: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
gargamel kernel: ata10.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9

Mmmh, dmesg also shows this (9.15 is my other PMP plugged into the same card):

Is the card bad, is it possibly a driver issue, or could it still be a sata cable issue?

kernel: ata9.00: qc timeout (cmd 0xec)
kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
kernel: ata9.15: hard resetting link
kernel: ata9.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ------------[ cut here ]------------
kernel: WARNING: at drivers/ata/libata-sff.c:1322 ata_sff_queue_pio_task+0x26/0x44()
kernel: Hardware name: System Product Name
kernel: Modules linked in: usbserial pci_hotplug processor thermal_sys wmi parport_pc hwmon button parport r8169 rtc_core snd rtc_lib i2c_i801 xhci_hcd ehci_hcd soundcore sata_mv snd_page_alloc evdev pcspkr iTCO_wdt iTCO_vendor_support intel_agp intel_gtt tpm_tis agpgart usbcore
kernel: Pid: 1642, comm: scsi_eh_8 Not tainted 2.6.39.1-core2-volpreempt-noide-hm64-20110620 #2
kernel: Call Trace:
kernel:  [<c0133599>] warn_slowpath_common+0x60/0x75
kernel:  [<c01335bd>] warn_slowpath_null+0xf/0x13
kernel:  [<c0370812>] ata_sff_queue_pio_task+0x26/0x44
kernel:  [<c0370946>] ata_sff_qc_issue+0x116/0x14d
kernel:  [<c03709d6>] ata_bmdma_qc_issue+0x59/0x156
kernel:  [<f84b150b>] mv_qc_issue+0x441/0x44d [sata_mv]
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
kernel:  [<f84b0f41>] ? mv_port_start+0x19f/0x19f [sata_mv]
kernel:  [<f84b0c50>] ? mv_pmp_hardreset+0x8c/0x8c [sata_mv]
kernel:  [<c0371e77>] ? ata_sff_softreset+0x150/0x150
kernel:  [<c044194d>] ? __mutex_lock_slowpath+0x1f2/0x1fa
kernel:  [<c013cadd>] ? lock_timer_base+0x1f/0x3e
kernel:  [<f84b0bbf>] mv_pmp_error_handler+0x60/0x65 [sata_mv]
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

This is the error that happens a lot with the sata_mv card, but not the sil24 one:

ata9.15: exception Emask 0x100 SAct 0x0 SErr 0x600000 action 0x6 frozen
ata9.15: edma_err_cause=02320080 pp_flags=00000007, EDMA self-disable
ata9.15: SError: { BadCRC Handshk }
ata9.00: exception Emask 0x100 SAct 0x2 SErr 0x0 action 0x6 frozen
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/78:08:e7:0f:b8/02:00:01:00:00/40 tag 1 ncq 323584 in
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.00: status: { DRDY }
ata9.01: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
ata9.01: failed command: READ FPDMA QUEUED
ata9.01: cmd 60/80:18:df:0f:b8/02:00:01:00:00/40 tag 3 ncq 327680 in
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.01: status: { DRDY }
ata9.02: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
ata9.02: failed command: READ FPDMA QUEUED
ata9.02: cmd 60/80:00:df:0f:b8/02:00:01:00:00/40 tag 0 ncq 327680 in
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.02: status: { DRDY }
ata9.03: exception Emask 0x100 SAct 0x74 SErr 0x0 action 0x6 frozen
ata9.03: failed command: WRITE FPDMA QUEUED
ata9.03: cmd 61/08:10:d7:0f:b8/00:00:01:00:00/40 tag 2 ncq 4096 out
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.03: status: { DRDY }
ata9.03: failed command: WRITE FPDMA QUEUED
ata9.03: cmd 61/88:20:3f:0c:b8/03:00:01:00:00/40 tag 4 ncq 462848 out
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.03: status: { DRDY }
ata9.03: failed command: WRITE FPDMA QUEUED
ata9.03: cmd 61/08:28:c7:0f:b8/00:00:01:00:00/40 tag 5 ncq 4096 out
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.03: status: { DRDY }
ata9.03: failed command: WRITE FPDMA QUEUED
ata9.03: cmd 61/08:30:cf:0f:b8/00:00:01:00:00/40 tag 6 ncq 4096 out
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.03: status: { DRDY }
ata9.04: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
ata9.04: failed command: READ FPDMA QUEUED
ata9.04: cmd 60/80:38:df:0f:b8/02:00:01:00:00/40 tag 7 ncq 327680 in
         res 40/00:2c:c7:0f:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.04: status: { DRDY }
ata9.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata9.15: exception Emask 0x100 SAct 0x0 SErr 0x600000 action 0x6 frozen
ata9.15: edma_err_cause=02320080 pp_flags=00000007, EDMA self-disable
ata9.15: SError: { BadCRC Handshk }
ata9.00: exception Emask 0x100 SAct 0x11110611 SErr 0x0 action 0x6 frozen
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/08:00:17:de:b8/00:00:01:00:00/40 tag 0 ncq 4096 in
         res 40/00:1c:6f:da:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.00: status: { DRDY }
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/08:20:1f:de:b8/00:00:01:00:00/40 tag 4 ncq 4096 in
         res 40/00:1c:6f:da:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.00: status: { DRDY }
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/98:48:7f:da:b8/03:00:01:00:00/40 tag 9 ncq 471040 in
         res 40/00:1c:6f:da:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.00: status: { DRDY }
ata9.00: failed command: READ FPDMA QUEUED
ata9.00: cmd 60/08:50:27:de:b8/00:00:01:00:00/40 tag 10 ncq 4096 in
         res 40/00:1c:6f:da:b8/00:00:01:00:00/40 Emask 0x100 (unknown error)
ata9.00: status: { DRDY }


Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
