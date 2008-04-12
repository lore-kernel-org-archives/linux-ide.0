From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Promise TX4 performance problems
Date: Sat, 12 Apr 2008 23:56:41 +0200
Message-ID: <18433.12313.976468.250059@harpo.it.uu.se>
References: <cdcaea5a0804120556w6ef4479fi86c05a4613b12a97@mail.gmail.com>
	<20080412162628.334d66f1@core>
	<cdcaea5a0804121350n167b3715y4a0e52d543253423@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48850 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYDLV4y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 17:56:54 -0400
In-Reply-To: <cdcaea5a0804121350n167b3715y4a0e52d543253423@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marko Koivusalo <marko.koivusalo@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mikpe@it.uu.se, linux-ide@vger.kernel.org

Marko Koivusalo writes:
 > I compiled 2.6.25-rc9 and ran some more tests.
 > 
 > hdparm -t /dev/sdd
 > 
 > /dev/sdd:
 >  Timing buffered disk reads:  228 MB in  3.01 seconds =  75.66 MB/sec
 > 
 > So aparantly read speeds are just fine. However write speeds are still
 > very slow.
 > 
 > dd if=/dev/zero of=1gb bs=1M count=1024
 > 1073741824 bytes (1.1 GB) copied, 107.068 s, 10.0 MB/s

That includes overheads from whatever file system / raid layers
you have on top of the device. Please do the dd straight to
/dev/sdd or /dev/sdd1.

Also, I note that while you have an Intel 845 chipset, your kernel
doesn't mention either the local APIC or the I/O APIC. I would have
expected both to be present; using them typically results in less
IRQ sharing and lower IRQ handling overheads. Might be worthwhile
to try to enable them.

/Mikael
