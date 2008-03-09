From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9994] atiixp ide timeouts
Date: Sun,  9 Mar 2008 12:38:19 -0700 (PDT)
Message-ID: <20080309193819.8FE5B108064@picon.linux-foundation.org>
References: <bug-9994-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47657 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754072AbYCITiV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 15:38:21 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m29JcsM5013244
	for <linux-ide@vger.kernel.org>; Sun, 9 Mar 2008 12:38:55 -0700
In-Reply-To: <bug-9994-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9994





------- Comment #2 from jan.fikar@psi.ch  2008-03-09 12:38 -------
I have tried the bisection and I got something, which does not seem right to
me, but maybe it is.

The problem is that the bug does not show up immediately, but after a couple of
hours. So I tried to wait for the bug at least 6 hours before I did "git bisect
good", and due to this the whole bisection was long, but maybe it was not
enough... 

I will try once again and I will wait longer. Anyway the result is here:

2421ba5b57ddbc3a972b9d6fb884817c39d2fff7 is first bad commit
commit 2421ba5b57ddbc3a972b9d6fb884817c39d2fff7
Author: Kyle McMartin <kyle@mako.i.cabal.ca>
Date:   Wed Nov 28 02:17:53 2007 -0500

    [PARISC] timer interrupt should not be IRQ_DISABLED

    The timer interrupt had accidentally been marked IRQ_DISABLED since
    IRQ_PER_CPU had been OR-ed in, instead of set. This had been working
    by accident for quite a while.

    Commit c642b8391cf8efc3622cc97329a0f46e7cbb70b8 changed the behaviour of
    IRQ_PER_CPU interrupts, which previously weren't checked for IRQ_DISABLED.

    Signed-off-by: Kyle McMartin <kyle@mcmartin.ca>

:040000 040000 e77168c15d33749d5072ee1f6db59d05c128c5c6
426eb6ed185908219e7469fcfedf53d405b720d6 M      arch


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
