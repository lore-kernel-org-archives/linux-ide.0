From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11602] cdrom drive cannot open the tray, but reported this badly in /proc/sys/dev/cdrom/info
Date: Sat, 20 Sep 2008 10:59:45 -0700 (PDT)
Message-ID: <20080920175945.F284111D107@picon.linux-foundation.org>
References: <bug-11602-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55062 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbYITR7s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Sep 2008 13:59:48 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8KHxkan026853
	for <linux-ide@vger.kernel.org>; Sat, 20 Sep 2008 10:59:47 -0700
In-Reply-To: <bug-11602-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11602





------- Comment #1 from nm127@freemail.hu  2008-09-20 10:59 -------
Created an attachment (id=17912)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=17912&action=view)
cdrom tray close debug patch


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
