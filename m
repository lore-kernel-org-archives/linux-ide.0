From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10803] Kernel freeze on accesing CD-ROM or HDD
Date: Thu, 29 May 2008 11:13:15 -0700 (PDT)
Message-ID: <20080529181315.09755108047@picon.linux-foundation.org>
References: <bug-10803-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37337 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbYE2SNQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 May 2008 14:13:16 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4TIDFvF009873
	for <linux-ide@vger.kernel.org>; Thu, 29 May 2008 11:13:16 -0700
In-Reply-To: <bug-10803-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10803


devzero@web.de changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |devzero@web.de




------- Comment #3 from devzero@web.de  2008-05-29 11:13 -------
yes, maybe.
please unload any proprietary driver so that your kernel isn`t tainted.
kernel developers cannot really help on kernel problems being caused by
proprietary/closed-source drivers.

can you reproduce that issue with those drivers unloaded ?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
