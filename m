From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Fri, 18 Dec 2009 08:24:11 GMT
Message-ID: <200912180824.nBI8OBIN001264@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47910 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbZLRIYM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Dec 2009 03:24:12 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.2) with ESMTP id nBI8OBom001265
	for <linux-ide@vger.kernel.org>; Fri, 18 Dec 2009 08:24:11 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #41 from Lennart Poettering <mzxreary@0pointer.de>  2009-12-18 08:24:10 ---
(In reply to comment #36)

> * Spinning up drives in standby mode (smartmontools uses CHK_POWER to check
> power state before issuing SMART commands).

We do that too.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
