From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Sat, 16 Feb 2008 10:21:22 -0800 (PST)
Message-ID: <20080216182122.E19E7108011@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52543 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752033AbYBPSVx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 13:21:53 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GILMbv007074
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 10:21:24 -0800
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #1 from bzolnier@gmail.com  2008-02-16 10:21 -------
Please try using git-bisect to narrow down the problem to the specific commit.
Install git package, get git tree from kernel.org and do:

git bisect start
git bisect good 2.6.23
git bisect bad 2.6.24

It will select the kernel to test - compile and boot it to see if the problem
is still there.  If so do "git bisect bad" which will give you new kernel to
test.  If the kernel works fine do "git bisect good" instead.  After few
iterations you should find the exact commit which introduced the bug.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
