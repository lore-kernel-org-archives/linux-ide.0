From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Wed, 25 Mar 2009 08:42:07 GMT
Message-ID: <200903250842.n2P8g79H027540@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43632 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbZCYJ0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Mar 2009 05:26:52 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n2P8g7Nq027541
	for <linux-ide@vger.kernel.org>; Wed, 25 Mar 2009 08:42:07 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #9 from Borislav Petkov <bbpetkov@yahoo.de>  2009-03-25 08:42:07 ---
Hi,

can you apply the debug patch attached and send me the modprobe output again.
The patch is against stock 2.6.29 but it should apply fine against 2.6.29-rc7.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
