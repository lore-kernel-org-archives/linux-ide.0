From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Thu, 18 Dec 2008 10:07:21 -0800 (PST)
Message-ID: <20081218180721.61C2811D108@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47253 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412AbYLRSHX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Dec 2008 13:07:23 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBII7LQc014055
	for <linux-ide@vger.kernel.org>; Thu, 18 Dec 2008 10:07:22 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #21 from manoet.ita@gmail.com  2008-12-18 10:07 -------
I suppose I had to do just a rmmod ata_piix, but anyway, I did how you said and
I had recompiled my kernel.

#cdplay /dev/hda
[   91.441974] ATAPI device hda:
[   91.445955]     Invalid command operation code -- (asc=0x20, ascq=0x00)
[   91.445955]     the failed "play audio msf" packet command was:
[   91.445955]     "47 00 00 00 02 00 28 35 00 00 00 00 00 00 00 00"
cdplay: ioctl cdromplaymsf: Input/output error


#dmesg | grep hda
[    3.932386] hda: Optiarc BD ROM BC-5500A, ATAPI CD/DVD-ROM drive
[    4.604110] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    4.604230] hda: UDMA/33 mode selected
[    5.189033] hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[   75.576637] hda: packet command error: status=0x51 { DriveReady SeekComplete
Error }
[   75.576656] hda: packet command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[   75.577371] ATAPI device hda:
[   91.441485] hda: packet command error: status=0x51 { DriveReady SeekComplete
Error }
[   91.441503] hda: packet command error: error=0x54 { AbortedCommand
LastFailedSense=0x05 }
[   91.441974] ATAPI device hda:


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
