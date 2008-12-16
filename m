From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Tue, 16 Dec 2008 11:14:01 -0800 (PST)
Message-ID: <20081216191401.9872C11D109@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48320 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303AbYLPTWt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:22:49 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBGJMlBB017654
	for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:22:48 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #13 from manoet.ita@gmail.com  2008-12-16 11:14 -------
First of all, thanks for all the help you're giving me!
I've applied the patch to the kernel 2.6.27.7 but the output of cdplay still be
"cdplay: ioctl cdromplaymsf: Operation not supported".
I wasn't able to find any log of cdplay, but I've attached the output of dmesg
| grep sr0


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
