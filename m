From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] 2.6.25-rc2 + smartd = hang
Date: Fri, 21 Mar 2008 04:24:58 -0700 (PDT)
Message-ID: <20080321112458.8156811D10A@picon.linux-foundation.org>
References: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57228 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753899AbYCULZa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Mar 2008 07:25:30 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2LBOwY8016133
	for <linux-ide@vger.kernel.org>; Fri, 21 Mar 2008 04:24:59 -0700
In-Reply-To: <bug-10086-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086





------- Comment #7 from bzolnier@gmail.com  2008-03-21 04:24 -------
Some of SMART commands completed out with error (ERR bit is set in device
status) and the old code just didn't care to report it.  I would say that the
new behavior is the correct one but we may have to disable error reporting for
special commands by default if these messages become too annoying.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
