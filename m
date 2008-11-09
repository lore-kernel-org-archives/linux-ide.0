From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 13:50:38 -0800 (PST)
Message-ID: <20081109215038.E5BDC108040@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51554 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755919AbYKIVvJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 16:51:09 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9Loc6T029799
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 13:50:39 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #14 from bzolnier@gmail.com  2008-11-09 13:50 -------
Thanks.  Could you try booting your installed system with "hde=nodma" kernel
option, and if that works do (as root):

setpci -s 01:04.0 4a.b=86
hdparm -d1 /dev/hde

and see if hde continues to work fine (now with DMA mode enabled)?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
