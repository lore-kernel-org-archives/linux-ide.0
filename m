From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 3094] POOR I/O perfomance on VIA chipsets
Date: Wed, 19 May 2010 17:18:04 GMT
Message-ID: <201005191718.o4JHI4Wa019953@demeter.kernel.org>
References: <bug-3094-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:48790 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869Ab0ESRSH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 May 2010 13:18:07 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o4JHI4ii019954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Wed, 19 May 2010 17:18:05 GMT
In-Reply-To: <bug-3094-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3094





--- Comment #21 from Artem S. Tashkinov <t.artem@mailcity.com>  2010-05-19 17:17:37 ---
(In reply to comment #20)
> I/O wait is measuring the amount of time the machine is waiting for the disk,
> not how much it is using CPU. Disks haven't gotten much faster in the past ten
> years (SSD aside) while processors dramatically did. There isn't a lot that can
> be done about the speed of disks,. Getting the kernel to schedule I/O better
> can help a bit but the fundamental problem is that a disk on a good day can
> only really do about 200 operations/second.

What really enrages people (and me too) is that under all circumstances CPU
usage shown by `top` is always 100% whenever a single process is writing or
reading to a spinning storage at full speed.

It is _wrong_ and it is _misleading_ because then people think that the Linux
kernel sucks at I/O operations, everyone instantly recollects Windows
experience where (e.g. on my own PC) HDD access causes maximum 2% CPU usage.

Fix the kernel idle time computation, otherwise people will keep complaining
indefinitely.

`cat /dev/sda > /dev/null` results in load average rapidly climbing to 1.32 and
counting on my PC, that's just insane and wrong.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
