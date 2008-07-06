From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11006] 2.6.26-rc6: pcmcia stopped working
Date: Sun,  6 Jul 2008 08:54:56 -0700 (PDT)
Message-ID: <20080706155456.C3DCA10805E@picon.linux-foundation.org>
References: <bug-11006-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34062 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756607AbYGFPz2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 11:55:28 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m66FsuIc007660
	for <linux-ide@vger.kernel.org>; Sun, 6 Jul 2008 08:54:57 -0700
In-Reply-To: <bug-11006-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11006


bunk@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bunk@kernel.org
             Status|NEW                         |CLOSED
         Resolution|                            |CODE_FIX




------- Comment #2 from bunk@kernel.org  2008-07-06 08:54 -------
fixed by commit 7cd95f56cb61f5348d062527c9d3653196f6e629


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
