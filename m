From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: CPU usage is very high while io'ing a sata disk
Date: Tue, 29 Nov 2005 18:16:49 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0511291810180.30872-100000@coffee.psychology.mcmaster.ca>
References: <5d96567b0511291323j4fa468d7t66d1cdd7e47061a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:11261 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1751424AbVK3AQI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Nov 2005 19:16:08 -0500
In-Reply-To: <5d96567b0511291323j4fa468d7t66d1cdd7e47061a7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Cc: linux-ide@vger.kernel.org

> there is a huge impact over the cpu usage.

nah.

> dd if=/dev/sdb of=/dev/zero bs=1M count=1000
> it ended after 16 seconds.

66 MB/s, which is OK.

> during that time cpu usage was nearly 100% usage.

no, that's the only problem: you're misunderstanding the output.
during the dd, one process (dd, of course) was almost always in 
short wait, which is traditionally counted towards loadavg,
and shows up in your 'wa' column.  note that the actual cpu used
(us+sy) is fairly low, around 9%.

> that most of the time it spends in mwait_idle ( 98%) which is vert odd

not so odd, since the machine _is_ idle.  vmstat and related user-level
tools simply report an IO-blocked process as in wait.

> use a hardware raid the cpu usage is logically low ( since it is a
> scsi driver ).

no: the nature of the driver would not effect this, which is purely
a semantic issue of how to interpret processes blocked on IO.

