From: Jonas Lundgren <jonas@local.se>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 23:24:42 +0100
Message-ID: <456CB72A.3010004@local.se>
Reply-To: jonas@local.se
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxfep02.bredband.com ([195.54.107.73]:36756 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1757763AbWK1W0F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Nov 2006 17:26:05 -0500
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061128222603.QLJB23770.mxfep02.bredband.com@ironport2.bredband.com>
          for <linux-ide@vger.kernel.org>; Tue, 28 Nov 2006 23:26:03 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-ide@vger.kernel.org

I've been monitoring the linux-ide list to try and find a solution to my
problem with my intel box (i965) and SATA disks.. I sent a mail to the
maintainer of the ata_piix driver and cc'd the linux-ide ML, but go no
responses. I'm not used to mail to ML's, so please excuse me if I did
something wrong with the reply of this mail/CC'ing the wrong persons etc. :)



Here's what I wrote in my last mail to linux-ide:

I've got some big performance related problem with my Abit AB9 pro mobo,
the ICH8 controller and my SATA disks.. I've got 2 64GB WD raptor disks
in a raid0(These are the disks I have used dd/hdparm on in the commands
below), and a 2x250GB WD disk raid0, and I used to get around
130-140mb/sec seq write with them, but now with my new mobo I'm lucky if
I get 10mb/sec. During heavy disk activity the system locks up, until
the write is completed (Ie, no other read or write is being made, it's
like heavy IO completely starves all other processes until it's finished)..

Running 2.6.19-rc5-mm2 atm, but I've tried a few diffrent kernels, same
thing.

Also, it doesn't matter if I enable AHCI in the BIOS (But with AHCI
enabled the disks spin down/power down when I boot, just to power up
again a few seconds after. The boot progress freezes until the disks
have spun up again. (This happens when the kernel probes the sata
controller ports at bootup, the disks spin down at the same time, but
spin up one by one as they're getting probed))

I've tried changing I/O scheduler, only noticable diffrence is when I
use "noop". Then I get like 20mb/sec write instead of 4mb/sec. I have no
idea why this is :P

Example of what I mean with crappy performance:
dd if=/dev/zero of=test232 bs=1M count=100; time sync
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 0.130424 s, 804 MB/s
real 0m21.104s
user 0m0.000s
sys 0m0.011s

21 seconds to do a seq write of 100mb.. And during this time ALL other
disk IO gets starved, I can't do anything that uses disk IO for the
duration.. (not even `ls`)

Yet, a hdparm shows a decent read
hdparm -tT /dev/md4
/dev/md4:
Timing cached reads: 8060 MB in 1.99 seconds = 4042.19 MB/sec
Timing buffered disk reads: 400 MB in 3.00 seconds = 133.28 MB/sec

dd if=1GBzeroFile of=/dev/null bs=1M count=1000
1000+0 records in
1000+0 records out
1048576000 bytes (1.0 GB) copied, 11.4335 s, 91.7 MB/s

This is the cpu usage stats I get from top when running the dd write:
Cpu0 : 0.0%us, 0.0%sy, 0.0%ni, 0.0%id, 99.0%wa, 0.5%hi, 0.5%si, 0.0%st
Cpu1 : 0.0%us, 0.0%sy, 0.0%ni,100.0%id, 0.0%wa, 0.0%hi, 0.0%si, 0.0%st

Pretty crappy read speeds compared to what I got on my previous mobo
(around 140mb/sec), but still alot better than the 4mb/sec I get when
writing..

I've also googled this for many hours, I've searched the lkml, checked
the gentoo forums, as well as other distro forums, I just don't know
what else to do. I'll appreciate any help or hints I can get.




Dmesg output from the error(s): (sda and sdb are 2 * 74GB raptor SATA
drives in a Linux software raid0)

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x20)
ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: soft resetting port
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x21)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.00: (BMDMA stat 0x21)
ata1.00: tag 0 cmd 0xc8 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata1: port is slow to respond, please be patient
ata1: port failed to respond (30 secs)
ata1: soft resetting port
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ATA: abnormal status 0xD0 on port 0xFA07
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x2)
ata1.00: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.00: configured for UDMA/100
ata1: EH complete
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back


Most of the time when I get these errors the system will recover after
anything from 10 seconds to 10 minutes of unresponsiveness (no disk
I/O), and sometimes hang. IF the system does recover, I start getting
the extremly low disk write speeds that I reported above, and only a
reboot will get the performance back to regular.

I don't know what causes it, but most of the times when I've gotten it
my system has been under heavy load (compiling, downloading torrents in
11mb/sec etc). Please let me know if you want any additional info, want
me to try something out, or whatever. My recent hardware upgrade for
around $1200 (to a core2duo system, i965 mobo) is just going to waste
because of this problem. :/

I just got so glad when I saw the post of this on linux-ide, I've been
searching like crazy to find another person having the same problem (and
possibly a solution) for the past 2-3 weeks or so.

-- 
-Jonas

Name:   Jonas Lundgren
ICQ#:   52064961
IRC:    neon / neonman @ EFnet, Undernet, Quakenet, freenode
