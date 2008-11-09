From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 14:05:13 -0800 (PST)
Message-ID: <20081109220513.A296A108047@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41135 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755914AbYKIWFP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 17:05:15 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9M5DvH031388
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 14:05:14 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943





------- Comment #15 from bzolnier@gmail.com  2008-11-09 14:05 -------
Update: hdparm -d1 /dev/hda won't work since we removed CONFIG_IDEDMA_PCI_AUTO
config option before 2.6.24 but it still would be to useful to boot with
"hde=nodma" and no "irqpoll".


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
