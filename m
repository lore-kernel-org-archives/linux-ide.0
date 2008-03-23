From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Sun, 23 Mar 2008 15:11:16 -0700 (PDT)
Message-ID: <20080323221116.E8261108039@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53943 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753386AbYCWWLT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 18:11:19 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2NMBH1A003717
	for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 15:11:18 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #13 from bzolnier@gmail.com  2008-03-23 15:11 -------
Thanks, from looking at the log:

| hda: tf: feat 0xd8 nsect 0x00 lbal 0x01 lbam 0x4f lbah 0xc2 dev 0x00 cmd 0xb0
| hda: hob: nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00
| hda: tf: feat 0x00 nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00 dev 0x00 cmd 0xb0
| hda: hob: nsect 0x00 lbal 0x00 lbam 0x00 lbah 0x00

We got SMART command (cmd 0xb0) with all other registers set to 0x00 and it is
(theoretically) impossible to get it through HDIO_DRIVE_CMD (since
ide_cmd_ioctl() always sets lbam to 0x4f and lbah to 0xc2).  Maybe it was
passed through HDIO_DRIVE_TASK or HDIO_DRIVE_TASKFILE or we have the bug
somewhere (N.B. the behavior of erroing it is correct if the user-space
actually requested such command)...

It seems to be a distinct problem from the one that was hit by Anders and later
fixed by Linus.  Could you try git-bisecting it, please?

| hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
| hda: task_no_data_intr: error=0x04 { DriveStatusError }
| ide: failed opcode was: 0xb0


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
