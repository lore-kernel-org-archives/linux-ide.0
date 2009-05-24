From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Sun, 24 May 2009 12:22:38 GMT
Message-ID: <200905241222.n4OCMchG030550@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35745 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZEXMWh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 08:22:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4OCMc0n030551
	for <linux-ide@vger.kernel.org>; Sun, 24 May 2009 12:22:38 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365





--- Comment #9 from Jacob <fun2program8@yahoo.com>  2009-05-24 12:22:38 ---
Created an attachment (id=21513)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21513)
dmesg for 2.6.27

Here's a good boot's dmesg.

Well, guys, things have gotten very interesting since I last wrote this bug.
I'm not so sure this is a kernel bug anymore. My hard-drive made sounds almost
like it had turned off and was spinning down, but then turned back on again.
Several hours later, there was a hard-drive error, and Linux did an emergency
read-only remount.

I ran fsck, which presumably fixed the errors, and everything is working again.

Looking at my dmesg file in depth for the first time, I see some "Buffer"
errors that make me quiver.

Nevertheless, I'm going to continue fighting for 2.6.29, because there's still
a possibility that there's a bug keeping 2.6.29 from booting altogether. Unless
2.6.29 is being smart. ;)

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
