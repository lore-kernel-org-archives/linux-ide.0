From: David Meier <droebbel.melta@gmx.de>
Subject: dma problems with via82cxxx after suspend
Date: Mon, 14 Mar 2005 18:54:10 +0100
Message-ID: <1110822850.11750.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from mail.gmx.de ([213.165.64.20]:32655 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261659AbVCNRyP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2005 12:54:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I get DMA errors after resuming from suspend (S3).

I had switched DMA off before suspending.

Kernel: 2.6.10 (ubuntu, 2.6.10-27), same with 2.6.8.1. Boot Parameters:
ro nobiospnp noapic pci=usepirqmask; same problem without those.

Hardware: Asus K8V SE Deluxe, Via K8T800 Chipset, via82cxxx loaded or
compiled in. No errors with a kernel without that module.


This is the last dmesg:

hda: DMA disabled
hdb: DMA disabled
hdc: DMA disabled
hdd: DMA disabled
Stopping tasks: ==============================================|
Back to C!
powernow-k8: ph2 null fid transition 0xc
ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
eth1: link down
ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 11 (level, low) -> IRQ 11
Restarting tasks... done
usb 5-4: USB disconnect, address 3
VFS: busy inodes on changed media.
input: AT Translated Set 2 keyboard on isa0060/serio0
usb 5-4: new high speed USB device using ehci_hcd and address 4
scsi3 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
  Vendor: HL-DT-ST  Model: DVDRAM GSA-4163B  Rev: A101
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr0: scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi3, channel 0, id 0, lun 0,  type 5
usb-storage: device scan complete
hda: dma_timer_expiry: dma status == 0x61
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }

ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }

ide: failed opcode was: unknown
hdb: DMA disabled
hda: drive not ready for command
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }

ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }

ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }

ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }

ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x58 { DriveReady SeekComplete
DataRequest }

ide: failed opcode was: unknown
hda: status timeout: status=0xd0 { Busy }

ide: failed opcode was: unknown
hda: drive not ready for command
ide0: reset: success


Thanks
David


