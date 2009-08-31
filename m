From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Mon, 31 Aug 2009 18:22:07 GMT
Message-ID: <200908311822.n7VIM7A0014742@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40709 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbZHaSWF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Aug 2009 14:22:05 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n7VIM7xj014743
	for <linux-ide@vger.kernel.org>; Mon, 31 Aug 2009 18:22:07 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #38 from Mark de Wever <koraq@xs4all.nl>  2009-08-31 18:22:04 ---
Created an attachment (id=22933)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=22933)
dmesg after running the test

I ran the test with kernel 2.6.31-rc8, pulling linux-next and your patch.
Attached the dmesg output after running it with the 32Kb file (32.copy was
still zero bytes).

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
