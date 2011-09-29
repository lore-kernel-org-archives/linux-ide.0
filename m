From: Jim Paris <jim@jtan.com>
Subject: Re: Possible MD RAID 5 or sata_sil driver issues.
Date: Thu, 29 Sep 2011 16:50:16 -0400
Message-ID: <20110929205016.GA28611@psychosis.jim.sh>
References: <CAPoxMrn17Z63GDiZ4fOskRoBauQwOd12RMBgBtBGgmB=+gU9VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from jim.sh ([75.150.123.25]:59808 "EHLO psychosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757558Ab1I2U6n (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 29 Sep 2011 16:58:43 -0400
Content-Disposition: inline
In-Reply-To: <CAPoxMrn17Z63GDiZ4fOskRoBauQwOd12RMBgBtBGgmB=+gU9VA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Mills <jmills007@gmail.com>
Cc: neilb@suse.de, neilb@cse.unsw.edu.au, jgarzik@pobox.com, linux-ide@vger.kernel.org

Jim Mills wrote:
> Possible MD RAID 5 or sata_sil driver issues.
> 
> Summary:
> I created an XFS filesystem on top of a MD RAID5 across 4 SATA drives
> connected to a single SIL3114 PCI card.
> 
> Problem:  I am seeing errors and corrupted files, as checked by CRC
> and PAR2.  This is a brand new filesystem, on new drives.  The drives
> do not have smart errors, and have even been zeroed out, as well as
> reading all blocks with offline smart checks, badblocks, and even
> ddrescue.  This also shows up in the mismatch_cnt after sending check
> to sync_action.  Sending repair to sync_action, and then later sending
> check doesn't fix it.
> 
> I have seen this issue regardless if it is XFS or even EXT4, so I am
> not assuming it is not related to the filesystem.  Although I did note
> that MD didn't start recovering after being created until a filesystem
> was created.
> 
> I do not see these issues when using the drives without RAID.
> 
> This leaves me with the only common pieces is the card and the md
> software, which is why I am writing both of you.  It might be
> something weird with the interaction of the two.
> 
> I have tried looking at the sata_sil code, and don't see an easy way
> to enable debugging via insmod.  I have not tried turning on any debug
> in md, and can't unload it as my root, etc. is on a md mirror.
> 
> Linux Kernel: SUSE 3.0.4-2-desktop.
> SiI 3114 IDE BIOS	4/22/2008	5.5.0.0
> 
> Please let me know what additional details would be helpful, and if I
> should point this at a particular email distribution.

Just some random input from a bystander:

The md raid5 code and sata_sil drivers can usually be considered
really solid, they're very commonly used and well-tested.

I had similar issues once, with file corruption sometimes showing up
on a MD raid5.  The disks always tested out fine individually (writing
pseudorandom data and reading it back), and they were still fine with
a raid1 across all disks, so I thought it might be raid5 related.  It
turns out that it was actually bad RAM on one of the HDDs, and the
glitch was triggered only by certain access patterns that showed up
while writing to the raid5 array.

It's probably worth looking into hardware issues.  Maybe your power
supply isn't good enough and these particular access patterns trigger
a problem.  Or system RAM could be bad, or maybe your motherboard has
problems with heavy traffic on the PCI bus, etc.

It could help to figure out exactly what the corruption is, by writing
known data to the entire raid5 array and seeing where it differs when
you read it back.

-jim
