From: James Ray <j.ray@qmul.ac.uk>
Subject: Bug? ahci.c
Date: Fri, 19 Jan 2007 12:21:26 +0000
Message-ID: <45B0B7C6.3030206@qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.qmul.ac.uk ([138.37.6.6]:55313 "EHLO mail2.qmul.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965133AbXASNbh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 19 Jan 2007 08:31:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Jeff, All,
	We have just started using some new machines with The Intel ESB2
chipset in them (PCI Id: 8086:2681) for the SATA Controller.
With any kernels above 2.6.15 (as far as I can tell from my testing at
least) we are getting problems with them.

This is the output I have managed to collect from the server (Its hard
to get much more since the system gets more and more unresponsive as
these errors progress):
<3>ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x80002 action 0x2 frozen
<3>ata2.00: (irq_stat 0x08000000, interface fatal error)
<3>ata2.00: tag 0 cmd 0x35 Emask 0x10 stat 0x50 err 0x0 (ATA bus error)
<6>ata2: soft resetting port
<3>ata2: softreset failed (1st FIS failed)
<4>ata2: softreset failed, retrying in 5 secs
<6>ata2: hard resetting port
<4>ata2: port is slow to respond, please be patient

I have found some other people with similar problems and this is their
output:
ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata2.00: tag 0 cmd 0xb0 Emask 0x4 stat 0x40 err 0x0 (timeout)
ata2: soft resetting port
ata2: softreset failed (port busy but CLO unavailable)
ata2: softreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: port is slow to respond, please be patient (Status 0x80)
ata2: port failed to respond (30 secs, Status 0x80)
ata2: COMRESET failed (device not ready)
ata2: hardreset failed, retrying in 5 secs
ata2: hard resetting port
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata2: EH complete
SCSI device sdb: 781422768 512-byte hdwr sectors (400088 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back

This second bunch of output matches mine pretty much word for word
(except different size disks) as far as I can tell!

I am trying to get a detailed output from the machine from the console
server and will follow up with this and forward on my exact logs if I
can get some.

Interestingly I only get this behaviour when I am doing software RAID on
the machine (not via the hardware but rather the Linux MD support). I
don't know if this is useful information, I don't see the problem when
running non-mirrored disks or when just doing anything like the following:
dd if=/dev/urandom of=/dev/sd[a|b] bs=1024k.
Even to both disks at the same time.

Can you throw any light on this at all? Suggest any work around?

I'm happy to try and provide any other information I can.

-- 
James Ray.                          <j.ray@qmul.ac.uk>
Computing Services
Queen Mary, University of London
