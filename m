From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10216] kernel from different versions hangs with some CD/DVD drives
Date: Sun,  9 Nov 2008 07:53:26 -0800 (PST)
Message-ID: <20081109155326.83CFE108042@picon.linux-foundation.org>
References: <bug-10216-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49852 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755268AbYKIPx7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 10:53:59 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9FrQOZ006346
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 07:53:27 -0800
In-Reply-To: <bug-10216-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10216





------- Comment #5 from bzolnier@gmail.com  2008-11-09 07:53 -------
This actually seems to be a controller specific issue (quite surprising at
that).
Could you try the fix proposed for bug #11659 (as after the fact it seems to be
same issue):

http://bugzilla.kernel.org/attachment.cgi?id=18748&action=view


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
