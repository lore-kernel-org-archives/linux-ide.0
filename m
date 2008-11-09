From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Sun,  9 Nov 2008 08:15:13 -0800 (PST)
Message-ID: <20081109161513.AE0F8108042@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58981 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755260AbYKIQPp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:15:45 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9GFDq6007693
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 08:15:14 -0800
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732





------- Comment #9 from bzolnier@gmail.com  2008-11-09 08:15 -------
Could you try 2.6.28-rc3?  We've fixed some bugs related to ide-cd recently so
this problem may get fixed as well.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
