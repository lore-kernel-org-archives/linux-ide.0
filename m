From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11540] hda lost irq on boot
Date: Thu, 11 Sep 2008 11:43:06 -0700 (PDT)
Message-ID: <20080911184306.6E9BE108048@picon.linux-foundation.org>
References: <bug-11540-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52465 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752235AbYIKSnI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2008 14:43:08 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BIh6Id020012
	for <linux-ide@vger.kernel.org>; Thu, 11 Sep 2008 11:43:07 -0700
In-Reply-To: <bug-11540-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11540





------- Comment #2 from bzolnier@gmail.com  2008-09-11 11:43 -------
Seems like an IRQ routing problem and not an IDE specific issue.

Please try 2.6.27-rc6 and also post dmesgs from good/bad kernels. 


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
