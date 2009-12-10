From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 10 Dec 2009 14:38:19 GMT
Message-ID: <200912101438.nBAEcJT5029802@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35375 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbZLJOiM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2009 09:38:12 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBAEcJQn029803
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2009 14:38:19 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #29 from Robert Hancock <hancockrwd@gmail.com>  2009-12-10 14:38:15 ---
A userspace bug shouldn't be able to affect disk operations at that level.
Unless it is just some kind of timing difference that's triggering the error.

Assuming that pattern is indeed consistent, presumably those reports are mainly
with Ubuntu-patched kernels.. are there any Ubuntu kernel patches in Karmic
that wouldn't have been in Jaunty that could explain this?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
