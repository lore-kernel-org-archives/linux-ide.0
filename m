From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14583] SSD system stall, HSM Violation
Date: Wed, 18 Nov 2009 07:59:07 GMT
Message-ID: <200911180759.nAI7x7hO026801@demeter.kernel.org>
References: <bug-14583-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:46479 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbZKRH7C (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 02:59:02 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAI7x7v3026802
	for <linux-ide@vger.kernel.org>; Wed, 18 Nov 2009 07:59:07 GMT
In-Reply-To: <bug-14583-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14583





--- Comment #16 from Andrew Simpson <andrewnz.simpson@gmail.com>  2009-11-18 07:59:07 ---
O.K. Just confirming: Running 2.6.28 (Ubuntu 9.04 LiveCD on USB stick) gives no
bug messages in dmesg.  Running gparted (which generates plenty of messages in
2.6.31) and checking dmesg shows no change.

Happy to provide more on request.

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
