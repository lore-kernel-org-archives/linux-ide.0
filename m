From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Fri, 10 Oct 2008 12:32:13 -0700 (PDT)
Message-ID: <20081010193213.2FDA4108059@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44617 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760977AbYJJTdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 15:33:15 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9AJWfdj030413
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 12:32:43 -0700
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |platform_x86_64@kernel-
                   |                            |bugs.osdl.org




------- Comment #2 from alan@lxorguk.ukuu.org.uk  2008-10-10 12:32 -------
Not idea - trace is a completely gaga mmu mapping failure. I'd say its a bust
box or someone has loaded corrupting modules


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
