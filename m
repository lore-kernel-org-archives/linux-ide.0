From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sun, 14 Dec 2008 13:16:59 -0800 (PST)
Message-ID: <20081214211659.78BD3108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60082 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499AbYLNVRB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Dec 2008 16:17:01 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBELGxEi017576
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2008 13:17:00 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #9 from bbpetkov@yahoo.de  2008-12-14 13:16 -------
This happens because the scsi cdrom driver (sr) is registering with the cdrom. 

Can you play audio with that driver?

Regards,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
