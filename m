From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33342] [2.6.39-rc2][bisected] Constant DISK_MEDIA_CHANGE_EVENTS
 from CDROM drive.
Date: Mon, 18 Apr 2011 04:13:49 GMT
Message-ID: <201104180413.p3I4DnsF004251@demeter1.kernel.org>
References: <bug-33342-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:60698 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1DRENu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Apr 2011 00:13:50 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3I4DnW1004252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 18 Apr 2011 04:13:49 GMT
In-Reply-To: <bug-33342-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33342





--- Comment #1 from Shaun Ruffell <sruffell@sruffell.net>  2011-04-18 04:13:48 ---
I believe that this issue and #33412 are related.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
