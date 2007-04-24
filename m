From: "Steven J. Ackerman" <steve@acscontrol.com>
Subject: Problem with Linux SATA driver and Acard ARC-770 Bridge chip
Date: Tue, 24 Apr 2007 17:18:10 -0400
Message-ID: <00cc01c786b6$0ff98890$6e01a8c0@sjaquad>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gwa3.webcontrolcenter.com ([63.134.207.12]:3517 "EHLO
	gwa3.webcontrolcenter.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423141AbXDXVeP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 17:34:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello-

We manufacture a line of Compact Flash to IDE adaptors including a 
SATA to CF adaptor. Please visit www.acscontrol.com for information
about these products.

The PATA adaptors work correctly in BIOS/DOS/Windows and Linux.

The SATA adaptor works correctly in BIOS/DOS/Windows but not Linux.

While we're not a Linux shop, we have verified that our SATA adaptor
based upon an Acard Technology ARC-770 SATA to IDE Bridge chip doesn't
work in RIP Linux v2.6.20 on an Intel 865 chipset motherboard. A frustrated
Linux customer pointed us to this distro which we boot off of a Live CD. 

Here are the Linux Kernel error messages that are produced by this
kernel running on our Intel D865GLC motherboard trying to
talk to our ARC-770 based adaptor on SATA-0 :

ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
scsi2 : ata_piix
ata1.00: CFA, max PIO4, 8005536 sectors: LBA
ata1.00: ata1: dev 0 multi count 0
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: limiting speed to PIO3
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: limiting speed to PIO0
ata1: failed to recover some devices, retrying in 5 secs
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: disabled
scsi3 : ata_piix
ATA: abnormal status 0x7F on port 0xE407

You can see that that our ARC-770 based adaptor with 4GB Sandisk CF
card failed to respond to the ATA Identify command. This same CF card 
placed into our PATA adaptor or a no-name adaptor that uses a Marvell 
88SA8040 bridge chip works with no problems. A Sandisk 256M CF card
produces identical results.

Here is the customer's error attempting the same thing but
on an Intel 875 based chipset:

ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0xC007
scsi1 : ata_piix
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ATA: abnormal status 0xD0 on port 0xC807
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: port is slow to respond, please be patient (Status 0xd0)
ata2: port failed to respond (30 secs, Status 0xd0)

We asked Acard Technology to investigate this issue with their
ARC-770 chip and Linux. It also affects their AEC7900 PATA IDE to CF 
adaptor that uses their same ARC-770 chip. Here's their response:

"Intel chipset assigns an "nIEN (interrupt)" value 1 (disable), which is 
not compliant with SATA spec, and causes device failure.  Marvell chip 
has been revised for several versions, and it does something to ignore 
this assignment since a certain revision, prior to the directives of 
SATA authority.  That's why Marvel chip works regardless of MB chipset.  
However, In ACARD, we follow the directives and spec from SATA authority, 
unless we receive the notification, we won't do anything against the rules."

We have asked for more information, but Acard has not been responsive. They 
don't see it as their problem since their chip works per the SATA
specification
and works in the BIOS/DOS and Windows. Amusing since they also claims that
it
works in Linux, but we have proven to them that it doesn't. We would like to

solve this issue for our Linux customers.

I contacted Greg Kroah-Hartman about his posting of Free Linux Device Driver
development seeking a working driver for our adaptor. He responded that the
driver already exists, and that I should post to this list asking for
assistance
in making the existing driver work. So here it is.

I can provide our SATA to CF adaptor and a CF card to a developer who can
facilitate fixing this bug and incorporate the corrections into the Linux
kernel for subsequent releases.

Thank you,

Steven J. Ackerman
ACS, Sarasota, FL
(941)377-5775
steve@acscontrol.com




