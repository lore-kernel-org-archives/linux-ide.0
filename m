From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Sun, 5 Apr 2009 10:42:59 GMT
Message-ID: <200904051042.n35AgxTA025990@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:36091 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755805AbZDEKnA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Apr 2009 06:43:00 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n35Agx9t025991
	for <linux-ide@vger.kernel.org>; Sun, 5 Apr 2009 10:42:59 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #13 from Mark de Wever <koraq@xs4all.nl>  2009-04-05 10:42:58 ---
Created an attachment (id=20810)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=20810)
modprobe with patch

I just tested with only the "temporary fix" patch patch applied and it didn't
help. Attached the dmesg output of modprobe.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
