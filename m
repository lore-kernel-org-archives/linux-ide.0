From: Marc Bevand <bevand_m@epita.fr>
Subject: Re: (SOLVED) Generic bug/race in the IDE/SATA code ?
Date: Wed, 20 Oct 2004 14:29:17 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041020122917.GA6896@iah.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from deliver.epitech.net ([163.5.0.25]:50718 "HELO
	ideliver.epitech.net") by vger.kernel.org with SMTP id S270033AbUJTM32
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Oct 2004 08:29:28 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Paul Fisher <rao@gnu.org>

Marc wrote:
| Marc wrote:
| |  What the hell could be the problem on Paul's system and mine ?
| |  Both of us have a Tyan motherboard (but not the same model).
|
| So is this a generic bug/race in the Linux IDE/SATA code ?

I have a very good news: the problem is completely solved in 2.6.9 !

With 2.6.9-rc1, it took me about 30 seconds to generate a watchdog
timeout error, but with 2.6.9 I was not able to reproduce it when
stressing the disks during 7 hours... I am going to do a binary search
to find the exact patch that fixes the problem.

Paul: can you try 2.6.9 and confirm this ?

-- 
Marc Bevand                          http://www.epita.fr/~bevand_m
Computer Science School EPITA - System, Network and Security Dept.
