From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Sat, 31 Oct 2009 23:44:13 GMT
Message-ID: <200910312344.n9VNiDJe004529@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:33499 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933348AbZJaXoI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Oct 2009 19:44:08 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n9VNiDh0004530
	for <linux-ide@vger.kernel.org>; Sat, 31 Oct 2009 23:44:13 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515





--- Comment #3 from Lloyd Weehuizen <lloyd@fusion.net.nz>  2009-10-31 23:44:12 ---
Rolling back to kernel 2.6.30 reduces the occurrence of this issue, but it
still occurs.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
