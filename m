From: Deyan Chepishev <dchepishev@yahoo.com>
Subject: raid1 sata_promise initialization order problem
Date: Sat, 29 Jul 2006 01:35:31 -0700 (PDT)
Message-ID: <20060729083531.97107.qmail@web34210.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web34210.mail.mud.yahoo.com ([66.163.178.125]:49278 "HELO
	web34210.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422701AbWG2Ifc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 Jul 2006 04:35:32 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

Sorry if I am writing to the wrong people, but I took
them from the sources.

Here Is the problem I experience:

I have server HP Proliant ML 150 G2 equipped with SATA
Promise TX4 SATA300 controller.
Linux root partition is on software raid1
Linux is CentOS 4.3

I downloaded kernel 2.6.17.7
When I compile in the kernel both drivers sata_promise
and raid1, create appropriate initrd and reboot. The
system is unable to boot and kernel panics with last
messages something like:
switching root
unable to mount root 
and so on.

If I compile raid1 as module and create the
corresponding initrd the system is booting just fine.

This leads me to the conclusion that when compiled in
raid1 driver is initialized before the sata_promise
driver and is unable to see the mirror devices simply
because they dont exist yet.

When I use kernel 2.6.14.6 the whole thing is working
just fine with both drivers compiled in the kernel.

Do you think there is some way to tell the kernel
which driver to initialize first ?

Thanks in advance and sorry for bugging you with my problems

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
