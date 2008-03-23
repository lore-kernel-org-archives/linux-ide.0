From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Sun, 23 Mar 2008 06:08:17 -0700 (PDT)
Message-ID: <20080323130817.3667611D109@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43825 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756519AbYCWNIs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Mar 2008 09:08:48 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2ND8HPG004006
	for <linux-ide@vger.kernel.org>; Sun, 23 Mar 2008 06:08:18 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #10 from bzolnier@gmail.com  2008-03-23 06:08 -------
ide_tf_load() is called for almost all commands (including READs/WRITEs) so
something went wrong ('make modules_install'?).  Please check if the debug
strings are present in the module that is executed (/lib/modules/...) not the
one in kernel source directory.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
