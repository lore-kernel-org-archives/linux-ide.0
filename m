From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Mon, 14 Dec 2009 16:51:23 GMT
Message-ID: <200912141651.nBEGpNlh000743@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:44362 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856AbZLNQvY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Dec 2009 11:51:24 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nBEGpNWA000747
	for <linux-ide@vger.kernel.org>; Mon, 14 Dec 2009 16:51:23 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583


Johan Van den Neste <jvdneste@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jvdneste@gmail.com




--- Comment #32 from Johan Van den Neste <jvdneste@gmail.com>  2009-12-14 16:51:20 ---
Comment #28 points out that indeed the bug does not show on older distros with
a new kernel. The devicekit suggestion looks to be spot on, indicated by
comments 107 and 108 in the ubuntu bug tracker (referenced here in comment
#24).

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
