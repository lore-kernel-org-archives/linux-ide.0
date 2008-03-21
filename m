From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Fri, 21 Mar 2008 04:33:20 -0700 (PDT)
Message-ID: <20080321113320.DE21A11D10A@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37092 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754027AbYCULdw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 07:33:52 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LBXKGd016680
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2008 04:33:22 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #8 from bzolnier@gmail.com  2008-03-21 04:33 -------
Update: actually the old code also did check ERR bit so it is something else...

If you add "#define DEBUG" to ide-taskfile.c and re-build/re-test we will know
which command is the failing one (please be warned that the output will become
quite verbose).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
