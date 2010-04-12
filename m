From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Mon, 12 Apr 2010 19:06:44 GMT
Message-ID: <201004121906.o3CJ6ibx030293@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:47004 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776Ab0DLTGq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Apr 2010 15:06:46 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3CJ6jZ5030295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 12 Apr 2010 19:06:45 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #18 from Marc H. Thoben <kernelbug@develz.org>  2010-04-12 19:06:27 ---
Created an attachment (id=25968)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=25968)
dmesg, debug ide-cd_mod, untainted kernel, request sense failure

Not sure this is connected.. while trying to force the kernel panic.. I
mounted, unmounted, opened, closed.. ran some applications and suddenly got
this (without CD in drive):

hda: request sense failure: status=0xc0 { Busy }
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: possibly failed opcode: 0xa0
hda: drive not ready for command

There's a call trace following. I rebooted, since the ide-cd module no longer
logged anything.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
