From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Sun, 28 Dec 2008 23:32:42 -0800 (PST)
Message-ID: <20081229073242.BD1A010800C@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36821 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbYL2Hco (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 02:32:44 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBT7WgTd025986
	for <linux-ide@vger.kernel.org>; Sun, 28 Dec 2008 23:32:43 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #3 from nm127@freemail.hu  2008-12-28 23:32 -------
I tested so far the following versions:

2.6.28 bad
2.6.28-rc9 bad
2.6.28-rc3 bad
2.6.28-rc1 good

I started to git bisecting the problem but this might take a while.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
