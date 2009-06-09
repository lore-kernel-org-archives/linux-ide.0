From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Tue, 9 Jun 2009 15:57:56 GMT
Message-ID: <200906091557.n59Fvud8020246@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35388 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbZFIP54 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Jun 2009 11:57:56 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n59Fvu6E020247
	for <linux-ide@vger.kernel.org>; Tue, 9 Jun 2009 15:57:56 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #17 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-09 15:57:55 ---
Sorry for misleading you - I saw the 'console=uart..' part in the
command line only after hitting send. In that case, dmesg is not the
thing we need at all. Just add 'log_buf_len=10M' to your kernel command
line, boot with it and make sure the output caught over the serial
console is complete or at least it has caught the complete OOPS. You
could also add 'console=tty0' to the kernel command line so that you can
monitor the oopsing machine output and compare it with what has gone
over through the com port.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
