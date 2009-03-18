From: =?KOI8-R?Q?=F7=CC=C1=C4=C9=CD=C9=D2_=E4=C1=DB=C5=D7=D3=CB=C9=CA?=
	<vladimir.dashevsky@gmail.com>
Subject: hot plug on ICH9 with AHCI on
Date: Thu, 19 Mar 2009 01:12:39 +0300
Message-ID: <49C171D7.1080706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53653 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZCRW0q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 18:26:46 -0400
Received: by ewy24 with SMTP id 24so241109ewy.13
        for <linux-ide@vger.kernel.org>; Wed, 18 Mar 2009 15:26:42 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff!

I have some questions concerning HOTPLUG and RAID support for ICH9 chip 
used in my server.
I spent some time to know what is linux kernel support for enclosure 
LEDs in HDD bays. I found no such support however it is described into 
ICH9' datasheet. I am using linux debian with kernel 2.6.25. Latest 
kernel for debian is 2.6.26 and it also does not have any enclosure 
management support. However, I found some support in sources of kernel 
2.6.28, however it seems only activity led is supported. That's why I 
wrote a little kernel module wich takes control over that ACHI 
functionality and tries to do enclosure management just behind 
traditional ahci driver. It works fine but I faced to one strange thing. 
Namely, I can control LEDs of those drives that are physically inserted 
into backplane. If the slot is empty since last reboot its LEDS cannot 
be controlled. I studied why this is so. An answer to this seems to be 
that ahci driver does not enable entire port of SATA controller if it is 
not populated during boot. To check this I tried some hot swap actions. 
First, I have extracted one of my spare drives and push it back. I got 
the following logs:
--
ata3: exception Emask 0x50 SAct 0x0 SErr 0x4090800 action 0xe frozen
ata3: irq_stat 0x00400040, connection status changed
ata3: SError: { HostInt PHYRdyChg 10B8B DevExch }
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3: failed to recover some devices, retrying in 5 secs
ata3: hard resetting link
ata3: SATA link down (SStatus 0 SControl 300)
ata3.00: disabled
ata3: EH complete
ata3.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdc] Synchronizing SCSI cache
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
sd 2:0:0:0: [sdc] Stopping disk
sd 2:0:0:0: [sdc] START_STOP FAILED
sd 2:0:0:0: [sdc] Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK,SUGGEST_OK
ahci em: 40: post command 00080002
ata3: exception Emask 0x10 SAct 0x0 SErr 0x4050002 action 0xa frozen
ata3: irq_stat 0x00400040, connection status changed
ata3: SError: { RecovComm PHYRdyChg CommWake DevExch }
ata3: hard resetting link
ata3: softreset failed (device not ready)
ata3: hard resetting link
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7: ST3500320AS, SD04, max UDMA/133
ata3.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata3: EH complete
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
--
This log is strange for me. It seems that system missed the point that 
the drives was going out. First it tried to reinitialize the SATA link 
for three times. Then, it tried to sync caches and stop the drive when 
it has actually lost connection with HBA. Then disk was returned to the 
slot and its softreset failed. Why? I suspect the drive did not fully 
start when the host tried to establish connection to it.

Another thing happened when I extracted the drive from one slot and 
pushed it back into its neigbor that was empty during linux boot up. 
Kernel desided this slot is dummy:
---
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0xb impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601100 irq 1275
ata2: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601180 irq 1275
ata3: DUMMY
ata4: SATA max UDMA/133 abar m2048@0xd8601000 port 0xd8601280 irq 1275
ata5: DUMMY
ata6: DUMMY
---

So,  even if I put the drive as ata3 device kernel does nothing to start it.

Now my questions:
1. Is it possible to force all ports to be potentially populated during 
startup. I would prefer that all ICH9 SATA ports will have their own 
fixed names, eg. /dev/sata0, ..., /dev/sata5. For now I have 3 drives 
and they allways get names /dev/sda /dev/sdb /dev/sdc even if there is 
some empty port as shown above. This is not convenient because enclosure 
management is linked to physical ports, not to only populated ones.
2. How can I remove SATA drive safely? I mean the behavior similar to 
USB drives removing. I'd like to notify the system that i wish to remove 
the drive. Then it performs some actions as closing all current 
connections, stopping new connections, flushing caches etc. After all 
that it updates indicators on backplane showing me that the drive is 
ready to be removed. As I see, some portions of this procedure can be 
done using hdparm -f -F -Y, but not all.

With best regards, Vladimir Dashevsky




