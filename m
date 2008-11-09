From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Sun,  9 Nov 2008 08:58:10 -0800 (PST)
Message-ID: <20081109165810.20EB5108047@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53887 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755424AbYKIQ6M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:58:12 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA9GwANR010180
	for <linux-ide@vger.kernel.org>; Sun, 9 Nov 2008 08:58:11 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |alan@lxorguk.ukuu.org.uk




------- Comment #10 from alan@lxorguk.ukuu.org.uk  2008-11-09 08:58 -------
If the BIOS isn't getting run then that patch seems plausible IFF the registers
are the same between the chips. I don't have enough Artop docs here to tell.

Probably worth getting an lspci -vvxxx from it (off a live cd or similar) to
see what it look slike.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
