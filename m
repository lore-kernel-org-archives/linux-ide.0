From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11659] CDROM on Laptop  Fudjitsu-siemens Amilo Xa-2528 isn't reconized
Date: Sat, 27 Sep 2008 10:49:08 -0700 (PDT)
Message-ID: <20080927174908.0DF6B10805B@picon.linux-foundation.org>
References: <bug-11659-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51197 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755836AbYI0Rth (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Sep 2008 13:49:37 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8RHn87S023554
	for <linux-ide@vger.kernel.org>; Sat, 27 Sep 2008 10:49:09 -0700
In-Reply-To: <bug-11659-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11659





------- Comment #2 from sshtylyov@ru.mvista.com  2008-09-27 10:49 -------
(In reply to comment #1)
> Ok, you're the second person to report the same problem: see
> http://bugzilla.kernel.org/show_bug.cgi?id=11581. I'm working on it.

I'm not at all sure it's the same issue: here the ATAPI Identify command fails
due to a lost IRQ.

BTW, the vendor is called Fujitsu-Siemens. :-)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
