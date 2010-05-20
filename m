From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Thu, 20 May 2010 17:07:12 GMT
Message-ID: <201005201707.o4KH7CYP004884@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:41085 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab0ETRHN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 May 2010 13:07:13 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4KH7CLU004885
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 20 May 2010 17:07:12 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #29 from Tejun Heo <tj@kernel.org>  2010-05-20 17:07:09 ---
You're mixing load average and cpu usage.  Two are somewhat related but not the
same thing.  If you don't understand that, just stay away from system
monitoring utilities which distinguish idle and iowait.  There are quite a few
pretty monitoring graphical widgets which don't draw attention to iowait
(either draw it the same as idle or in subtle tone).  Your request to change
the meaning of load avg is not different from requesting the kernel to add
cached/buffered memory to free memory as some people can't wrap their heads
around what those numbers actually mean.

I don't think this is going anywhere and am fairly sure that further bug
reports on the subject won't lead anywhere.

Let's meet again in a more productive discussion.  Thanks.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
