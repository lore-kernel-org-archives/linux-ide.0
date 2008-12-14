From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12217] reading a cdrom hangs the system
Date: Sun, 14 Dec 2008 01:56:50 -0800 (PST)
Message-ID: <20081214095650.52773108040@picon.linux-foundation.org>
References: <bug-12217-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44645 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751793AbYLNJ5U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Dec 2008 04:57:20 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBE9uoZB022432
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2008 01:56:51 -0800
In-Reply-To: <bug-12217-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12217


bbpetkov@yahoo.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




------- Comment #1 from bbpetkov@yahoo.de  2008-12-14 01:56 -------
Hi,

please send the output of 'dmesg' and 'lspci -vv', the last one run as root.

Thanks.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
