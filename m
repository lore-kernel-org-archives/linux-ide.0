From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 15:00:02 -0800 (PST)
Message-ID: <20081109230002.4205E108057@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37672 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756316AbYKIXAf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 18:00:35 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9N02sg001477
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 15:00:03 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #18 from bzolnier@gmail.com  2008-11-09 15:00 -------
Do SCSI and IDE devices share IRQs?  Could you post the output of 'cat
/proc/interrupts' from the "irqpoll" kernel?

PS I don't think that there is a need to do anything with the patch currently.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
