From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Fri, 29 May 2009 07:25:29 GMT
Message-ID: <200905290725.n4T7PTa3012187@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:54513 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbZE2HZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 May 2009 03:25:27 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4T7PTDt012188
	for <linux-ide@vger.kernel.org>; Fri, 29 May 2009 07:25:29 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399


Borislav Petkov <bbpetkov@yahoo.de> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bbpetkov@yahoo.de




--- Comment #2 from Borislav Petkov <bbpetkov@yahoo.de>  2009-05-29 07:25:28 ---
Hi,

please do on the same unchanged kernel sources that produce the crash:

objdump -d drivers/ide/ide-cd.o > ide-cd.dsm
make drivers/ide/ide-cd.s

and send me .dsm and .s files.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
