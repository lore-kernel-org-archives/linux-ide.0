From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9962] 2.6.26-git0: IDE oops during boot
Date: Wed, 13 Feb 2008 14:38:30 -0800 (PST)
Message-ID: <20080213223830.BEFEC108070@picon.linux-foundation.org>
References: <bug-9962-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33360 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755182AbYBMWjA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 17:39:00 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1DMcUqW010034
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 14:38:31 -0800
In-Reply-To: <bug-9962-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9962





------- Comment #1 from bzolnier@gmail.com  2008-02-13 14:38 -------
What makes you think that it is actually an IDE problem?  The initial problem
(which Andi fixed) was with *ide_generic* oopsing and could be just
work-arounded by disabling ide_generic (like reported by Pavel).

Asking Kamalesh to provide dmesg output instead would be far more useful than
opening this bugzilla entry...


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
