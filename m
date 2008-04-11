From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Fri, 11 Apr 2008 03:34:47 -0700 (PDT)
Message-ID: <20080411103447.2234A11D107@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32936 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758939AbYDKKnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 06:43:09 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3BAgcSS017727
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 03:42:39 -0700
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #7 from bzolnier@gmail.com  2008-04-11 03:34 -------
You can do this by appending " drivers/ide/pci/atiixp.c" at the end of
git-bisect command but I worry that it may be fruitless since there was very
little atiixp changes.

Hmmm, it is also possible that these timeouts are caused by IRQ routing
problems and not by IDE changes:

> APIC error on CPU0: 00(40)

Does this error always show up just before IDE timeout?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
