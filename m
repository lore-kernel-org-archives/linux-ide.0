From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Fri,  7 Mar 2008 11:49:50 -0800 (PST)
Message-ID: <20080307194950.796EC11D108@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40648 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757070AbYCGTuW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 14:50:22 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27JoGxs004417
	for <linux-ide@vger.kernel.org>; Fri, 7 Mar 2008 11:50:18 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #10 from qrees@poczta.fm  2008-03-07 11:49 -------
Ok, I've tested kernel version 2.6.24.8 and it didn't creash, but it's doesn't
mean that it won't crash later. I'll test it for a week or so and see if it
works fine. The problem with testing is that system may crash after few minutes
or after few weeks. Even if finding kernel with git bisect might take only few
iterations, one iteration may take very long time... I haven't found any
software that always makes system crash...

And about "drive not ready for command" error. This is related to Benq DVD
drive, and is discribed here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/182996. I've disconnected
Benq drive and system did boot.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
