From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10142] DMA crash with via82cxxx module
Date: Sun,  2 Mar 2008 08:15:57 -0800 (PST)
Message-ID: <20080302161557.965B8108065@picon.linux-foundation.org>
References: <bug-10142-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57333 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751480AbYCBQP7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Mar 2008 11:15:59 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m22GG1Bv027843
	for <linux-ide@vger.kernel.org>; Sun, 2 Mar 2008 08:16:02 -0800
In-Reply-To: <bug-10142-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10142





------- Comment #7 from bzolnier@gmail.com  2008-03-02 08:15 -------
Thanks.

Please try 2.6.25-rc3, there were massive IDE changes in 2.6.24 and 2.6.25 so
the issue it might got fixed already.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
