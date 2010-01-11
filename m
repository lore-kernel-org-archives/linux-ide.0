From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14438] IDE Probe fails to find CD drive
Date: Mon, 11 Jan 2010 13:49:31 GMT
Message-ID: <201001111349.o0BDnVtX007835@demeter.kernel.org>
References: <bug-14438-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35518 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab0AKNtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jan 2010 08:49:31 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id o0BDnV96007836
	for <linux-ide@vger.kernel.org>; Mon, 11 Jan 2010 13:49:31 GMT
In-Reply-To: <bug-14438-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14438


andrea <andrea.gilbert@clearswift.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |andrea.gilbert@clearswift.c
                   |                            |om




--- Comment #7 from andrea <andrea.gilbert@clearswift.com>  2010-01-11 13:49:29 ---
I had a problem which sounds very similar last week.

I started a forum thread here (before I discovered this DB):
http://www.linuxquestions.org/questions/linux-virtualization-90/2.6.31-kernel-guest-os-on-vmware-esx-3.5.0-780042/ 

The solution (for us) was to regress out this kernel change:
http://kerneltrap.org/mailarchive/git-commits-head/2009/6/12/5948973

A more resilient fix might be to leave ide_probe_port() as-is but to fix 
ide_wait_not_busy() to return the last successful rc code (only returning
-ENODEV if strictly no device is detected on the IDE port). I do not know what
other repercussions such a fix might have however.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
