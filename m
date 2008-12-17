From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12217] reading a cdrom hangs the system
Date: Wed, 17 Dec 2008 03:33:14 -0800 (PST)
Message-ID: <20081217113314.B7C6610800F@picon.linux-foundation.org>
References: <bug-12217-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33264 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbYLQLdR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Dec 2008 06:33:17 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHBXEJp009505
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 03:33:16 -0800
In-Reply-To: <bug-12217-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12217


alan@lxorguk.ukuu.org.uk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |alan@lxorguk.ukuu.org.uk
             Status|NEW                         |ASSIGNED




------- Comment #5 from alan@lxorguk.ukuu.org.uk  2008-12-17 03:33 -------
Nothing obvious and its a configuration that is common and works for others.

Some oddities pointing to laptop funnies - "[    4.523009] pata_via
0000:00:11.1: can't derive routing for PCI INT A' being one, but if the basic
CD stuff works clearly IRQ delivery is working.

"Kernel driver in use: ndiswrapper."  

This is a random Ubuntu kernel (which differs a fair bit from the upstream
Linux kernel), running proprietary window driver support hacks that are not
upstream or considered as reliable by the community.

Can you reproduce the problem with a standard 2.6.27 kernel and without stuff
like ndiswrapper ever having been loaded that boot ? If not you need to report
the bug to the Ubuntu team not here.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
