From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon,  5 Jan 2009 12:21:04 -0800 (PST)
Message-ID: <20090105202104.E38CE10800E@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46450 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbZAEUVX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 15:21:23 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n05KL5wW008458
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 12:21:06 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #15 from nm127@freemail.hu  2009-01-05 12:21 -------
Created an attachment (id=19666)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=19666&action=view)
dmesg 2.6.28 + patches from comment #5 & comment #13

I booted the system, inserted an audio CD. The kaffeine application started and
tried to play the tracks but nothing was played, instead, after 3..5 seconds
kaffeine jumped to the next track. Then I stopped kaffeine and removed the CD.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
