From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 14994] Random Panic/Freeze due to BUG: unable to handle kernel
 NULL pointer dereference at 00000024(?)
Date: Wed, 14 Apr 2010 18:43:08 GMT
Message-ID: <201004141843.o3EIh8fT032602@demeter.kernel.org>
References: <bug-14994-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:46481 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab0DNSnK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Apr 2010 14:43:10 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3EIh9SW032613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 14 Apr 2010 18:43:09 GMT
In-Reply-To: <bug-14994-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=14994





--- Comment #21 from Marc H. Thoben <kernelbug@develz.org>  2010-04-14 18:42:53 ---
Created an attachment (id=26001)
 --> (https://bugzilla.kernel.org/attachment.cgi?id=26001)
dmesg, normal ide-cd_mod, tainted kernel 2.6.34-rc4

Pity I couldn't get Nouveau working with 2.6.34-rc4 without recompiling X/Mesa
- which I am not able to.

So I ran Nvidia again - but it's the same kernel panic, I believe.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
