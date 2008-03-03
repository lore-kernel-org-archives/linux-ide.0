From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Mon,  3 Mar 2008 14:33:03 -0800 (PST)
Message-ID: <20080303223303.CDFE3108065@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41676 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752683AbYCCWdb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 17:33:31 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m23MXC2T029245
	for <linux-ide@vger.kernel.org>; Mon, 3 Mar 2008 14:33:14 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #9 from bzolnier@gmail.com  2008-03-03 14:33 -------
This looks more and more like a broken hardware (or a very device specific
problem) as via82cxxx is known to work fine with recent kernels and there were
no other bugreports recently.  Please send dmesg command output for the working
kernel so we can see what devices are involved.

W.R.T. to 2.6.25-rc(3?) problem:

Could you try using git-bisect to narrow down the problem to a specific commit?
Please install git package, get kernel git tree from kernel.org and do:

git bisect start
git bisect good 2.6.23
git bisect bad 2.6.25-rc3

It will select the kernel to test, compile and boot it to see if the problem is
still there.  If so do "git bisect bad" which will give you new kernel to test.
 If the kernel works fine do "git bisect good" instead.  After few iterations
you should find the exact commit which introduced the bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
