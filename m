From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9904] ASUS DVD-E616A - drive side 80-wire cable detection failed
Date: Thu, 14 Feb 2008 08:02:01 -0800 (PST)
Message-ID: <20080214160201.D8EF0108011@picon.linux-foundation.org>
References: <bug-9904-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33375 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751205AbYBNQCe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 11:02:34 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1EG22G0015788
	for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 08:02:03 -0800
In-Reply-To: <bug-9904-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9904





------- Comment #2 from bzolnier@gmail.com  2008-02-14 08:02 -------
Joseph, please send output of 'hdparm --Istdout /dev/hdd' command.

James, you are using different host driver so most likely this is not the same
bug - please open a new bugzilla entry and post dmesg command output.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
