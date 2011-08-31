From: Marc MERLIN <marc@merlins.org>
Subject: Decoding marvel + Sil PMP errors / NCQ disabled due to excessive errors / 1.5G downgrade
Date: Tue, 30 Aug 2011 19:20:05 -0700
Message-ID: <20110831022005.GI19892@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:43160 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab1HaCUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2011 22:20:11 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Mark Lord <mlord@pobox.com>

Hi Mark and Tejun,

Would you have any idea of what I'm seeing here?

This is with kernel 3.0.1,
02:00.0 SCSI storage controller: Marvell Technology Group Ltd. 88SX7042 PCI-e 4-port SATA-II (rev 02)

and a Sil PMP.
FIRMWARE_ID:      0x10953726
FIRMWARE_VER:     0x00010114
FIRMWARE_CSUM:    0x5aee2538

I seem to have the same error at boot under heavy read/write (raid rebuild),
the bus resets to 1.5Gbit with NCQ disabled, and then it's mostly stable
(occasional errors, but no failures).

So it works, but of course performance is not good.

Am I stuck with this, or is there a way to avoid those errors and
stay at 3G?
Is there an issue with NCQ on my drives?
Is there any chance I have a bad cable or a bad sata_nv card?
Anything else you can think of?

Thanks,
Marc


Relevant boot messages:
sata_mv 0000:02:00.0: version 1.28
sata_mv 0000:02:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
sata_mv 0000:02:00.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
sata_mv 0000:02:00.0: setting latency timer to 64
scsi8 : sata_mv
scsi9 : sata_mv
scsi10 : sata_mv
scsi11 : sata_mv
ata9: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb822000 irq 16
ata10: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb824000 irq 16
ata11: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb826000 irq 16
ata12: SATA max UDMA/133 mmio m1048576@0xfb800000 port 0xfb828000 irq 16


ata11: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: ATA-8: WDC WD20EARS-00MVWB0, 51.0AB51, max UDMA/133
ata11.00: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.00: configured for UDMA/133
ata11.01: ATA-8: WDC WD20EADS-00W4B0, 01.00A01, max UDMA/133
ata11.01: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.01: configured for UDMA/133
ata11.02: ATA-8: WDC WD20EADS-00S2B0, 01.00A01, max UDMA/133
ata11.02: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.02: configured for UDMA/133
ata11.03: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata11.03: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.03: configured for UDMA/133
ata11.04: ATA-8: WDC WD20EADS-00R6B0, 01.00A01, max UDMA/133
ata11.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata11.04: configured for UDMA/133
ata11: EH complete


Then, it fails and falls back to 1.5G soon after. Choice lines:
ata11.03: device reported invalid CHS sector 0
ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
ata11: EH complete
ata11: illegal qc_active transition (00000ff8->00000f79)
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.00: NCQ disabled due to excessive errors
ata11.15: SError: { Handshk }


Fulll log below:
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.01: failed to read SCR 1 (Emask=0x40)
ata11.02: failed to read SCR 1 (Emask=0x40)
ata11.03: failed to read SCR 1 (Emask=0x40)
ata11.04: failed to read SCR 1 (Emask=0x40)
ata11.05: failed to read SCR 1 (Emask=0x40)
ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: edma_err_cause=42200000 pp_flags=00000007
ata11.15: SError: { Handshk }
ata11.00: exception Emask 0x100 SAct 0x20d SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:00:2f:09:fb/00:00:1a:00:00/40 tag 0 ncq 4096 out
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/e0:10:3f:05:fb/03:00:1a:00:00/40 tag 2 ncq 507904 out
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:18:1f:09:fb/00:00:1a:00:00/40 tag 3 ncq 4096 out
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:48:27:09:fb/00:00:1a:00:00/40 tag 9 ncq 4096 out
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.01: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/f8:38:3f:09:fb/03:00:1a:00:00/40 tag 7 ncq 520192 in
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.01: status: { Busy }
ata11.02: exception Emask 0x100 SAct 0x40 SErr 0x0 action 0x6 frozen
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/f8:30:3f:09:fb/03:00:1a:00:00/40 tag 6 ncq 520192 in
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.02: status: { Busy }
ata11.03: exception Emask 0x100 SAct 0x400 SErr 0x0 action 0x6 frozen
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/f8:50:3f:09:fb/03:00:1a:00:00/40 tag 10 ncq 520192 in
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.03: status: { Busy }
ata11.04: exception Emask 0x100 SAct 0x20 SErr 0x0 action 0x6 frozen
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/00:28:37:09:fb/04:00:1a:00:00/40 tag 5 ncq 524288 in
         res c0/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x2 (HSM violation)
ata11.04: status: { Busy }
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: hard resetting link
ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: configured for UDMA/133
ata11.01: configured for UDMA/133
ata11.02: configured for UDMA/133
ata11.03: configured for UDMA/133
ata11.04: configured for UDMA/133
ata11: EH complete
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.01: failed to read SCR 1 (Emask=0x40)
ata11.02: failed to read SCR 1 (Emask=0x40)
ata11.03: failed to read SCR 1 (Emask=0x40)
ata11.04: failed to read SCR 1 (Emask=0x40)
ata11.05: failed to read SCR 1 (Emask=0x40)
ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
ata11.15: SError: { Handshk }
ata11.00: exception Emask 0x100 SAct 0xa SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:08:17:bd:04/00:00:1b:00:00/40 tag 1 ncq 4096 out
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.00: status: { DRDY }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/e0:18:37:b9:04/03:00:1b:00:00/40 tag 3 ncq 507904 out
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.00: status: { DRDY }
ata11.01: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/b0:00:37:bd:04/03:00:1b:00:00/40 tag 0 ncq 483328 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.01: status: { DRDY }
ata11.02: exception Emask 0x100 SAct 0x100 SErr 0x0 action 0x6 frozen
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/b0:40:37:bd:04/03:00:1b:00:00/40 tag 8 ncq 483328 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.02: status: { DRDY }
ata11.03: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/b8:38:2f:bd:04/03:00:1b:00:00/40 tag 7 ncq 487424 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.03: status: { DRDY }
ata11.04: exception Emask 0x100 SAct 0x10000420 SErr 0x0 action 0x6 frozen
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/b8:28:2f:bd:04/03:00:1b:00:00/40 tag 5 ncq 487424 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.04: status: { DRDY }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/08:50:27:bd:04/00:00:1b:00:00/40 tag 10 ncq 4096 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.04: status: { DRDY }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/08:e0:1f:bd:04/00:00:1b:00:00/40 tag 28 ncq 4096 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x100 (unknown error)
ata11.04: status: { DRDY }
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: hard resetting link
ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: configured for UDMA/133
ata11.01: configured for UDMA/133
ata11.02: configured for UDMA/133
ata11.03: configured for UDMA/133
ata11.04: configured for UDMA/133
ata11: EH complete
ata11: illegal qc_active transition (000000fc->100000dc)
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: sending SIO Poll request
usb 2-1.6.4: read status 0 0
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
usb 2-1.6.4: 5 byte block, baudrate 6, databits 8, u1 0, u2 1
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.01: failed to read SCR 1 (Emask=0x40)
ata11.02: failed to read SCR 1 (Emask=0x40)
ata11.03: failed to read SCR 1 (Emask=0x40)
ata11.04: failed to read SCR 1 (Emask=0x40)
ata11.05: failed to read SCR 1 (Emask=0x40)
ata11.15: exception Emask 0x4 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.00: exception Emask 0x100 SAct 0x200 SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:48:27:bd:04/00:00:1b:00:00/40 tag 9 ncq 4096 out
         res 40/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x4 (timeout)
ata11.00: status: { DRDY }
ata11.01: exception Emask 0x100 SAct 0x3 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/00:00:e7:c0:04/04:00:1b:00:00/40 tag 0 ncq 524288 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.01: status: { DRDY }
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/38:08:e7:c4:04/00:00:1b:00:00/40 tag 1 ncq 28672 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.01: status: { DRDY }
ata11.02: exception Emask 0x100 SAct 0x8 SErr 0x0 action 0x6 frozen
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/b0:18:37:bd:04/03:00:1b:00:00/40 tag 3 ncq 483328 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.02: status: { DRDY }
ata11.03: exception Emask 0x100 SAct 0x14 SErr 0x0 action 0x6 frozen
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/00:10:e7:c0:04/04:00:1b:00:00/40 tag 2 ncq 524288 in
         res 40/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x4 (timeout)
ata11.03: status: { DRDY }
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/38:20:e7:c4:04/00:00:1b:00:00/40 tag 4 ncq 28672 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata11.03: status: { DRDY }
ata11.04: exception Emask 0x100 SAct 0x1e0 SErr 0x0 action 0x6 frozen
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/08:28:1f:bd:04/00:00:1b:00:00/40 tag 5 ncq 4096 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.04: status: { DRDY }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/00:30:e7:c0:04/04:00:1b:00:00/40 tag 6 ncq 524288 in
         res 40/00:48:27:09:fb/00:00:1a:00:00/40 Emask 0x4 (timeout)
ata11.04: status: { DRDY }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/b8:38:2f:bd:04/03:00:1b:00:00/40 tag 7 ncq 487424 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.04: status: { DRDY }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/38:40:e7:c4:04/00:00:1b:00:00/40 tag 8 ncq 28672 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.04: status: { DRDY }
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: hard resetting link
ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.05: limiting SATA link speed to 1.5 Gbps
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: configured for UDMA/133
ata11.01: configured for UDMA/133
ata11.02: configured for UDMA/133
ata11.03: configured for UDMA/133
ata11.04: configured for UDMA/133
ata11.03: device reported invalid CHS sector 0
ata11: EH complete
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.01: failed to read SCR 1 (Emask=0x40)
ata11.02: failed to read SCR 1 (Emask=0x40)
ata11.03: failed to read SCR 1 (Emask=0x40)
ata11.04: failed to read SCR 1 (Emask=0x40)
ata11.05: failed to read SCR 1 (Emask=0x40)
ata11.15: exception Emask 0x100 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: edma_err_cause=42200080 pp_flags=00000007, EDMA self-disable
ata11.15: SError: { Handshk }
ata11.00: exception Emask 0x100 SAct 0x32 SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/a8:08:b7:f8:34/03:00:1b:00:00/40 tag 1 ncq 479232 out
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:20:5f:fc:34/00:00:1b:00:00/40 tag 4 ncq 4096 out
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/08:28:67:fc:34/00:00:1b:00:00/40 tag 5 ncq 4096 out
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.00: status: { Busy }
ata11.01: exception Emask 0x100 SAct 0x10400 SErr 0x0 action 0x6 frozen
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/00:50:77:fc:34/04:00:1b:00:00/40 tag 10 ncq 524288 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.01: status: { Busy }
ata11.01: failed command: READ FPDMA QUEUED
ata11.01: cmd 60/38:80:77:00:35/00:00:1b:00:00/40 tag 16 ncq 28672 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.01: status: { Busy }
ata11.02: exception Emask 0x100 SAct 0xd SErr 0x0 action 0x6 frozen
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/08:00:6f:fc:34/00:00:1b:00:00/40 tag 0 ncq 4096 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.02: status: { Busy }
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/00:10:77:fc:34/04:00:1b:00:00/40 tag 2 ncq 524288 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.02: status: { Busy }
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/38:18:77:00:35/00:00:1b:00:00/40 tag 3 ncq 28672 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.02: status: { Busy }
ata11.03: exception Emask 0x100 SAct 0x3000 SErr 0x0 action 0x6 frozen
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/00:60:77:fc:34/04:00:1b:00:00/40 tag 12 ncq 524288 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.03: status: { Busy }
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/38:68:77:00:35/00:00:1b:00:00/40 tag 13 ncq 28672 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.03: status: { Busy }
ata11.04: exception Emask 0x100 SAct 0x4200 SErr 0x0 action 0x6 frozen
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/40:48:6f:00:35/00:00:1b:00:00/40 tag 9 ncq 32768 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.04: status: { Busy }
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/00:70:6f:fc:34/04:00:1b:00:00/40 tag 14 ncq 524288 in
         res c0/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x2 (HSM violation)
ata11.04: status: { Busy }
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: hard resetting link
ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: configured for UDMA/133
ata11.01: configured for UDMA/133
ata11.02: configured for UDMA/133
ata11.03: configured for UDMA/133
ata11.04: configured for UDMA/133
ata11: EH complete
ata11: illegal qc_active transition (00000ff8->00000f79)
ata11.00: failed to read SCR 1 (Emask=0x40)
ata11.00: NCQ disabled due to excessive errors
ata11.01: failed to read SCR 1 (Emask=0x40)
ata11.02: failed to read SCR 1 (Emask=0x40)
ata11.02: NCQ disabled due to excessive errors
ata11.03: failed to read SCR 1 (Emask=0x40)
ata11.03: NCQ disabled due to excessive errors
ata11.04: failed to read SCR 1 (Emask=0x40)
ata11.04: NCQ disabled due to excessive errors
ata11.05: failed to read SCR 1 (Emask=0x40)
ata11.15: exception Emask 0x4 SAct 0x0 SErr 0x400000 action 0x6 frozen
ata11.15: SError: { Handshk }
ata11.00: exception Emask 0x100 SAct 0x18 SErr 0x0 action 0x6 frozen
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/f8:18:77:fc:34/03:00:1b:00:00/40 tag 3 ncq 520192 out
         res 40/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.00: status: { DRDY }
ata11.00: failed command: WRITE FPDMA QUEUED
ata11.00: cmd 61/40:20:6f:00:35/00:00:1b:00:00/40 tag 4 ncq 32768 out
         res 40/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.00: status: { DRDY }
ata11.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.02: exception Emask 0x100 SAct 0x82 SErr 0x0 action 0x6 frozen
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/c0:08:af:00:35/03:00:1b:00:00/40 tag 1 ncq 491520 in
         res 40/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.02: status: { DRDY }
ata11.02: failed command: READ FPDMA QUEUED
ata11.02: cmd 60/08:38:6f:fc:34/00:00:1b:00:00/40 tag 7 ncq 4096 in
         res 40/00:04:37:bd:04/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.02: status: { DRDY }
ata11.03: exception Emask 0x100 SAct 0x4 SErr 0x0 action 0x6 frozen
ata11.03: failed command: READ FPDMA QUEUED
ata11.03: cmd 60/c0:10:af:00:35/03:00:1b:00:00/40 tag 2 ncq 491520 in
         res 40/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.03: status: { DRDY }
ata11.04: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
ata11.04: failed command: READ FPDMA QUEUED
ata11.04: cmd 60/c0:00:af:00:35/03:00:1b:00:00/40 tag 0 ncq 491520 in
         res 40/00:20:5f:fc:34/00:00:1b:00:00/40 Emask 0x4 (timeout)
ata11.04: status: { DRDY }
ata11.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata11.15: hard resetting link
ata11.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata11.00: hard resetting link
ata11.01: hard resetting link
ata11.02: hard resetting link
ata11.03: hard resetting link
ata11.04: hard resetting link
ata11.05: hard resetting link
ata11.00: configured for UDMA/133
ata11.01: configured for UDMA/133
ata11.02: configured for UDMA/133
ata11.03: configured for UDMA/133
ata11.04: configured for UDMA/133
ata11: EH complete

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
