From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Tue, 16 Jun 2009 06:28:30 GMT
Message-ID: <200906160628.n5G6SUfW029240@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34819 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbZFPG22 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jun 2009 02:28:28 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5G6SUnk029241
	for <linux-ide@vger.kernel.org>; Tue, 16 Jun 2009 06:28:30 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #28 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-16 06:28:27 ---
Hi,

ok, seems like you can bootup normally. I see even some read commands
which means that the drive might be working ok but you'll have to do
some more testing.

We need to see whether there are still any glitches. Just remove the
debugging patch and apply the fix. By the way, I've uploaded it to
bugzilla so that you don't have to copy-paste. Just do some audio
playing/dvd video/data cdrom accesses/whatever else use case comes to
your mind and collect the whole bootlog again and send it on, please.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
