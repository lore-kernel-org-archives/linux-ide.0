From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9728] Serverworks initialisation fails
Date: Fri, 11 Jan 2008 12:31:02 -0800 (PST)
Message-ID: <20080111203102.8D68410806E@picon.linux-foundation.org>
References: <bug-9728-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51854 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760004AbYAKUbF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 15:31:05 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BKV2Kx030727
	for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 12:31:03 -0800
In-Reply-To: <bug-9728-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9728


bunk@kernel.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|VERIFIED                    |CLOSED




------- Comment #2 from bunk@kernel.org  2008-01-11 12:31 -------
Fix is now as commit 7c48c56e9b5a51263269dd419cc32531db141340 in Linus' tree.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
