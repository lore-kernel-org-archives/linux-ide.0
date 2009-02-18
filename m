From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12734] ide-iops.c insists on doing 80-wire check
Date: Tue, 17 Feb 2009 16:25:26 -0800 (PST)
Message-ID: <20090218002526.6FE60108041@picon.linux-foundation.org>
References: <bug-12734-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38138 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751422AbZBRAZ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Feb 2009 19:25:58 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n1I0PQ5q032680
	for <linux-ide@vger.kernel.org>; Tue, 17 Feb 2009 16:25:27 -0800
In-Reply-To: <bug-12734-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12734


akpm@osdl.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|drivers_other@kernel-       |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |
          Component|Other                       |IDE
            Product|Drivers                     |IO/Storage




------- Comment #3 from akpm@osdl.org  2009-02-17 16:25 -------
Reassigned to IDE.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
