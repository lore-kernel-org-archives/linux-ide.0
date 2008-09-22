From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sun, 21 Sep 2008 21:42:31 -0700 (PDT)
Message-ID: <20080922044231.548E010805A@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50820 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751168AbYIVEnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Sep 2008 00:43:01 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8M4gVvd009266
	for <linux-ide@vger.kernel.org>; Sun, 21 Sep 2008 21:42:32 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602





------- Comment #5 from bbpetkov@yahoo.de  2008-09-21 21:42 -------
I don't think that the drive is reporting a wrong mechtype - it still _is_
equipped with a tray loading mechanism, it simply cannot close its tray by
itself and needs user help :). Also, there's AFAIK no bit in the cdrom
capabilities page returned by the drive which will tell you whether the drive
can close itself - there's only a bit saying that the drive can eject the media
via an ATAPI command.

The only solution, AFAICT, would be an artificial one: either a list of drive
model names which cannot close their tray (ugly :( and generally frowned upon)
or trying to lock the door and read sense data (hm, unreliable, overkill?). The
wrongly reported "Can close tray" is based on the assumption that if the drive
isn't caddy or popup loader then it can close its tray automatically as is the
case with the gazillion drives out there with a tray loading mechanism.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
