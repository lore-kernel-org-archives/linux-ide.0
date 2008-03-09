From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Sun,  9 Mar 2008 12:50:55 -0700 (PDT)
Message-ID: <20080309195055.42078108067@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45930 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753397AbYCITu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 15:50:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m29JpTWK014392
	for <linux-ide@vger.kernel.org>; Sun, 9 Mar 2008 12:51:31 -0700
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #3 from bzolnier@gmail.com  2008-03-09 12:50 -------
Unfortunately this commit is not the one we are looking for as it only affects
PARISC architecture :/

PS I assume that 2.6.25-rc4 still has this problem?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
