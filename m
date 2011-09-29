From: Jim Mills <jmills007@gmail.com>
Subject: Possible MD RAID 5 or sata_sil driver issues.
Date: Thu, 29 Sep 2011 11:54:23 -0400
Message-ID: <CAPoxMrn17Z63GDiZ4fOskRoBauQwOd12RMBgBtBGgmB=+gU9VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56588 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab1I2PyY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Sep 2011 11:54:24 -0400
Received: by iaqq3 with SMTP id q3so820806iaq.19
        for <linux-ide@vger.kernel.org>; Thu, 29 Sep 2011 08:54:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: neilb@suse.de, neilb@cse.unsw.edu.au, jgarzik@pobox.com, linux-ide@vger.kernel.org

Possible MD RAID 5 or sata_sil driver issues.

Summary:
I created an XFS filesystem on top of a MD RAID5 across 4 SATA drives
connected to a single SIL3114 PCI card.

Problem:  I am seeing errors and corrupted files, as checked by CRC
and PAR2.  This is a brand new filesystem, on new drives.  The drives
do not have smart errors, and have even been zeroed out, as well as
reading all blocks with offline smart checks, badblocks, and even
ddrescue.  This also shows up in the mismatch_cnt after sending check
to sync_action.  Sending repair to sync_action, and then later sending
check doesn't fix it.

I have seen this issue regardless if it is XFS or even EXT4, so I am
not assuming it is not related to the filesystem.  Although I did note
that MD didn't start recovering after being created until a filesystem
was created.

I do not see these issues when using the drives without RAID.

This leaves me with the only common pieces is the card and the md
software, which is why I am writing both of you.  It might be
something weird with the interaction of the two.

I have tried looking at the sata_sil code, and don't see an easy way
to enable debugging via insmod.  I have not tried turning on any debug
in md, and can't unload it as my root, etc. is on a md mirror.

Linux Kernel: SUSE 3.0.4-2-desktop.
SiI 3114 IDE BIOS	4/22/2008	5.5.0.0

Please let me know what additional details would be helpful, and if I
should point this at a particular email distribution.

--
Jim Mills
