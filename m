From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Tue, 10 Nov 2009 09:31:00 GMT
Message-ID: <200911100931.nAA9V0Ao003525@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:32858 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbZKJJaz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Nov 2009 04:30:55 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nAA9V0Ml003526
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2009 09:31:00 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515





--- Comment #9 from Tejun Heo <tj@kernel.org>  2009-11-10 09:30:57 ---
Andrew, yes and please attach kernel log with printk timestamp turned on which
includes boot and the failures and the output of "lspci -nn".

Thanks.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
