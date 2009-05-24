From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13365] 2.6.28+ cannot read a hard-drive properly through an
 "82801DB (ICH4) IDE Controller"
Date: Sun, 24 May 2009 12:38:39 GMT
Message-ID: <200905241238.n4OCcdQp031650@demeter.kernel.org>
References: <bug-13365-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:53259 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbZEXMih (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 May 2009 08:38:37 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4OCcdta031651
	for <linux-ide@vger.kernel.org>; Sun, 24 May 2009 12:38:39 GMT
In-Reply-To: <bug-13365-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13365





--- Comment #10 from Jacob <fun2program8@yahoo.com>  2009-05-24 12:38:38 ---
Created an attachment (id=21514)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21514)
good dmesg for 2.6.29

Christopher (at least, I'm pretty sure he's the one who recommended this
workaround on the Gentoo forums) was right: the Serial ATA drivers do not work,
but the ATA ones do. I'm now using 2.6.29.4, with /dev/hda instead of /dev/sda.
 I'm also without X at the moment, since the intel driver is failing to paint
pixels correctly on my screen. Another bug for another day, perhaps. ;)

I'll let you guys decide whether it's a hard-drive issue or a kernel issue, but
I think it has a good chance of being a kernel issue at this point.

If you need any more inforamtion, let me know.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
