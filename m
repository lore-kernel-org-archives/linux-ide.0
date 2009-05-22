From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Fri, 22 May 2009 23:32:30 GMT
Message-ID: <200905222332.n4MNWUFT008860@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:60685 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002AbZEVXc3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 May 2009 19:32:29 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4MNWUxa008861
	for <linux-ide@vger.kernel.org>; Fri, 22 May 2009 23:32:30 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365





--- Comment #1 from Jacob <fun2program8@yahoo.com>  2009-05-22 23:32:30 ---
Created an attachment (id=21498)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21498)
2.6.29.4 .config

It's called .config.bak because it's the .config that applies to this bug. I'm
currently trying to turn off "Serial ATA" support and use plain "ATA" instead
to see if that helps. If it does, I'll post a 'diff -u' at that point in time.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
