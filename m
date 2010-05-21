From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Fri, 21 May 2010 05:48:01 GMT
Message-ID: <201005210548.o4L5m1Y5022131@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:35941 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab0EUFsD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 May 2010 01:48:03 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4L5m1Ht022132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 21 May 2010 05:48:01 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #34 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-21 05:47:53 ---
(In reply to comment #32)
> Artem, just use gnome-system-monitor which is as easy as windows.  Don't think
> about load avg.  Just forget about it.

That's a relief, thank you. And I'm terribly sorry for adding htop into the
mix, it indeed correctly shows CPU usage.

(In reply to comment #31)
> It's defined by a standard. It's expected behaviour since the 1970s. "I don't
> like it" doesn't trump standards, especially given most users *expect* the
> current behaviour.

If load average includes IO wait time, let it be. Thank you for the
information.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
