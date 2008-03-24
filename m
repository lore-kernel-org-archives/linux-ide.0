From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Mon, 24 Mar 2008 08:08:27 -0700 (PDT)
Message-ID: <20080324150827.0D22211D10A@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40031 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759332AbYCXPI7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 11:08:59 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2OF8RLr005487
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 08:08:28 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #15 from bzolnier@gmail.com  2008-03-24 08:08 -------
Error messages should be sufficient to determine the "guilty" commit (or the
commit changing error reporting - which should also give us more insight into
the issue).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
