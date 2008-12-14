From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sun, 14 Dec 2008 11:11:20 -0800 (PST)
Message-ID: <20081214191120.96E10108041@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50084 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750999AbYLNTLX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Dec 2008 14:11:23 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBEJBKUj012163
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2008 11:11:21 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #8 from manoet.ita@gmail.com  2008-12-14 11:11 -------
Well, i've installed the 2.6.27.7 kernel without the nvidia module (i think and
hope it's because of this that it's impossible to start the x server...) but
when i try to play audio cds the output is: "ioctl cdromplaymsf: Operation not
supported"
I noticed some differences between the output of "cat /proc/sys/dev/cdrom/info"
in the old and in the new kernel. In kernel 2.6.27.7 "Drive name" is sr.0 and
"Can play audio" is set to 1. However "Can select disk" is set to 0.
I hope that can help.

PS- i haven't tried the patch. Should I?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
