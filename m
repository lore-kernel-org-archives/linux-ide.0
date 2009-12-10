From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Thu, 10 Dec 2009 23:55:04 GMT
Message-ID: <200912102355.nBANt48R019358@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:37765 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343AbZLJXy5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Dec 2009 18:54:57 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBANt4kw019359
	for <linux-ide@vger.kernel.org>; Thu, 10 Dec 2009 23:55:04 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #31 from Robert Hancock <hancockrwd@gmail.com>  2009-12-10 23:55:03 ---
Yes, that could potentially be a factor. Could also try disabling that service
(however exactly one does this) on the newer distro and see if that helps..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
