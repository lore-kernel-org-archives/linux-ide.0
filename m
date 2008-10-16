From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 03:00:20 -0700 (PDT)
Message-ID: <20081016100020.AAC2E108042@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56878 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752656AbYJPKAX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 06:00:23 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GA0K70024838
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 03:00:22 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742





------- Comment #15 from bbpetkov@yahoo.de  2008-10-16 03:00 -------
Hang the developer :)

You could bisect search for the commit which is causing that regression -
this'll be of great help. Here's a good tutorial on that:

http://www.kernel.org/doc/local/git-quick.html

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
