From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11581] CDRW not detected on boot. 2.6.18 worked ok.
Date: Thu, 18 Sep 2008 00:51:53 -0700 (PDT)
Message-ID: <20080918075153.DA2D110805B@picon.linux-foundation.org>
References: <bug-11581-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49604 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751626AbYIRHw2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2008 03:52:28 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8I7pr8h030048
	for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2008 00:51:54 -0700
In-Reply-To: <bug-11581-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11581





------- Comment #5 from sanvila@unex.es  2008-09-18 00:51 -------
2.6.27-rc6 is also broken.

Note: This time I've had to use the .config from the Debian package for 2.6.26,
as the one provided by "make defconfig" didn't detect the hard disk (!).

The behaviour is the same: Waiting time while udev is trying to detect hdc,
timeout of "udevadm settle", eject button does not work, and a simple
"less -f /dev/hdc" makes eject to actually happen.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
