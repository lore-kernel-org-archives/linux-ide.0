From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Sun, 11 Apr 2010 17:53:00 GMT
Message-ID: <201004111753.o3BHr0pa018515@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:39221 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab0DKRxA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Apr 2010 13:53:00 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3BHr0XC018516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 11 Apr 2010 17:53:00 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #12 from Marc H. Thoben <kernelbug@develz.org>  2010-04-11 17:52:57 ---
Created an attachment (id=25960)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=25960)
dmesg, debug ide-cd_mod, with CD in drive at first then removed

For some reason netconsole didn't manage to transmit all of the last kernel
panic message. Please let me know if you need me to recreate this.

Attachment size limit hit, gzipped.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
