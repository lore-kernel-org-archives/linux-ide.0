From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10436] Compact Flash HD: dma and seek_error/badCRC problems
Date: Thu, 10 Apr 2008 12:21:03 -0700 (PDT)
Message-ID: <20080410192103.1D19F108061@picon.linux-foundation.org>
References: <bug-10436-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52703 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752693AbYDJTVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Apr 2008 15:21:33 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3AJL3nC001135
	for <linux-ide@vger.kernel.org>; Thu, 10 Apr 2008 12:21:04 -0700
In-Reply-To: <bug-10436-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10436





------- Comment #3 from marco@absence.it  2008-04-10 12:21 -------
Created an attachment (id=15724)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=15724&action=view)
dmidecode output

I'm afraid dmi data isn't much of help. As you can see at
http://www.lm-sensors.org/ticket/2298 this problem already occurred with
sensors-detect, due to a non-standard address in the SuperIO chip. Maybe asking
VIA a BIOS containing a motherboard identifier string would help?
However I have two questions for you:
1) Why does it work using udma4 with the previous 2.6.22?
2) In the BIOS at "ATA(PI) 80 pin Cable Detection" I can select "Host &
Device", "Host" and "Device". Which one should I choose? Which one could/should
be better?

About the second (hardware related) issue, I simply had this drive laying
around, so I gave a try, but I'll buy a new sata II one and use AHIC.
So let me know if you find something useful in the dmidecode output, otherwise
feel free to close this bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
