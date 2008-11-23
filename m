From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun, 23 Nov 2008 14:44:53 -0800 (PST)
Message-ID: <20081123224453.10C7E108047@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49307 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750780AbYKWWpu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 17:45:50 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mANMjLxr021803
	for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 14:45:22 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216


sshtylyov@ru.mvista.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sshtylyov@ru.mvista.com




------- Comment #20 from sshtylyov@ru.mvista.com  2008-11-23 14:44 -------
Note the "Clocksource tsc unstable" message from the patche kernel, presuably
while probing ide0.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
