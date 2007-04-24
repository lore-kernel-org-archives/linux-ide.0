From: sjackerman@comcast.net
Subject: Problems with Linux SATA driver and ARC-770 IDE Bridge chip
Date: Tue, 24 Apr 2007 15:03:01 -0400
Message-ID: <5760903.1177441381244.JavaMail.root@wombat.diezmil.com>
Reply-To: sjackerman@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wombat.diezmil.com ([209.190.27.106]:45824 "EHLO
	wombat.diezmil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423026AbXDXTSV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Apr 2007 15:18:21 -0400
Received: from wombat.diezmil.com (wombat.diezmil.com [127.0.0.1])
	by wombat.diezmil.com (8.13.8/8.13.8) with ESMTP id l3OJ31Vi019576
	for <linux-ide@vger.kernel.org>; Tue, 24 Apr 2007 15:03:01 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello-

We manufacture a SATA to CF adaptor that uses an Acard Technology ARC-770 SATA to IDE bridge chip:

http://www.acscontrol.com/Index_ACS.asp?Page=/Pages/Products/CompactFlash/SATA_To_CF_Adapter.htm

The adaptor works correctly and can be 'seen' in the BIOS, in DOS, in Windows XP, XP MCE and Vista. However the adaptor doesn't work correctly or can't be 'seen' in Linux. A similiar adaptor based upon a Marvell bridge chip works correctly in Linux.

We have now verified that this doesn't work on an in-house Intel 865 chipset motherboard running RIP Linux v2.6.20. A customer has verified that this also doesn't work on Intel 875 or Via chipset motherboards under Linux.

Here are the Linux Kernel error messages that are produced by this kernel running on a Intel D865GLC motherboard trying to talk to our ARC-770 based adaptor on SATA-0 :

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
card failed to respond to the ATA Identify command. However the BIOS, DOS and Windows can identify and use this same CF card and adaptor. The same CF card
placed into a no-name adaptor that uses a Marvell 88SA8040 bridge chip works
with no problems.

Here is the customer's error attempting the same thing but on an Intel
875 based chipset:

ata1: SATA max UDMA/133 cmd 0xC000 ctl 0xC402 bmdma 0xD000 irq 16
ata2: SATA max UDMA/133 cmd 0xC800 ctl 0xCC02 bmdma 0xD008 irq 16
scsi0 :
ata_piix
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

According to the Acard technology support engineer who evaluated the problem:

"Intel chipset assigns an "nIEN (interrupt)" value 1 (disable), which is not compliant with SATA spec, and causes device failure.  Marvell chip has been revised for several versions, and it does something to ignore this assignment since a certain revision, prior to the directives of SATA authority.  That's why Marvel chip works regardless of MB chipset.  However, In ACARD, we follow the directives and spec from SATA authority, unless we receive the notification, we won't do anything against the rules."

I have asked for additional clarification from Acard, but it has not been forthcoming.

In attempting to resolve this for our Linux customers, I sent an e-mail to Greg K-H in response to his Free Linux Driver Announcement: 

http://www.kroah.com/log/linux/free_drivers.html

Greg responded and suggested that I post a request for assistance on this mailing list, so here it is.

I would be willing to supply one of our adaptors and a CF card to someone who can revise the driver to work with the Acard ARC-770 and have the corrected driver included in future Linux releases.

Thank you,

Steven J. Ackerman
ACS, Sarasota, FL
http://www.acscontrol.com
steve@acscontrol.com
(941)377-5775




--
This message was sent on behalf of sjackerman@comcast.net at openSubscriber.com
http://www.opensubscriber.com/messages/linux-ide@vger.kernel.org/topic.html
