From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11581] CDRW not detected on boot. 2.6.18 worked ok.
Date: Wed, 17 Sep 2008 09:37:39 -0700 (PDT)
Message-ID: <20080917163739.7C0B5108059@picon.linux-foundation.org>
References: <bug-11581-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46136 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753611AbYIQQr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 12:47:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8HGlQ95010137
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 09:47:27 -0700
In-Reply-To: <bug-11581-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11581


akpm@osdl.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |akpm@osdl.org,
                   |                            |axboe@kernel.dk
         AssignedTo|other_modules@kernel-       |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |
          Component|Modules                     |IDE
            Product|Other                       |IO/Storage
         Regression|0                           |1




------- Comment #3 from akpm@osdl.org  2008-09-17 09:37 -------
Marked as a regression, reassigned to IDE, cc'ed Jens.

Jens, please note that this was bisected down to a block layer change.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
