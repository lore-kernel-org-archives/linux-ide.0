From: Johny A <kernel@agotnes.com>
Subject: Re: SATA_SX4: data corruption with simultaneous writes
Date: Sun, 09 Jan 2005 11:35:07 +1000
Message-ID: <41E08A4B.5090400@agotnes.com>
References: <41D3A15C.5050809@agotnes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from munin.agotnes.com ([202.173.149.60]:2955 "EHLO mail.agotnes.com")
	by vger.kernel.org with ESMTP id S262182AbVAIBfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2005 20:35:34 -0500
In-Reply-To: <41D3A15C.5050809@agotnes.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk

Guys,

Sorry to be a pain, wee bump for this note. In particular, if there is 
no time to fix this issue now could a wee note be added to the driver 
(in the docs, or possibly in the kernel log) stating that it is 
potentially dangerous to use this card with the current crop of kernels?

I'm still happy to help with testing and debugging, but as stated 
before, a couple of hints and pointers would be required :)

Thanks for listening!

:)Johny

Johny A wrote:
> Jeff et al,
> 
> I found this one on the mailing-list;
> http://marc.theaimsgroup.com/?l=linux-ide&m=109749133709795&w=2
> 
> and have the same issues as described there, and also in the previous 
> mails in this thread.
> 
> The difference is, I can reproduce this with the simplest possible setup;
> 
> I have an older Asus Mobo with an AMD1.33GHz CPU,
> 1 Promise SX4 SATA controller (0000:00:0a.0 RAID bus controller: Promise 
> Technology, Inc.: Unknown device 6622 (rev 01))
> 2 Seagate  ST380817AS, Rev: 3.42 (80 GB SATA) disks
> 
> Disks each have 1 large partition with ext2 on them.
> 
> 1. I boot off a Gentoo LiveCD  running 2.6.9
> 2. I scp over some 180 MB simultaneously to the two disks across the 
> network, one shell copying to 1 disk only
> 3. Unzip the .bz2 and .gz files just copied the files, again 1 shell 
> working on each disk (no cross disk stuff going on at all).
> 
> Typically, within a few minutes at most of the unzipping starting I get 
> CRC errors on the files. No errors in dmesg necessarily. Sometimes I get 
> errors unzipping - unmount the drive and run fsck which reports no 
> errors - very insidious!
> 
> I'd like the card to work - hey, I got one! and am willing to use my 
> setup for testing of new driver versions. I'm useful with C, but not a 
> kernel hacker, give me pointers to what needs done and I'll get it done, 
> no worries...
> 
> Let me know if I can help getting this thing fixed!
> 
> Thanks,
> 
> Johny A
> 
