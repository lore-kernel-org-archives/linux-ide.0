From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Sat, 12 Apr 2008 13:51:05 -0700 (PDT)
Message-ID: <20080412205105.5BE62108038@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38889 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752073AbYDLUvI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 16:51:08 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3CKp5HN026946
	for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 13:51:07 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436


marco@absence.it changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |CLOSED
         Resolution|                            |PATCH_ALREADY_AVAILABLE




------- Comment #9 from marco@absence.it  2008-04-12 13:51 -------
Halt! Finally I got it working! I had to manually insert the new code but then
everything went fine then. Now we can close this bug (hoping to see this this
patch in the upstream kernel).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
