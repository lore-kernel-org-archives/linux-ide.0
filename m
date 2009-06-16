From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13520] WARNING: at lib/dma-debug.c:576
 check_for_illegal_area+0xd3/0xfd()
Date: Tue, 16 Jun 2009 10:28:01 GMT
Message-ID: <200906161028.n5GAS1f6030224@demeter.kernel.org>
References: <bug-13520-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55610 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbZFPK2B (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Jun 2009 06:28:01 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n5GAS1jl030225
	for <linux-ide@vger.kernel.org>; Tue, 16 Jun 2009 10:28:01 GMT
In-Reply-To: <bug-13520-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13520





--- Comment #3 from Joerg Roedel <joro@8bytes.org>  2009-06-16 10:27:59 ---
Ok, this was a dma-debug bug. The two warnings above are for memory areas which
exactly ends at the beginning of the kernel text segment. I queued a fix in my
tree and send it out when -rc1 is released. I also marked the patch for stable
backporting.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
