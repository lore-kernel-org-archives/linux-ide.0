From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 15:45:07 -0800 (PST)
Message-ID: <20081109234507.CE1B9108040@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43806 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756308AbYKIXpK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 18:45:10 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9Nj70N003490
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 15:45:08 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #20 from bzolnier@gmail.com  2008-11-09 15:45 -------
Ah, now I understand -- "irqpoll" only helps in getting past IDE messages but
boot still hangs on mesh driver initialization, right? [ I thought that you can
now boot successfully the installed system using "irqpoll". ]

If so this really looks more like a generic platform problem affecting both IDE
and SCSI (mesh driver has an "interesting" IRQ handling routine that will loop
forever if IRQ is not cleared).


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
