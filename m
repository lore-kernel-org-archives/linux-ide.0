From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 07:56:21 -0700 (PDT)
Message-ID: <20081016145621.A44DC108042@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34410 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753540AbYJPO4X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 10:56:23 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GEuLAs010597
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 07:56:22 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #20 from bzolnier@gmail.com  2008-10-16 07:56 -------
This is wild guess but does reverting commit
e5318b531b008c79d2a0c0df06a7b8628da38e2f help?

[ it should be possible to just revert patch

 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=e5318b531b008c79d2a0c0df06a7b8628da38e2f

  from 2.6.27 if you are not using git ]


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
