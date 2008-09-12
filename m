From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11511] HPT374 detection crash with 74811f355f4f69a187fa74892dcf2a684b84ce99
Date: Fri, 12 Sep 2008 12:40:00 -0700 (PDT)
Message-ID: <20080912194000.4DFD310805B@picon.linux-foundation.org>
References: <bug-11511-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37078 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137AbYILTka (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Sep 2008 15:40:30 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8CJe0OD014302
	for <linux-ide@vger.kernel.org>; Fri, 12 Sep 2008 12:40:01 -0700
In-Reply-To: <bug-11511-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11511


rjw@sisk.pl changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |CLOSED
         Resolution|                            |CODE_FIX




------- Comment #1 from rjw@sisk.pl  2008-09-12 12:39 -------
Fixed by commit 62ff2ecf7a4e69f7271b7f7a57aaee76ffe610f2 .


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
