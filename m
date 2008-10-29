From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11735] delkin_cb fails after resume
Date: Wed, 29 Oct 2008 11:19:13 -0700 (PDT)
Message-ID: <20081029181913.76F12108041@picon.linux-foundation.org>
References: <bug-11735-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52822 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751771AbYJ2STn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Oct 2008 14:19:43 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9TIJDJA017989
	for <linux-ide@vger.kernel.org>; Wed, 29 Oct 2008 11:19:14 -0700
In-Reply-To: <bug-11735-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11735


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #10 from bzolnier@gmail.com  2008-10-29 11:19 -------
I'm closing this bug since fixes are Linus' tree now:

commit 8c061a40c293660793dab83b75223e6eaaa04f8b (delkin_cb)

commit e7c0d217cdaa837d30bc265eddac4d176969fd68 (pata_ninja32)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
