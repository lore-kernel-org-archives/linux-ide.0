From: =?ISO-8859-1?Q?Daniel_Schr=F6der?= <mail@dschroeder.info>
Subject: [PMP] sil3132 st6600 problem
Date: Sat, 11 Nov 2006 02:24:48 +0100
Message-ID: <45552660.4050902@dschroeder.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:40416 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1946866AbWKKBY5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 10 Nov 2006 20:24:57 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hello *,

a couple of weeks ago, i posted a "success" message. This time i have a
strange issue to report. A couple of weeks, with only one Samsung
HD401LJ and everything was fine. Yesterday, i put another drive a
Samsung HD501LJ into the second bay and shortly after this. (After FDISK
and MKFS and a couple of powercycles) The device is completely
unresponsive. With this device on, Windows XP freezes instantly...Linux
shows the following at turning on:

And everytime, when i played with this device, he said something about
USB...WTF?! Same IRQ? I dont think so:

<interrupts>
cat /proc/interrupts
           CPU0
  0:     876859          XT-PIC  timer
  1:       7955          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     466863          XT-PIC  libata, libata, libata, eth1
  7:     347524          XT-PIC  libata, eth0
  9:          0          XT-PIC  acpi
 10:        931          XT-PIC  ehci_hcd:usb1, HDA Intel
 11:     211376          XT-PIC  ohci1394, nvidia
 12:      25578          XT-PIC  i8042
 14:         46          XT-PIC  ide0
NMI:          0
LOC:     876799
ERR:          1
MIS:          0
</interrupts>

beneath you find some logs:

1. first time i put the device on with the new harddisk added
2. "test" of hotplug
3. device is dead

any clues/hints what i could do?

TIA

Daniel

<log-first-time-all-seems-to-be-ok.but why he wrote this with USB at the
time i turn on the device?>
Nov  9 12:35:04 isla-magica hub 1-2:1.0: port 2 disabled by hub (EMI?),
re-enabling...
Nov  9 12:35:04 isla-magica usb 1-2.2: USB disconnect, address 4
Nov  9 12:35:04 isla-magica ata1: exception Emask 0x10 SAct 0x0 SErr
0x10000 action 0x42 frozen
Nov  9 12:35:04 isla-magica ata1: (irq_stat 0x00a00080, device exchanged)
Nov  9 12:35:04 isla-magica usb 1-2.2: new low speed USB device using
ehci_hcd and address 7
Nov  9 12:35:04 isla-magica usb 1-2.2: configuration #1 chosen from 1 choice
Nov  9 12:35:04 isla-magica input: HID 0c12:0005 as /class/input/input3
Nov  9 12:35:04 isla-magica input: USB HID v1.00 Joystick [HID
0c12:0005] on usb-0000:00:0a.1-2.2
Nov  9 12:35:04 isla-magica ata1: waiting for device to spin up (8 secs)
Nov  9 12:35:12 isla-magica ata1: soft resetting port
Nov  9 12:35:12 isla-magica ata1: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  9 12:35:12 isla-magica ata1.15: Port Multiplier 1.1, 0x1095:0x3726
r23, 5 ports, feat 0x9/0x9
Nov  9 12:35:13 isla-magica ata1.00: hard resetting port
Nov  9 12:35:13 isla-magica ata1.00: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  9 12:35:13 isla-magica ata1.01: hard resetting port
Nov  9 12:35:14 isla-magica ata1.01: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  9 12:35:14 isla-magica ata1.02: hard resetting port
Nov  9 12:35:14 isla-magica ata1.02: SATA link down (SStatus 0 SControl 300)
Nov  9 12:35:14 isla-magica ata1.03: hard resetting port
Nov  9 12:35:15 isla-magica ata1.03: SATA link down (SStatus 0 SControl 300)
Nov  9 12:35:15 isla-magica ata1.04: hard resetting port
Nov  9 12:35:15 isla-magica ata1.04: SATA link down (SStatus 0 SControl 300)
Nov  9 12:35:15 isla-magica ata1.00: ATA-7, max UDMA7, 976773168
sectors: LBA48 NCQ (depth 31/32)
Nov  9 12:35:15 isla-magica ata1.00: configured for UDMA/100
Nov  9 12:35:15 isla-magica ata1.01: ATA-7, max UDMA7, 781422768
sectors: LBA48 NCQ (depth 31/32)
Nov  9 12:35:15 isla-magica ata1.01: configured for UDMA/100
Nov  9 12:35:15 isla-magica ata1: EH complete
Nov  9 12:35:15 isla-magica Vendor: ATA       Model: SAMSUNG HD501LJ
Rev: CR10
Nov  9 12:35:15 isla-magica Type:   Direct-Access
ANSI SCSI revision: 05
Nov  9 12:35:15 isla-magica SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  9 12:35:15 isla-magica sdd: Write Protect is off
Nov  9 12:35:15 isla-magica sdd: Mode Sense: 00 3a 00 00
Nov  9 12:35:15 isla-magica SCSI device sdd: drive cache: write back
Nov  9 12:35:15 isla-magica SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  9 12:35:15 isla-magica sdd: Write Protect is off
Nov  9 12:35:15 isla-magica sdd: Mode Sense: 00 3a 00 00
Nov  9 12:35:15 isla-magica SCSI device sdd: drive cache: write back
Nov  9 12:35:15 isla-magica sdd: unknown partition table
Nov  9 12:35:15 isla-magica sd 0:0:0:0: Attached scsi disk sdd
Nov  9 12:35:15 isla-magica sd 0:0:0:0: Attached scsi generic sg3 type 0
Nov  9 12:35:15 isla-magica Vendor: ATA       Model: SAMSUNG HD401LJ
Rev: ZZ10
Nov  9 12:35:15 isla-magica Type:   Direct-Access
ANSI SCSI revision: 05
Nov  9 12:35:15 isla-magica SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)
Nov  9 12:35:15 isla-magica sde: Write Protect is off
Nov  9 12:35:15 isla-magica sde: Mode Sense: 00 3a 00 00
Nov  9 12:35:15 isla-magica SCSI device sde: drive cache: write back
Nov  9 12:35:15 isla-magica SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)
Nov  9 12:35:15 isla-magica sde: Write Protect is off
Nov  9 12:35:15 isla-magica sde: Mode Sense: 00 3a 00 00
Nov  9 12:35:15 isla-magica SCSI device sde: drive cache: write back
Nov  9 12:35:15 isla-magica sde: sde1
Nov  9 12:35:15 isla-magica sd 0:0:1:0: Attached scsi disk sde
Nov  9 12:35:15 isla-magica sd 0:0:1:0: Attached scsi generic sg4 type 0
Nov  9 12:35:15 isla-magica scsi.agent[9175]: disk at
/devices/pci0000:00/0000:00:16.0/0000:06:00.0/host0/target0:0:0/0:0:0:0
Nov  9 12:35:15 isla-magica scsi.agent[9192]: disk at
/devices/pci0000:00/0000:00:16.0/0000:06:00.0/host0/target0:0:1/0:0:1:0
</log-first-time-all-seems-to-be-ok.but why he wrote this with USB at
the time i turn on the device?>


test of hotplug

<log-hotplug>
Nov  9 12:38:44 isla-magica ata1.15: exception Emask 0x100 SAct 0x0 SErr
0x0 action 0x1 frozen
Nov  9 12:38:44 isla-magica ata1.15: (irq_stat 0x08000800, SDB notify)
Nov  9 12:38:44 isla-magica ata1.15: failed to read PMP GSCR[0] (errno=-16)
Nov  9 12:38:44 isla-magica ata1.15: PMP revalidation failed (errno=-16)
Nov  9 12:38:44 isla-magica ata1.15: retrying hardreset
Nov  9 12:38:44 isla-magica ata1.15: hard resetting port
Nov  9 12:38:49 isla-magica ata1.15: SATA link down (SStatus 1 SControl 300)
Nov  9 12:38:50 isla-magica ata1.15: failed to read PMP GSCR[0] (errno=-16)
Nov  9 12:38:50 isla-magica ata1.15: PMP revalidation failed (errno=-16)
Nov  9 12:38:50 isla-magica ata1.15: retrying hardreset in 5 secs
Nov  9 12:38:55 isla-magica ata1.15: hard resetting port
Nov  9 12:38:56 isla-magica hub 1-2:1.0: port 2 disabled by hub (EMI?),
re-enabling...
Nov  9 12:38:56 isla-magica usb 1-2.2: USB disconnect, address 7
Nov  9 12:38:56 isla-magica usb 1-2.2: new low speed USB device using
ehci_hcd and address 8
Nov  9 12:38:56 isla-magica usb 1-2.2: configuration #1 chosen from 1 choice
Nov  9 12:38:56 isla-magica input: HID 0c12:0005 as /class/input/input4
Nov  9 12:38:56 isla-magica input: USB HID v1.00 Joystick [HID
0c12:0005] on usb-0000:00:0a.1-2.2
Nov  9 12:38:58 isla-magica ata1.15: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  9 12:38:59 isla-magica ata1.00: hard resetting port
Nov  9 12:39:00 isla-magica ata1.00: softreset failed (SRST command error)
Nov  9 12:39:00 isla-magica ata1.00: follow-up softreset failed,
retrying in 5 secs
Nov  9 12:39:05 isla-magica ata1.00: hard resetting port
Nov  9 12:39:07 isla-magica ata1.01: hard resetting port
Nov  9 12:39:08 isla-magica ata1.01: COMRESET failed (errno=-16)
Nov  9 12:39:08 isla-magica ata1.01: hardreset failed, retrying in 5 secs
Nov  9 12:39:14 isla-magica ata1.01: hard resetting port
Nov  9 12:39:15 isla-magica ata1.01: COMRESET failed (errno=-16)
Nov  9 12:39:15 isla-magica ata1.01: reset failed, giving up
Nov  9 12:39:15 isla-magica ata1.15: hard resetting port
Nov  9 12:39:15 isla-magica ata1: controller in dubious state,
performing PORT_RST
Nov  9 12:39:17 isla-magica ata1.15: SATA link up 3.0 Gbps (SStatus 123
SControl 0)
Nov  9 12:39:18 isla-magica ata1.00: hard resetting port
Nov  9 12:39:19 isla-magica ata1.00: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Nov  9 12:39:19 isla-magica ata1.01: hard resetting port
Nov  9 12:39:20 isla-magica ata1.01: SATA link up 3.0 Gbps (SStatus 123
SControl 300)
Nov  9 12:39:21 isla-magica ata1.02: hard resetting port
Nov  9 12:39:22 isla-magica ata1.02: SATA link down (SStatus 0 SControl 300)
Nov  9 12:39:22 isla-magica ata1.03: hard resetting port
Nov  9 12:39:23 isla-magica ata1.03: SATA link down (SStatus 0 SControl 300)
Nov  9 12:39:24 isla-magica ata1.04: hard resetting port
Nov  9 12:39:25 isla-magica ata1.04: SATA link down (SStatus 0 SControl 300)
Nov  9 12:39:25 isla-magica ata1.00: configured for UDMA/100
Nov  9 12:39:25 isla-magica ata1.01: configured for UDMA/100
Nov  9 12:39:25 isla-magica ata1: EH pending after completion, repeating
EH (cnt=4)
Nov  9 12:39:25 isla-magica ata1.15: exception Emask 0x10 SAct 0x0 SErr
0x0 action 0x41
Nov  9 12:39:25 isla-magica ata1.15: (irq_stat 0x01900090, PHY RDY changed)
Nov  9 12:39:25 isla-magica ata1: EH complete
Nov  9 12:39:25 isla-magica SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  9 12:39:25 isla-magica sdd: Write Protect is off
Nov  9 12:39:25 isla-magica sdd: Mode Sense: 00 3a 00 00
Nov  9 12:39:25 isla-magica SCSI device sdd: drive cache: write back
Nov  9 12:39:25 isla-magica SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)
Nov  9 12:39:25 isla-magica sde: Write Protect is off
Nov  9 12:39:25 isla-magica sde: Mode Sense: 00 3a 00 00
Nov  9 12:39:25 isla-magica SCSI device sde: drive cache: write back
Nov  9 12:39:25 isla-magica SCSI device sdd: 976773168 512-byte hdwr
sectors (500108 MB)
Nov  9 12:39:25 isla-magica sdd: Write Protect is off
Nov  9 12:39:25 isla-magica sdd: Mode Sense: 00 3a 00 00
Nov  9 12:39:25 isla-magica SCSI device sdd: drive cache: write back
Nov  9 12:39:25 isla-magica SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)
Nov  9 12:39:25 isla-magica sde: Write Protect is off
Nov  9 12:39:25 isla-magica sde: Mode Sense: 00 3a 00 00
Nov  9 12:39:25 isla-magica SCSI device sde: drive cache: write back
</log-hotplug>

and this is bad...

<log-bad>
Nov  9 12:50:40 isla-magica ata1: exception Emask 0x10 SAct 0x0 SErr
0x10000 action 0x42 frozen
Nov  9 12:50:40 isla-magica ata1: (irq_stat 0x00a00080, device exchanged)
Nov  9 12:50:40 isla-magica ata1: waiting for device to spin up (8 secs)
Nov  9 12:50:49 isla-magica ata1: soft resetting port
Nov  9 12:50:57 isla-magica (dschroeder-11893): starting (version
2.14.0), pid 11893 user 'dschroeder'
Nov  9 12:50:57 isla-magica (dschroeder-11893): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only
configuration source at posit
ion 0
Nov  9 12:50:57 isla-magica (dschroeder-11893): Resolved address
"xml:readwrite:/home/dschroeder/.gconf" to a writable configuration
source at position 1
Nov  9 12:50:57 isla-magica (dschroeder-11893): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only
configuration source at positi
on 2
Nov  9 12:51:19 isla-magica ata1: softreset failed (timeout)
Nov  9 12:51:19 isla-magica ata1: softreset failed, retrying in 5 secs
Nov  9 12:51:24 isla-magica ata1: hard resetting port
Nov  9 12:51:56 isla-magica ata1: softreset failed (timeout)
Nov  9 12:51:56 isla-magica ata1: follow-up softreset failed, retrying
in 5 secs
Nov  9 12:52:01 isla-magica ata1: hard resetting port
Nov  9 12:52:33 isla-magica ata1: softreset failed (timeout)
Nov  9 12:52:33 isla-magica ata1: reset failed, giving up
Nov  9 12:52:33 isla-magica ata1: EH complete
Nov  9 12:53:12 isla-magica ata1: exception Emask 0x10 SAct 0x0 SErr
0xc0000 action 0x42 frozen
Nov  9 12:53:16 isla-magica ata1: soft resetting port
Nov  9 12:53:16 isla-magica ata1: SATA link down (SStatus 1 SControl 300)
Nov  9 12:53:16 isla-magica ata1: EH complete
Nov  9 12:53:22 isla-magica ata1: exception Emask 0x10 SAct 0x0 SErr
0x10000 action 0x42 frozen
Nov  9 12:53:22 isla-magica ata1: (irq_stat 0x00a00080, device exchanged)
Nov  9 12:53:22 isla-magica hub 1-2:1.0: port 2 disabled by hub (EMI?),
re-enabling...
Nov  9 12:53:22 isla-magica usb 1-2.2: USB disconnect, address 4
Nov  9 12:53:22 isla-magica usb 1-2.2: new low speed USB device using
ehci_hcd and address 7
Nov  9 12:53:22 isla-magica usb 1-2.2: configuration #1 chosen from 1 choice
Nov  9 12:53:22 isla-magica input: HID 0c12:0005 as /class/input/input3
Nov  9 12:53:22 isla-magica input: USB HID v1.00 Joystick [HID
0c12:0005] on usb-0000:00:0a.1-2.2
Nov  9 12:53:22 isla-magica ata1: waiting for device to spin up (8 secs)
Nov  9 12:53:30 isla-magica ata1: soft resetting port
Nov  9 12:54:00 isla-magica ata1: softreset failed (timeout)
Nov  9 12:54:00 isla-magica ata1: softreset failed, retrying in 5 secs
Nov  9 12:54:05 isla-magica ata1: hard resetting port
Nov  9 12:54:15 isla-magica ntpd[11442]: synchronized to 129.174.135.11,
stratum 2
Nov  9 12:54:15 isla-magica ntpd[11442]: kernel time sync enabled 0001
Nov  9 12:54:37 isla-magica ata1: softreset failed (timeout)
Nov  9 12:54:37 isla-magica ata1: follow-up softreset failed, retrying
in 5 secs
Nov  9 12:54:42 isla-magica ata1: hard resetting port
Nov  9 12:54:52 isla-magica hub 1-2:1.0: port 2 disabled by hub (EMI?),
re-enabling...
Nov  9 12:54:52 isla-magica usb 1-2.2: USB disconnect, address 7
Nov  9 12:54:52 isla-magica usb 1-2.2: new low speed USB device using
ehci_hcd and address 8
Nov  9 12:54:52 isla-magica usb 1-2.2: configuration #1 chosen from 1 choice
Nov  9 12:54:52 isla-magica input: HID 0c12:0005 as /class/input/input4
Nov  9 12:54:52 isla-magica input: USB HID v1.00 Joystick [HID
0c12:0005] on usb-0000:00:0a.1-2.2
Nov  9 12:55:15 isla-magica ata1: softreset failed (timeout)
Nov  9 12:55:15 isla-magica ata1: reset failed, giving up
Nov  9 12:55:15 isla-magica ata1: EH complete
</log-bad>
