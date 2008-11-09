From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 15:52:33 -0800 (PST)
Message-ID: <20081109235233.7B61C108042@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60180 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756610AbYKIXxG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 18:53:06 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9NqXuC003797
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 15:52:34 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #21 from bzolnier@gmail.com  2008-11-09 15:52 -------
If the mesh driver is compiled as module in Ubuntu (I don't know that) you may
try blacklisting mesh driver (so it won't be run) by:

- booting from LiveCD

and

- editing /media/disk/etc/modprobe.d/blacklist file
  (just add "blacklist mesh" line at the end of it)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
