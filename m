From: Daniel Drake <dsd@gentoo.org>
Subject: "dma_timer_expiry: dma status == 0x64" messages under system load
Date: Thu,  2 Sep 2004 15:27:51 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1094135271.41372de7b500d@dsd.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:39730 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S268288AbUIBODA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Sep 2004 10:03:00 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org

Hi,

I'm investigating a problem relating to decreased system responsiveness when
under IDE load. The following messages appear in dmesg multiple times:

hdb: dma_timer_expiry: dma status == 0x64
hdb: DMA interrupt recovery
hdb: lost interrupt

It seems that a patch written by yourself in May 2003 solves the problem:
http://www.cs.helsinki.fi/linux/linux-kernel/2003-19/1192.html
... but it is not present in the current kernel.

What is the fate of this patch?

For more info see:
http://bugs.gentoo.org/show_bug.cgi?id=59751
http://forums.gentoo.org/viewtopic.php?p=1417524

Thanks,
Daniel
