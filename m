From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Sat, 15 Aug 2009 08:02:30 GMT
Message-ID: <200908150802.n7F82U3H025675@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:55361 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbZHOIC3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Aug 2009 04:02:29 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n7F82VMs025676
	for <linux-ide@vger.kernel.org>; Sat, 15 Aug 2009 08:02:31 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #33 from Borislav Petkov <bbpetkov@yahoo.de>  2009-08-15 08:02:27 ---
Created an attachment (id=22722)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=22722)
disable DMA for RW commands

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
