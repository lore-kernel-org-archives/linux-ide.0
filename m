From: Catalin BOIE <util@deuroconsult.ro>
Subject: Re: dma_timer_expiry on SATA siimage 3112 under 2.6.0-test1-ac1
Date: Fri, 18 Jul 2003 09:22:22 +0300 (EEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.53.0307180919480.19703@hosting.rdsbv.ro>
References: <1058389994.3220.20.camel@daedalus.samhome.net> <bf6nb0$c3$1@main.gmane.org>
 <1058466147.3220.62.camel@daedalus.samhome.net> <bf72m5$2p5$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from webhosting.rdsbv.ro ([213.157.185.164]:12710 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271711AbTGRGH2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jul 2003 02:07:28 -0400
In-Reply-To: <bf72m5$2p5$1@main.gmane.org>
List-Id: linux-ide@vger.kernel.org
To: tea4two <tea4two@tin.it>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> I can't explain why it's work....
> I've made a lot of tries and the only way to work at 50.5 Mb/s (for me) is
> to run: hdparm -d1 -Xudma2 /dev/hde

Same controler here, same crashes if I enable dma.
But I found a solution:
I modified ide-iops.c, function ide_ata66_check to return 0, without
testing the controller registers.
I booted and I issue: hdparm -d1 -u1 -Xudma6 /dev/hda and the speed is
50MB/s, without problems.

---
Catalin(ux) BOIE
catab@deuroconsult.ro
