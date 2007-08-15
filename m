From: thahn01@t-online.de (Thomas Hahn)
Subject: Accessing CDROM drive in laptop SATA/PATA hardware config
Date: Wed, 15 Aug 2007 14:15:30 +0200
Message-ID: <20070815121530.GA11191@athlona>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout06.sul.t-online.de ([194.25.134.19]:47944 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763358AbXHONBE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 09:01:04 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello,
I have tried to get some help from linux.debian.laptop but so far
no replies. Sorry if I address the wrong people ...

I have a Toshiba M40X-112 laptop.
---snip---
Linux satellita 2.6.22-1-686-bigmem #1 SMP Sun Jul 29 15:54:01 UTC 2007 i686 GNU/Linux
---snap---

So far I am quite happy with it, but the DVD-writer does not work.
I am getting loads of:

---snip---
Aug  6 13:39:01 satellita kernel: sr0: CDROM not ready.  Make sure there
is a disc in the drive.
Aug  6 13:39:32 satellita last message repeated 31 times
---snap---
Message comes every second.

I have googled around and this problem comes up quite a few times.
Most remedies deal with older kernels and so far I cannot figure
out a way to make it work.

When I look at kernel messages, there is:
---snip---
Aug  6 13:39:01 satellita kernel: sr0: CDROM not ready.  Make sure there
is a disc in the drive.
Aug 12 17:02:36 satellita kernel: ahci: probe of 0000:00:1f.2 failed
with error -22
Aug 12 17:02:36 satellita kernel: ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE
IDE ]
Aug 12 17:02:36 satellita kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] ->
GSI 19 (level, low) -> IRQ 19
Aug 12 17:02:36 satellita kernel: scsi0 : ata_piix
Aug 12 17:02:36 satellita kernel: scsi1 : ata_piix
Aug 12 17:02:36 satellita kernel: ata1: SATA max UDMA/133 cmd 0x000101f0
ctl 0x000103f6 bmdma 0x000118b0 irq 14
Aug 12 17:02:36 satellita kernel: ata2: PATA max UDMA/100 cmd 0x00010170
ctl 0x00010376 bmdma 0x000118b8 irq 15
---snap---

So for me it looks like the ahci module is giving up and ata_piix is
taking over.
lsmod prints out:
---snip---
Aug  6 13:39:01 satellita kernel: sr0: CDROM not ready.  Make sure there
is a disc in the drive.
sr_mod                 17284  1 
cdrom                  33568  1 sr_mod
sd_mod                 27904  6 
ata_piix               14148  6 
ahci                   22020  0 
ata_generic             8324  0 
libata                116624  3 ata_piix,ahci,ata_generic
scsi_mod              137388  5 firewire_sbp2,sg,sr_mod,sd_mod,libata
---snap---

lspci shows:
---snip---
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03)
---snap---

kernel command line is:
---snip---
Aug 12 17:02:36 satellita kernel: Kernel command line: root=/dev/sda5 ro libata.atapi_enabled=1
---snap---

So I have tried this libata.atapi_enabled=1 option, but this doesnt
help.
Later I have read some more and added /etc/modprobe.d/libata:
---snip---
# Thomas Hahn, 14.08.2007
options libata atapi_enabled=1
---snap---

So, here you see I am really not sure what is going on ...
I would like to access the CDR and use the faster ahci driver.

Any advice?
Thanks Thomas
-- 
Thomas Hahn == thahn01@t-online.de
