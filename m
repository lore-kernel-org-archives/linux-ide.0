From: Paul Ionescu <paul@acorp.ro>
Subject: how to rescan IDE bus in kernel 2.6.x
Date: Fri, 30 Jan 2004 01:36:57 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1075419417.1879.349.camel@t40>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.dnt.ro ([194.102.255.8]:40636 "EHLO mail.b.astral.ro")
	by vger.kernel.org with ESMTP id S266524AbUA2Xhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jan 2004 18:37:53 -0500
List-Id: linux-ide@vger.kernel.org
To: linux-ide@VGER.KERNEL.ORG

Hello all,

I have an ide-atapi cage for hardisk which is hot swappable (you can
change the pata hdd while the system is running by powering off the
cage, pull it, change drive, insert it again, power on the box).
In kernel 2.4.x I could use hdparm -U before powering off the cage and
hdparm -R after powering on the cage, and the new hdd was recongnized.
Or I could even use the idectl script which comes with hdparm for the same purpose.
This worked also for my IBM thinkpad which has hotswappable CDROM.

With the new 2.6.x kernel, this does not work anymore.
I have searched lkml and linux-ide list for a solution but I found only pointers for 2.4.x
kernels.

Is ide rescan supported in 2.6.x kernels and how to do it ?
I've posted this question on lkml some days ago but I did not received any answer, 
so I guess this would be the right place to ask next.

Thanks,
Paul


