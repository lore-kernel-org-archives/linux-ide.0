From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 7553] growisofs trapped in "disk sleep" mode, after finishing writing a DVD
Date: Sat, 16 Feb 2008 10:43:40 -0800 (PST)
Message-ID: <20080216184340.84C5310806C@picon.linux-foundation.org>
References: <bug-7553-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43894 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755411AbYBPSok (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 13:44:40 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GIi9P8007872
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 10:44:10 -0800
In-Reply-To: <bug-7553-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=7553


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|bzolnier@gmail.com          |io_ide@kernel-bugs.osdl.org




------- Comment #8 from bzolnier@gmail.com  2008-02-16 10:43 -------
Is this still a problem with recent kernels (2.6.24 or 2.6.25-rc2)?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
