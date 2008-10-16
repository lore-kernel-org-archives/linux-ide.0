From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Thu, 16 Oct 2008 04:35:20 -0700 (PDT)
Message-ID: <20081016113520.6035E108056@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35331 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753327AbYJPLfY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 07:35:24 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9GBZKlk029130
	for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 04:35:21 -0700
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732





------- Comment #8 from vedranf@vedranf.mine.nu  2008-10-16 04:35 -------
Created an attachment (id=18337)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=18337&action=view)
blkparse output

New info:
- Still happens with -rc9 (will try with vanilla 27 within next few days)
- Doesn't happen with 2.6.26
- Happens only with one drive (out of two tested, so it could be hw problem)
- Doesn't happen always, seem random but usually 2-3 times out of ten mounts
- It seems that it happens only when hal is running

blkparse output attached (more then one (u)mount)

Regards!


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
