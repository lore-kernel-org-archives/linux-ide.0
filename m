From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Tue, 9 Jun 2009 05:31:45 GMT
Message-ID: <200906090531.n595VjYE031677@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:58804 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbZFIFbn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2009 01:31:43 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n595VjOD031678
	for <linux-ide@vger.kernel.org>; Tue, 9 Jun 2009 05:31:45 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #15 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-09 05:31:44 ---
Hi,

thanks for testing. Looks like your debug1 dmesg is incomplete. Please
try catching the the complete dmesg. For that, try enlarging the kernel
printk buffer with the command line param 'log_buf_len=10M' in case the
dmesg looks truncated. Although, it doesn't seem so - it's more a 'dmesg
-s<bufsize>' thing. Experiment with that in order to dump the whole
buffer contents if the printk buffer is big enough but the dmesg tool
itself is using a smaller one.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
