From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10749] IDE sis5513: the system doesn't shutdown
Date: Sun, 25 May 2008 13:33:38 -0700 (PDT)
Message-ID: <20080525203338.BB41710805D@picon.linux-foundation.org>
References: <bug-10749-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40189 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400AbYEYUeJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 May 2008 16:34:09 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PKXcNc013999
	for <linux-ide@vger.kernel.org>; Sun, 25 May 2008 13:33:39 -0700
In-Reply-To: <bug-10749-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10749


bunk@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |acpi_power-off@kernel-
                   |                            |bugs.osdl.org
OtherBugsDependingO|7216                        |
              nThis|                            |
         AssignedTo|acpi_power-off@kernel-      |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |
          Component|Power-Off                   |IDE
            Product|ACPI                        |IO/Storage
            Summary|the system doesn't shutdown |IDE sis5513: the system
                   |                            |doesn't shutdown




------- Comment #5 from bunk@kernel.org  2008-05-25 13:33 -------
Bart, can you look at this 2.6.26-rc regression?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
