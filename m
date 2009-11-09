From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14515] ATA controller losing interrupt, system stall
Date: Mon, 9 Nov 2009 23:58:03 GMT
Message-ID: <200911092358.nA9Nw30E016423@demeter.kernel.org>
References: <bug-14515-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:34006 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZKIX56 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Nov 2009 18:57:58 -0500
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id nA9Nw3nZ016424
	for <linux-ide@vger.kernel.org>; Mon, 9 Nov 2009 23:58:03 GMT
In-Reply-To: <bug-14515-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=14515


Robert Hancock <hancockrwd@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockrwd@gmail.com




--- Comment #6 from Robert Hancock <hancockrwd@gmail.com>  2009-11-09 23:58:02 ---
AFAIK the cdrom code normally uses GET EVENT STATUS NOTIFICATION for this
rather than TEST UNIT READY. It would be interesting to know where exactly the
TUR is coming from..

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
