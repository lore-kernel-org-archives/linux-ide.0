From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 12874] Seagate STT20000A no longer works
Date: Wed, 8 Apr 2009 22:21:27 GMT
Message-ID: <200904082221.n38MLRQD000706@demeter.kernel.org>
References: <bug-12874-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41995 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844AbZDHWV2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Apr 2009 18:21:28 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n38MLRXQ000707
	for <linux-ide@vger.kernel.org>; Wed, 8 Apr 2009 22:21:27 GMT
In-Reply-To: <bug-12874-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12874





--- Comment #19 from Mark de Wever <koraq@xs4all.nl>  2009-04-08 22:21:27 ---
Created an attachment (id=20892)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=20892)
dmesg with patches 'tmp fix 2' + 'dump drive caps and dbg rqs'

As requested the complete dmesg output of booting and modprobe with the 'tmp
fix 2' + 'dump drive caps and dbg rqs' patches applied.

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
