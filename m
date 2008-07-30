From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10943] machine doesn't shutdown when ahci sata driver is compiled as module
Date: Wed, 30 Jul 2008 13:27:21 -0700 (PDT)
Message-ID: <20080730202721.97B0D108035@picon.linux-foundation.org>
References: <bug-10943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47882 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753470AbYG3U2Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 16:28:16 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6UKRLZg029537
	for <linux-ide@vger.kernel.org>; Wed, 30 Jul 2008 13:27:22 -0700
In-Reply-To: <bug-10943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10943





------- Comment #10 from gfpadovan@gmail.com  2008-07-30 13:27 -------
Sorry for delay on answer.

I Noted that the kernel take a infinite loop into device_shutdown()
(driver/base/core.c) when ahci compiled as module. I put dev_emerg on it and
saw the loop always showing "sd 0:0:0:0: shutdown".

I didn't have time to study about netconsole, but I will do.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
