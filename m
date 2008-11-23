From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun, 23 Nov 2008 15:30:05 -0800 (PST)
Message-ID: <20081123233005.7E92D10804A@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33019 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750837AbYKWXav (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 18:30:51 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mANNUJeQ023148
	for <linux-ide@vger.kernel.org>; Sun, 23 Nov 2008 15:30:20 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #27 from sshtylyov@ru.mvista.com  2008-11-23 15:30 -------
Bart, looks like ide_wait_not_busy() needs to call
clocksource_touch_watchdog().


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
