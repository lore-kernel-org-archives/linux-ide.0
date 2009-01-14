From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Wed, 14 Jan 2009 12:09:22 -0800 (PST)
Message-ID: <20090114200922.900B3108042@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59718 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756064AbZANUJx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 15:09:53 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0EK9MLE019146
	for <linux-ide@vger.kernel.org>; Wed, 14 Jan 2009 12:09:23 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #22 from nm127@freemail.hu  2009-01-14 12:09 -------
(In reply to comment #21)
> let me put in another way: does it work after you revert
> 9bd27cba1aeacb6b12d05f4e5ed6361072f08fe0?

Yes, as I mentioned in comment #10, reverting the patch stopped sending
messages to dmesg. I was able to play CDs with vanilla kernels, the only
diffecence was the warning messages.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
