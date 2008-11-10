From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Mon, 10 Nov 2008 15:40:02 -0800 (PST)
Message-ID: <20081110234002.E00FF108042@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53077 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752001AbYKJXke (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Nov 2008 18:40:34 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAANe3K3006060
	for <linux-ide@vger.kernel.org>; Mon, 10 Nov 2008 15:40:04 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #7 from bzolnier@gmail.com  2008-11-10 15:40 -------
Hmm, the safest bet would be to define IDE_HFLAG_BROKEN_ALTSTATUS flag to some
flag that is set unconditionally in amd74xx host driver -- i.e. adding:

        IDE_HFLAG_BROKEN_ALTSTATUS = IDE_HFLAG_PIO_NO_BLACKLIST,

at the end of enum { } clause.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
