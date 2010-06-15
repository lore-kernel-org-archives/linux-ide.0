From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Tue, 15 Jun 2010 19:39:39 GMT
Message-ID: <201006151939.o5FJddHY025640@demeter.kernel.org>
References: <bug-16142-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48717 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab0FOTjk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2010 15:39:40 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o5FJddSW025641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2010 19:39:39 GMT
In-Reply-To: <bug-16142-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=16142





--- Comment #16 from Hans42Mueller@googlemail.com  2010-06-15 19:39:35 ---
Well as gentoo does not provide precompiled packages, I compiled everything by
myself.
I could try to use another version of gcc for compiling the kernel.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
