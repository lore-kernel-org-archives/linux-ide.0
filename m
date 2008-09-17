From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11581] CDRW not detected on boot. 2.6.18 worked ok.
Date: Wed, 17 Sep 2008 11:28:01 -0700 (PDT)
Message-ID: <20080917182801.1797210805D@picon.linux-foundation.org>
References: <bug-11581-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754516AbYIQS2E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Sep 2008 14:28:04 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8HIS1bL018574
	for <linux-ide@vger.kernel.org>; Wed, 17 Sep 2008 11:28:02 -0700
In-Reply-To: <bug-11581-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11581


axboe@kernel.dk changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bzolnier@gmail.com




------- Comment #4 from axboe@kernel.dk  2008-09-17 11:28 -------
Hmm interesting. So the drive is actually detected, but later issued commands
by udev are timing out. Could you double check if 2.6.27-rc6 is broken or not?

CC'ing Bart and Borislav.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
