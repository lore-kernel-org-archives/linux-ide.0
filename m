From: Johny A <kernel@agotnes.com>
Subject: Re: SATA_SX4: data corruption with simultaneous writes
Date: Thu, 30 Dec 2004 16:34:04 +1000
Message-ID: <41D3A15C.5050809@agotnes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from munin.agotnes.com ([202.173.149.60]:64384 "EHLO
	mail.agotnes.com") by vger.kernel.org with ESMTP id S261552AbUL3Gem
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Dec 2004 01:34:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

Jeff et al,

I found this one on the mailing-list;
http://marc.theaimsgroup.com/?l=linux-ide&m=109749133709795&w=2

and have the same issues as described there, and also in the previous 
mails in this thread.

The difference is, I can reproduce this with the simplest possible setup;

I have an older Asus Mobo with an AMD1.33GHz CPU,
1 Promise SX4 SATA controller (0000:00:0a.0 RAID bus controller: Promise 
Technology, Inc.: Unknown device 6622 (rev 01))
2 Seagate  ST380817AS, Rev: 3.42 (80 GB SATA) disks

Disks each have 1 large partition with ext2 on them.

1. I boot off a Gentoo LiveCD  running 2.6.9
2. I scp over some 180 MB simultaneously to the two disks across the 
network, one shell copying to 1 disk only
3. Unzip the .bz2 and .gz files just copied the files, again 1 shell 
working on each disk (no cross disk stuff going on at all).

Typically, within a few minutes at most of the unzipping starting I get 
CRC errors on the files. No errors in dmesg necessarily. Sometimes I get 
errors unzipping - unmount the drive and run fsck which reports no 
errors - very insidious!

I'd like the card to work - hey, I got one! and am willing to use my 
setup for testing of new driver versions. I'm useful with C, but not a 
kernel hacker, give me pointers to what needs done and I'll get it done, 
no worries...

Let me know if I can help getting this thing fixed!

Thanks,

Johny A
