From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 5911] siimage.c interrupts screaming
Date: Sun, 13 Jan 2008 11:05:36 -0800 (PST)
Message-ID: <20080113190536.0FD69108074@picon.linux-foundation.org>
References: <bug-5911-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50942 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753381AbYAMTGN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Jan 2008 14:06:13 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0DJ5alx024711
	for <linux-ide@vger.kernel.org>; Sun, 13 Jan 2008 11:05:37 -0800
In-Reply-To: <bug-5911-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=5911





------- Comment #12 from James_McMechan@hotmail.com  2008-01-13 11:05 -------
Created an attachment (id=14437)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=14437&action=view)
copy of minicom bootlog panic.txt

2.6.24-r6-mm1 does not seem quite ready yet
I patched 2.6.23->2.6.24-rc6->2.6.24-rc6-mm1
and copied .config from 2.6.23.9
make oldconfig
it failed to compile with nfs on.
turned nfs off.
won't boot panics in __find_get_block/__getblk
is there something else I should try?
I have been running with the pata_sil on 2.6.23.9
looking over my notes I seem to remember that it appeared to be a problem with
enabling the board interrupt before initializing the second channel and
something BIOS? may have left a pending interrupt on the second channel
since the board is enabled but the second channel is not configured yet the
interrupt is not cleared and stays active. ~800000 later it dies due to the
timeout. then the second channel is configured and has more trouble since the
interrupt is disabled...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
