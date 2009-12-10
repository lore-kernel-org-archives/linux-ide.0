From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 10 Dec 2009 06:05:05 GMT
Message-ID: <200912100605.nBA655Sb015871@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:50685 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932780AbZLJGE7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2009 01:04:59 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBA655qq015872
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2009 06:05:05 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #28 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-12-10 06:05:01 ---
You could be right that all the devices have common firmware (and bug).  It
just feels remote in this case.

More importantly, some interesting research on the Ubuntu bug report by a
number of users:

Ubuntu 9.10 (Karmic) shows the bug with 2.6.28, 2.6.29, 2.6.31, 2.6.32.

Ubuntu 9.04 (Jaunty) shows NO bug with 2.6.28, 2.6.30, 2.6.31, 2.6.32

This has been confirmed by three different users.  Ext4 has been ruled out
(same results with ext2).

Two questions:  Is this a bug outside the kernel space?  And how can a
userspace bug affect the disk operations?

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
