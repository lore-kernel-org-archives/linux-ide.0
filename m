From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 33342] [2.6.39-rc2][bisected] Constant DISK_MEDIA_CHANGE_EVENTS
 from CDROM drive.
Date: Thu, 21 Apr 2011 17:59:10 GMT
Message-ID: <201104211759.p3LHxA6N001159@demeter1.kernel.org>
References: <bug-33342-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:56582 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219Ab1DUR7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Apr 2011 13:59:11 -0400
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p3LHxAuN001160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 21 Apr 2011 17:59:10 GMT
In-Reply-To: <bug-33342-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=33342





--- Comment #3 from Shaun Ruffell <sruffell@sruffell.net>  2011-04-21 17:58:53 ---
These patches resolve the issue that I originally saw.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
