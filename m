From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12217] reading a cdrom hangs the system
Date: Wed, 17 Dec 2008 03:07:13 -0800 (PST)
Message-ID: <20081217110713.B4831108040@picon.linux-foundation.org>
References: <bug-12217-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39446 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751021AbYLQLHQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Dec 2008 06:07:16 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBHB7Dut008118
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2008 03:07:15 -0800
In-Reply-To: <bug-12217-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12217





------- Comment #3 from bbpetkov@yahoo.de  2008-12-17 03:07 -------
Hi,

ok you're using PATA and not ide-cd so this should be Alan's jurisdiction but
also you're using 2.6.24 which is pretty old and there's a good chance this bug
has already been fixed in later releases. Is it possible for you to try 2.6.27?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
