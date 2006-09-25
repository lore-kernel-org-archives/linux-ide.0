From: "Trent George" <trent@norwalkdist.com>
Subject: dvd-r detection problem with port multiplier
Date: Mon, 25 Sep 2006 10:38:13 -0700
Message-ID: <KMS-2137222924-2156@mail.norwalkdist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-64-165-178-101.dsl.lsan03.pacbell.net ([64.165.178.101]:32007
	"EHLO mail.norwalkdist.com") by vger.kernel.org with ESMTP
	id S1751322AbWIYRhm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Sep 2006 13:37:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi Tejun,

Thanks for your clarification and advice.
I downloaded the 2.6.17.4, applied the combined.patch and recompiled
It seems to detect the port multiplier now... but...
now both drives are gone.
it seems like it times out and the dvdr drive "seek"
I should have mentioned that they have sata to pata bridgeboards
on the drives.
I tried rebooting, with discs in and not in the drives.
I can send you a physical bridgeboard, or drive if it helps you...
the samsung hard drive is on the motherboard sata controller.
the dvd drives are on pmp on the sata_sil24 board

Thanks
Trent George


uname -a
Linux suse 2.6.17.4-libata #3 SMP Mon Sep 25 00:46:35 PDT 2006 x86_64 x86_64 x86_64 GNU/Linux

dmesg snip

libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
GSI 19 sharing vector 0xE1 and IRQ 19
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD802 bmdma 0xE400 irq 225
ata2: SATA max UDMA/133 cmd 0xDC00 ctl 0xE002 bmdma 0xE408 irq 225
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA7, 312579695 sectors: LBA48
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2: SATA port has no device.
ATA: abnormal status 0x7F on port 0xDC07
  Vendor: ATA       Model: SAMSUNG SP1614C   Rev: SW10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312579695 512-byte hdwr sectors (160041 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 > sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sata_sil24 0000:01:00.0: version 0.3
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
scsi2 : sata_sil24
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata3.00: hard resetting port
ata3.00: softreset failed (timeout)
ata3.00: follow-up softreset failed, retrying in 5 secs
ata3.00: hard resetting port
ata3.00: COMRESET failed (errno=3D-16)
ata3.00: reset failed, giving up
ata3.15: hard resetting port
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: hard resetting port
ata3.00: softreset failed (timeout)
ata3.00: follow-up softreset failed, retrying in 5 secs
ata3.00: hard resetting port
ata3.00: COMRESET failed (errno=3D-16)
ata3.00: reset failed, giving up
ata3.00: failed to recover link after 2 tries, disabling
ata3: failed to recover PMP, retrying in 5 secs
ata3.15: hard resetting port
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.01: hard resetting port
ata3.01: softreset failed (SRST command error)
ata3.01: follow-up softreset failed, retrying in 5 secs
ata3.01: hard resetting port
ata3.01: softreset failed (SRST command error)
ata3.01: reset failed, giving up
ata3.15: hard resetting port
ata3: controller in dubious state, performing PORT_RST
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.01: hard resetting port
ata3.01: softreset failed (SRST command error)
ata3.01: follow-up softreset failed, retrying in 5 secs
ata3.01: hard resetting port
ata3.01: softreset failed (SRST command error)
ata3.01: reset failed, giving up
ata3.01: failed to recover link after 2 tries, disabling
ata3: failed to recover PMP, retrying in 5 secs
ata3.15: hard resetting port
ata3: controller in dubious state, performing PORT_RST
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.02: hard resetting port
ata3.02: SATA link down (SStatus 0 SControl 300)
ata3.03: hard resetting port
ata3.03: SATA link down (SStatus 0 SControl 300)
ata3.04: hard resetting port
ata3.04: SATA link down (SStatus 0 SControl 300)
ata3: EH pending after completion, repeating EH (cnt=3D4)
ata3.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x1
ata3.15: (irq_stat 0x08000800, SDB notify)
ata3: EH complete
Losing some ticks... checking if CPU frequency changed.
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)



and here was 2.6.18, without the port multiplier patch

uname -a

Linux suse 2.6.18-smp #1 SMP Sat Sep 23 11:13:06 PDT 2006 x86_64 x86_64 x86_64 GNU/Linux

lspci -v

01:00.0 Mass storage controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II
 Controller (rev 01)
        Subsystem: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at e1004000 (64-bit, non-prefetchable) [size=3D128]
        Memory at e1000000 (64-bit, non-prefetchable) [size=3D16K]
        I/O ports at 9000 [size=3D128]
        [virtual] Expansion ROM at 80000000 [disabled] [size=3D512K]
        Capabilities: [54] Power Management version 2
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable
-
        Capabilities: [70] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting


dmesg snip

sata_sil24 0000:01:00.0: version 0.3
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:01:00.0 to 64
ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 169
Losing some ticks... checking if CPU frequency changed.
sd 0:0:0:0: Attached scsi generic sg0 type 0
ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 169
scsi2 : sata_sil24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATAPI, max UDMA/66
ata3.00: configured for UDMA/66
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: _NEC      Model: DVD_RW ND-3550A   Rev: 1.G3
  Type:   CD-ROM                             ANSI SCSI revision: 05
scsi 2:0:0:0: Attached scsi generic sg1 type 5
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Processor [CPU1] (supports 2 throttling states)
sr0: scsi3-mmc drive: 48x/48x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 2:0:0:0: Attached scsi CD-ROM sr0


> Trent George wrote:
> > Hi Tejun,
> > 
> > I am a novice to linux.
> > I installed suse 10.1
> > Downloaded a frest kernel source 2.6.18, compiled and installed.
> > 
> > In windows I can see both dvd-r on the port multiplier
> > In linux, it seems only the first drive is available.
> > I posted some info from the machine.
> > 
> > Please advise if you need anything else to help diagnose the problem.=

> > 
> > I assume the problem may be related to the SStatus 123 ?
> > I dont know if you have tested optical drives, or only hard drives on=
 the mulitplier. I hope to build a tower of 20+ drives.
> 
> PMP support isn't yet included in the mainline kernel, so libata can 
> only see the first device.  I haven't updated libata-tj-stable yet, so =

> if you wanna use PMP support, you'll have to use 2.6.17.4 + 
> libata-tj-stable patch.  Please take a look at the following page.
> 
> http://home-tj.org/wiki/index.php/Libata-tj-stable
> 
> -- 
> tejun

