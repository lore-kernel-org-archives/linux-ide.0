From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Fri, 10 Oct 2008 19:01:37 -0700 (PDT)
Message-ID: <20081011020137.AAF30108047@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50542 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754471AbYJKCBj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 22:01:39 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9B21bIR019430
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 19:01:38 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735





------- Comment #4 from bumble.bee@xs4all.nl  2008-10-10 19:01 -------
To clarify, in addition to the CF card this laptop has a "regular" HDD. I had
switched to an all-libata setup for both the HDD and the ninja32, which is when
the kacpid cpu hog shows up.
I've now also built a kernel with the old ata driver for the HDD and only the
ninja32 in libata. That shows the same behavior as the delkin_cb driver (100%
wait state on resume). With that kernel, I've managed to capture this in the
syslog after resume:

ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ala1.00: cmd 30/00:30:90:12:ea/00:00:00:00:00/e0 tag 0 pio 24576 out
res 40/00:00:00:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1: soft resetting link
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1: soft resetting link
ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
ata1.00: revalidation failed (errno=-5)
ata1.00: disabled
ata1.00: EH complete
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 15340176
sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 18719176
Buffer I/O error on device dm-1, logical block 2323832
lost page write due to I/O error on dm-1

It's dm-1 because the filesystem on the card is on an encrypted block device.
After this error the system goes back to 100% idle, and if I try to access the
filesystem I get I/O errors from ls.

To answer your question, I've not had problems with resuming on this machine
before (with only the HDD, using the old IDE driver). I can't really test
resume without the card right now, since it holds the root filesystem, but I
could dd it back to the HDD if that's necessary.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
