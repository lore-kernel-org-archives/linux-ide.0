From: Shane Hathaway <shane@hathawaymix.org>
Subject: Bug: Resume with Host Protected Area
Date: Tue, 19 Apr 2005 14:03:23 -0600
Message-ID: <4265640B.5060402@hathawaymix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:24058 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S261648AbVDSUIK
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 16:08:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hathawaymix.org (Postfix) with ESMTP id 9D0B412359B
	for <linux-ide@vger.kernel.org>; Tue, 19 Apr 2005 14:07:44 -0600 (MDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Until today, I haven't been able to reliably put my ThinkPad T41 to
sleep.  After resuming, it generated lots of disk errors, and only a
reboot would bring it back to sanity.

Today I finally realized what's going on.  This laptop has a 3.5 GB
protected area at the end of the drive.  Linux disables the protection
on bootup (making the whole drive available), but the laptop apparently
re-enables the protection during the sleep cycle.  So I moved my
partitions out of the protected area and now the laptop finally resumes
correctly.  Yehaw!

The bugfix should be simple: call idedisk_check_hpa() during resume.

I'm not subscribed to this list, so please CC me on replies.

Shane
