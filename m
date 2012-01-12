From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Thu, 12 Jan 2012 00:58:31 GMT
Message-ID: <201201120058.q0C0wVHQ006147@bugzilla.kernel.org>
References: <bug-12874-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bugzilla.kernel.org ([198.145.19.204]:41295 "EHLO
	bugzilla.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab2AMXN0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jan 2012 18:13:26 -0500
Received: from bugzilla.kernel.org (localhost [127.0.0.1])
	by bugzilla.kernel.org (8.14.5/8.14.5) with ESMTP id q0C0wVgV006148
	for <linux-ide@vger.kernel.org>; Thu, 12 Jan 2012 00:58:31 GMT
In-Reply-To: <bug-12874-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=12874


Jonathan Nieder <jrnieder@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jrnieder@gmail.com




--- Comment #39 from Jonathan Nieder <jrnieder@gmail.com>  2012-01-12 00:58:28 ---
Hi Mark,

I am curious just for completeness of the record about how recent kernels
behave here. (I don't expect they'll be any different since there haven't been
any real fixes since v2.6.32-rc1 as far as I can tell.)  In particular, can you
still use the tape streamer without crashing or lockups, and does it still
truncate files when you try to copy them with dd?

Also, can you bisect[1] to find the particular change that introduced the bug?
(That would make it easier to find a fix, for example by backing that change
out.)

Thanks,
Jonathan

[1] http://git-htmldocs.googlecode.com/git/git-bisect-lk2009.html

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
