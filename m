From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Fri, 11 Sep 2009 15:04:26 GMT
Message-ID: <200909111504.n8BF4QXM030488@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:45247 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZIKPEX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Sep 2009 11:04:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n8BF4Q8P030489
	for <linux-ide@vger.kernel.org>; Fri, 11 Sep 2009 15:04:26 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #53 from David Woodhouse <dwmw2@infradead.org>  2009-09-11 15:04:21 ---
Created an attachment (id=23073)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=23073)
dmesg

That patch still lets drive->debug_mask get overridden from the module
parameter, shortly after you manually set it to 0xffffffff. With that fixed,
here's the output.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
