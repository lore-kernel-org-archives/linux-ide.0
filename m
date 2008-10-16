From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11742] Device buffer on a DVD multi standard writer runs out burning a CD
Date: Thu, 16 Oct 2008 10:16:03 -0700 (PDT)
Message-ID: <20081016171603.ADFF1108056@picon.linux-foundation.org>
References: <bug-11742-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53787 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756745AbYJPRQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 13:16:05 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GHG3xG019590
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 10:16:04 -0700
In-Reply-To: <bug-11742-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11742


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bbpetkov@yahoo.de
             Status|NEW                         |ASSIGNED




------- Comment #23 from bbpetkov@yahoo.de  2008-10-16 10:16 -------
Ok, you can do the following if !GIT:

patch -p1 -R --dry-run < [patch]

(in case there are no rejects, remove the --dry-run option)

ontop of 2.6.27. It should revert cleanly, though. Then recompile the kernel,
boot. The [patch] above is following in an attachment.

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
