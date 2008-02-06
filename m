From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9898] libata fails for ALi Corporation M5229 IDE
Date: Wed,  6 Feb 2008 03:28:47 -0800 (PST)
Message-ID: <20080206112848.011FA108069@picon.linux-foundation.org>
References: <bug-9898-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45793 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762015AbYBFL3U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 06:29:20 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16BSmsU022408
	for <linux-ide@vger.kernel.org>; Wed, 6 Feb 2008 03:28:49 -0800
In-Reply-To: <bug-9898-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9898


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |alan@lxorguk.ukuu.org.uk
             Status|NEW                         |ASSIGNED




------- Comment #2 from alan@lxorguk.ukuu.org.uk  2008-02-06 03:28 -------
If you build a kernel for the system using the old IDE layer with 2.6.24 what
do you see  and what does the log look like.

Also if you boot 2.6.24 and leave it in text mode you should get traces for any
ATA failure which will be needed to debug it.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
