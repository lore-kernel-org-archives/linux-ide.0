From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16414] Panic during IO from both hard disk and CD-ROM on VIA
 IDE chipset using pata_via
Date: Fri, 13 Jul 2012 14:14:11 +0000 (UTC)
Message-ID: <20120713141411.13CF111FACF@bugzilla.kernel.org>
References: <bug-16414-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50971 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab2GMOOV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2012 10:14:21 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D4BB9201D1
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2012 14:14:16 +0000 (UTC)
Received: from bugzilla.kernel.org (unknown [198.145.19.217])
	by mail.kernel.org (Postfix) with ESMTP id 1529C201C2
	for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2012 14:14:11 +0000 (UTC)
In-Reply-To: <bug-16414-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16414





--- Comment #6 from old_man999@gmx.de  2012-07-13 14:14:10 ---
Created an attachment (id=75311)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=75311)
Kernel Panic after Reading from CD-Audio

Hardware:
TargaVisionaryXP
AMD AthlonXP-m
VIA KT333 w. VT8235
IDE DVD-Rom/CDRW Samsung SN324B with Firmware U103

no access to CD possible without kernel panic after a short time.
When inserting at boot time there are a lot of io errors on device.
Works normally on MS Windows without read error.
Was working before at least with kernel 2.6.18.
Tried kernels:
2.6.32 debian
3.2.   -"-
3.4
3.2. Partition magic (slackware)    <<here device is not mounting when cd is
inserted
Everything was up to date. Last try: 11.07. 2012

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
