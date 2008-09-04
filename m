From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11405] 2.6.27-rc3 segfault on cold boot; not on warm boot.
Date: Thu,  4 Sep 2008 14:19:02 -0700 (PDT)
Message-ID: <20080904211902.D690F10805B@picon.linux-foundation.org>
References: <bug-11405-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33599 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753541AbYIDVTE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Sep 2008 17:19:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m84LJ2Ta032692
	for <linux-ide@vger.kernel.org>; Thu, 4 Sep 2008 14:19:04 -0700
In-Reply-To: <bug-11405-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11405


tglx@linutronix.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|platform_i386@kernel-       |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |
          Component|i386                        |IDE
            Product|Platform Specific/Hardware  |IO/Storage




------- Comment #2 from tglx@linutronix.de  2008-09-04 14:19 -------
So the segfaults and XFS oddities only happen with CONFIG_IDE=n ?

I reassign that to the storage folks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
