From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Sun, 16 Mar 2008 08:32:01 -0700 (PDT)
Message-ID: <20080316153201.BB76A108066@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38356 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936AbYCPPcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Mar 2008 11:32:33 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GFX5QE020934
	for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 08:33:06 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239


ubuntu@kagou.fr changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |ubuntu@kagou.fr
             Status|NEW                         |ASSIGNED




------- Comment #12 from ubuntu@kagou.fr  2008-03-16 08:32 -------
I have the same bug :
https://bugs.edge.launchpad.net/ubuntu/+source/linux/+bug/181561
and
http://bugzilla.kernel.org/show_bug.cgi?id=9837

I don't think that this is a controller problem. I have 2 different PC (nvidia
and intel controller). And the bug follow is where i put my Plextor PX-740A
(setting as master, and alone on ide).
Setting it as Slave resolve temporarly the problem.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
