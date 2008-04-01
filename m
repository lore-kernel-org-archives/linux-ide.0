From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Mon, 31 Mar 2008 23:26:29 -0700 (PDT)
Message-ID: <20080401062629.9F50610803F@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55188 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551AbYDAG0b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Apr 2008 02:26:31 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m316QTad010782
	for <linux-ide@vger.kernel.org>; Mon, 31 Mar 2008 23:26:30 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #16 from gordonfarquharson@gmail.com  2008-03-31 23:26 -------
Sorry for the delay in tackling this issue. The regression I see was introduced
between 2.6.24 and 2.6.25-rc1. I have not been able to narrow it down further
(yet) because the kernels I build using git bisect don't boot on my machine.
I'm currently trying to find a commit before -rc1 that does boot, but I thought
that I'd send an update.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
