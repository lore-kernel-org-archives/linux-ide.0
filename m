From: Greg Felix <gregfelixlkml@gmail.com>
Subject: Re: PROBLEM: ICH7 SATA drive not detected.
Date: Mon, 28 Feb 2005 10:22:06 -0700
Message-ID: <e16ac85e0502280922740df782@mail.gmail.com>
References: <e16ac85e050225153649939bed@mail.gmail.com>
	 <421FBC0B.5070004@pobox.com>
	 <e16ac85e05022517024beb5b38@mail.gmail.com>
	 <421FFC86.7090802@pobox.com>
Reply-To: Greg Felix <gregfelixlkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <421FFC86.7090802@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Fri, 25 Feb 2005 23:35:18 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Comment out the function call to piix_disable_ahci() and see what happens.
> 
>          if (port_info[0]->host_flags & PIIX_FLAG_AHCI) {
>                  int rc = piix_disable_ahci(pdev);
>                  if (rc)
>                          return rc;
>          }
Jeff,

I commented out everything you showed me and recompiled.  This seems
to have worked.  The hard disk shows up as sda.  What does it mean
that this worked? Is this a bug with ata_piix?  What changes will need
to be made to get this machine to work on an unmodified kernel?

Thanks for your help so far.
Greg

Here's the valid part of dmesg for the boot that works:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 17 (level, low) -> IRQ 17
ICH7: chipset revision 0
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x10a0-0x10a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x10a8-0x10af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
libata version 1.10 loaded.
usb 3-1: new full speed USB device using uhci_hcd and address 2
hda: LITE-ON CD-ROM LTN-487T, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ata_piix version 1.03
PCI: Enabling device 0000:00:1f.2 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x10D8 ctl 0x10F2 bmdma 0x10B0 irq 19
ata2: SATA max UDMA/133 cmd 0x10E0 ctl 0x10F6 bmdma 0x10B8 irq 19
ata1: dev 0 cfg 49:2f00 82:3069 83:7e01 84:4023 85:3069 86:3c01 87:4023 88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0x10E7
ata2: disabling port
scsi1 : ata_piix
  Vendor: ATA       Model: WDC WD800JD-60LU  Rev: 05.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
Initializing USB Mass Storage driver...
scsi2 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
