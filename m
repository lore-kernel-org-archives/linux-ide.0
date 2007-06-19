From: Jeff Gustafson <jeffgus@zimage.com>
Subject: SiI 3124 bus reset issues
Date: Tue, 19 Jun 2007 16:16:20 -0700
Message-ID: <1182294980.7072.31.camel@sally>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.zimage.com ([216.86.199.5]:42667 "EHLO alpha.zimage.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756519AbXFSXtj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jun 2007 19:49:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by alpha.zimage.com (Postfix) with ESMTP id 34B681C2C79
	for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 16:17:09 -0700 (PDT)
Received: from alpha.zimage.com ([127.0.0.1])
 by localhost (alpha.zimage.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 01552-01 for <linux-ide@vger.kernel.org>;
 Tue, 19 Jun 2007 16:16:28 -0700 (PDT)
Received: from [192.168.0.55] (mail.idc-global.com [66.92.217.130])
	by alpha.zimage.com (Postfix) with ESMTP id 9978C1C2AA8
	for <linux-ide@vger.kernel.org>; Tue, 19 Jun 2007 16:16:21 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi all,
	I found issue similar to the one I am having in the archive on this
list.  I never found a resolution to the problem in the archive.
	I have a 4-port Sil 3124 64-bit PCI-X card in a Dell PowerEdge 750.  It
is connected to four SATA hard drives in an external drive bay that
provides power and hotswap rails.
	There doesn't seem to be a problem running three drives, but as soon as
I do something with a forth drive all hell breaks loose.  The problem
doesn't seem localized to a slot in the drive bay or a particular drive.
The issue seems to only happen when I try to access a forth drive.
	I have also tried the card in another system (in a 32-bit slot) and I
experience the same problem.

/proc/interrupts
           CPU0       CPU1       
  0:        250          1   IO-APIC-edge      timer
  1:          8          0   IO-APIC-edge      i8042
  6:          2          0   IO-APIC-edge      floppy
  8:          1          0   IO-APIC-edge      rtc
  9:          1          0   IO-APIC-fasteoi   acpi
 12:          4          0   IO-APIC-edge      i8042
 14:       4002          0   IO-APIC-edge      libata
 15:       5192          0   IO-APIC-edge      libata
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb1
 17:          0          0   IO-APIC-fasteoi   uhci_hcd:usb2
 18:          0          0   IO-APIC-fasteoi   ehci_hcd:usb3
 20:          0          0   IO-APIC-fasteoi   libata
 21:          0          0   IO-APIC-fasteoi   __tmp1014268147
 22:       8737          0   IO-APIC-fasteoi   eth0
 23:       1434          0   IO-APIC-fasteoi   eth1
NMI:          0          0 
LOC:      45044      36735 
ERR:          0
MIS:          0


Jun 12 13:10:06 silo2 kernel: ata3: waiting for device to spin up (8
secs)
Jun 12 13:10:15 silo2 kernel: ata3: soft resetting port
Jun 12 13:10:15 silo2 kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Jun 12 13:10:15 silo2 kernel: ata3.00: ata_hpa_resize 1: sectors =
781422768, hpa_sectors = 781422768
Jun 12 13:10:15 silo2 kernel: ata3.00: ata_hpa_resize 1: sectors =
781422768, hpa_sectors = 781422768
Jun 12 13:10:15 silo2 kernel: ata3.00: configured for UDMA/100
Jun 12 13:10:15 silo2 kernel: ata3: EH complete
Jun 12 13:10:15 silo2 kernel: SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)
Jun 12 13:10:15 silo2 kernel: sde: Write Protect is off
Jun 12 13:10:15 silo2 kernel: SCSI device sde: write cache: enabled,
read cache: enabled, doesn't support DPO or FUA
Jun 12 13:10:15 silo2 kernel: ata3.00: exception Emask 0x10 SAct 0x9ff
SErr 0x80000 action 0x2 frozen
Jun 12 13:10:15 silo2 kernel: ata3.00: (irq_stat 0x01100010, PHY RDY
changed)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/08:00:00:1c:00/00:00:00:00:00/40 tag 0 cdb 0x0 data 4096 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/e0:08:08:1c:00/00:00:00:00:00/40 tag 1 cdb 0x0 data 114688 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/c8:10:38:19:00/00:00:00:00:00/40 tag 2 cdb 0x0 data 102400 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/10:18:e8:1c:00/00:00:00:00:00/40 tag 3 cdb 0x0 data 8192 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/20:20:f8:1c:00/00:00:00:00:00/40 tag 4 cdb 0x0 data 16384 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/c8:28:00:1a:00/00:00:00:00:00/40 tag 5 cdb 0x0 data 102400 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/38:30:c8:1a:00/00:00:00:00:00/40 tag 6 cdb 0x0 data 28672 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/00:38:00:1b:00/01:00:00:00:00/40 tag 7 cdb 0x0 data 131072 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/48:40:18:1d:00/00:00:00:00:00/40 tag 8 cdb 0x0 data 36864 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3.00: cmd
61/08:58:30:19:00/00:00:00:00:00/40 tag 11 cdb 0x0 data 4096 out
Jun 12 13:10:15 silo2 kernel:          res
50/00:00:af:90:93/00:00:2e:00:00/e0 Emask 0x10 (ATA bus error)
Jun 12 13:10:15 silo2 kernel: ata3: waiting for device to spin up (8
secs)
Jun 12 13:10:24 silo2 kernel: ata3: soft resetting port
Jun 12 13:10:24 silo2 kernel: ata3: SATA link up 1.5 Gbps (SStatus 113
SControl 300)
Jun 12 13:10:24 silo2 kernel: ata3.00: ata_hpa_resize 1: sectors =
781422768, hpa_sectors = 781422768
Jun 12 13:10:24 silo2 kernel: ata3.00: ata_hpa_resize 1: sectors =
781422768, hpa_sectors = 781422768
Jun 12 13:10:24 silo2 kernel: ata3.00: configured for UDMA/100
Jun 12 13:10:24 silo2 kernel: ata3: EH complete
Jun 12 13:10:24 silo2 kernel: SCSI device sde: 781422768 512-byte hdwr
sectors (400088 MB)


