From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sun, 14 Dec 2008 22:13:33 -0800 (PST)
Message-ID: <20081215061333.111AD108042@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751237AbYLOGOG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Dec 2008 01:14:06 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBF6DXSm005451
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2008 22:13:34 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #11 from bbpetkov@yahoo.de  2008-12-14 22:13 -------
Hi,

hm, that's strange. Normally, if "Can play audio" is set, you should be able to
do that and according to, e.g.
http://www.sony-optiarc.eu/en/exhibits/slim-line-drives/bc-5500a, your hardware
is capable of playing audio. Well, you could try my patch to see if it fixes
your problem with ide-cd. However, make sure not to load scsi-cdrom but the
ide_cd_mod module.

Thanks,
Boris.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
