From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sun, 21 Dec 2008 22:20:11 -0800 (PST)
Message-ID: <20081222062011.2CD76108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47728 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbYLVGUP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Dec 2008 01:20:15 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBM6KB4k013724
	for <linux-ide@vger.kernel.org>; Sun, 21 Dec 2008 22:20:12 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #22 from bbpetkov@yahoo.de  2008-12-21 22:20 -------
Hi,

thanks for testing. It seems that your drive really can't playing audio. Please
revert the old patch I sent you and try this next one - it asks the drive
whether it supports play audio commands. Then do send me the whole dmesg boot
log.

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
