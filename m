From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Fri, 10 Apr 2009 10:06:05 GMT
Message-ID: <200904101006.n3AA659A004166@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:43125 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685AbZDJKGG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Apr 2009 06:06:06 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n3AA65Ag004167
	for <linux-ide@vger.kernel.org>; Fri, 10 Apr 2009 10:06:05 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #20 from Borislav Petkov <bbpetkov@yahoo.de>  2009-04-10 10:06:04 ---
Hmm, seems like the buffer is quite botched or the drive replies with some mode
parameter headers I cannot correlate. Ok, let's now enable full debugging -
please apply the following patch ontop of the other two you have already
applied on your tree. This time you should expect more output so you should add
'log_buf_len=10M ignore_loglevel' to the kernel command line to make sure you
catch it all. And as always, please send me the whole output.

Thanks,
Boris.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
