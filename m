From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 11:59:09 -0800 (PST)
Message-ID: <20081109195909.49440108058@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757373AbYKIT7m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 14:59:42 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9JxC85021303
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 11:59:13 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #12 from alan@lxorguk.ukuu.org.uk  2008-11-09 11:59 -------
Can you redo that as the root user - only root can access registers > 0x3F
which is what we need to see in this case.

Alan


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
