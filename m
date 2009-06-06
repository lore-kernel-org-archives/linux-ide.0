From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13399] kernel crash SONY DVD-ROM with cd
Date: Sat, 6 Jun 2009 19:37:26 GMT
Message-ID: <200906061937.n56JbQiX004113@demeter.kernel.org>
References: <bug-13399-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48828 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbZFFThX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Jun 2009 15:37:23 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n56JbQLe004114
	for <linux-ide@vger.kernel.org>; Sat, 6 Jun 2009 19:37:26 GMT
In-Reply-To: <bug-13399-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13399





--- Comment #9 from Borislav Petkov <bbpetkov@yahoo.de>  2009-06-06 19:37:25 ---
Hi,

can you apply the attached debug patch and send me the whole dmesg output
again. Also, do

objdump -d drivers/ide/ide-cd.o > ide-cd.dsm
make drivers/ide/ide-cd.s

objdump -d drivers/ide/ide-io.o > ide-io.dsm
make drivers/ide/ide-io.s

and send me the .dsm and .s files.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
