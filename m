From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Mon, 24 Mar 2008 06:46:39 -0700 (PDT)
Message-ID: <20080324134639.8341B11D10B@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54810 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758295AbYCXNrL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 09:47:11 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2ODkdW2031863
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 06:46:40 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #14 from gordonfarquharson@gmail.com  2008-03-24 06:46 -------
Do you think the problem may have been introduced before the error reporting?
The reason I ask is I need to know whether the error messages are sufficient to
determine a fail condition during the git bisect, or whether I need to have the
debugging messages turned on and look for the all 0x00 register setting.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
