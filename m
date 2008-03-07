From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Fri,  7 Mar 2008 12:09:39 -0800 (PST)
Message-ID: <20080307200939.38BE811D109@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48616 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764612AbYCGUJl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Mar 2008 15:09:41 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m27KA50g006371
	for <linux-ide@vger.kernel.org>; Fri, 7 Mar 2008 12:10:06 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #11 from bzolnier@gmail.com  2008-03-07 12:09 -------
| And about "drive not ready for command" error. This is related to Benq DVD
| drive, and is discribed here:
| https://bugs.launchpad.net/ubuntu/+source/linux/+bug/182996. I've
disconnected
| Benq drive and system did boot.

Thanks but I was asking specifically for narrowing down this problem (since it
looks like regression) - this would greatly help us in fixing it.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
