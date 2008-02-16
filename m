From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 8988] via82cxxx: SATA DVD-RW Pioneer DVR-212BK with CX700, system hangs
Date: Sat, 16 Feb 2008 11:53:58 -0800 (PST)
Message-ID: <20080216195358.8D3B6108068@picon.linux-foundation.org>
References: <bug-8988-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60619 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbYBPTyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 14:54:00 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GJrwjk010634
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 11:53:59 -0800
In-Reply-To: <bug-8988-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=8988





------- Comment #6 from bzolnier@gmail.com  2008-02-16 11:53 -------
Could you please try to bisect it?

Install git, get kernel git tree from kernel.org, and do:

git bisect start
git bisect good 2.6.22
git bisect bad 2.6.24

It will select the kernel to test - compile and boot it to see if the problem
is still there.  If so do "git bisect bad" which will give you new kernel to
test.  If the kernel works fine do "git bisect good" instead.  After few
iterations you should find the exact commit which introduced the bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
