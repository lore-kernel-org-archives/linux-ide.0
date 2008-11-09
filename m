From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 08:07:47 -0800 (PST)
Message-ID: <20081109160747.2FFE0108047@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44504 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755194AbYKIQIR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:08:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9G7lQA007235
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 08:07:48 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bcollins@ubuntu.com




------- Comment #8 from bzolnier@gmail.com  2008-11-09 08:07 -------
It could be that AEC6260[R] controllers may need the same quirks (i.e.
explicitly enabling IRQ line output) as AEC6280[R] ones on Macintosh (draft
patch for 2.6.28-rc3 attached to the next comment).

When it comes to questions related to upating kernel in Ubuntu I think that it
would be the best to try to get some help from Ubuntu Kernel Team  (added Ben
to cc:) as I can't help much here.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
