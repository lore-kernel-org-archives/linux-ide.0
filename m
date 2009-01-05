From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12320] warn_on_slowpath when playing audio CD
Date: Mon,  5 Jan 2009 00:26:49 -0800 (PST)
Message-ID: <20090105082649.319B4108043@picon.linux-foundation.org>
References: <bug-12320-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59195 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbZAEI0w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 03:26:52 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n058QnbW025795
	for <linux-ide@vger.kernel.org>; Mon, 5 Jan 2009 00:26:50 -0800
In-Reply-To: <bug-12320-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12320





------- Comment #13 from bbpetkov@yahoo.de  2009-01-05 00:26 -------
Created an attachment (id=19651)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=19651&action=view)
fix setting up dma for non bio-backed requests


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
