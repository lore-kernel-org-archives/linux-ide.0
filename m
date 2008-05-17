From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10723] linux 2.6.24 fails to mount ext3 rootfs on FUJITSU MHK2060AT
Date: Sat, 17 May 2008 09:20:21 -0700 (PDT)
Message-ID: <20080517162021.5ED5B10805F@picon.linux-foundation.org>
References: <bug-10723-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37052 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750894AbYEQQUw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 May 2008 12:20:52 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4HGKLrr012601
	for <linux-ide@vger.kernel.org>; Sat, 17 May 2008 09:20:23 -0700
In-Reply-To: <bug-10723-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10723





------- Comment #6 from bzolnier@gmail.com  2008-05-17 09:20 -------
If it is possible to mount it like ext2 but not ext3 it is quite likely to be
fs related issue and not IDE one (DMA timeouts are an orthogonal thing as they
are also present with 2.6.22 according to the log).

In any case you should be able to narrow down the source of the problem by
using git-bisect.  Please install git package for your distribution, get kernel
git tree from kernel.org and do:

git bisect start
git bisect good 2.6.22
git bisect bad 2.6.24

It will select the kernel to test, compile and boot it to see if the problem is
 there.  If so do "git bisect bad" which will give you new kernel to test.  If
the kernel works fine do "git bisect good" instead.  After few iterations you
should find the exact commit which introduced the bug.  Thanks!


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
