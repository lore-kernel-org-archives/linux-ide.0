From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10239] PLEXTOR DVDR PX-740A drive not ready for command
Date: Sun, 16 Mar 2008 08:02:27 -0700 (PDT)
Message-ID: <20080316150227.85649108066@picon.linux-foundation.org>
References: <bug-10239-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53246 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751880AbYCPPC3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Mar 2008 11:02:29 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GF3VYZ019237
	for <linux-ide@vger.kernel.org>; Sun, 16 Mar 2008 08:03:32 -0700
In-Reply-To: <bug-10239-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10239





------- Comment #8 from bzolnier@gmail.com  2008-03-16 08:02 -------
Also booting with "hdb=noprobe" should workaround the problem (please try it).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
