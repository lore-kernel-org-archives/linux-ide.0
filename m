From: Sander <sander@humilis.net>
Subject: Re: [PATCH] 2.6.xx: sata_mv: another critical fix
Date: Tue, 21 Mar 2006 13:13:54 +0100
Message-ID: <20060321121354.GB24977@favonius>
References: <441F4F95.4070203@garzik.org> <200603210000.36552.lkml@rtr.ca>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ookhoi.xs4all.nl ([213.84.114.66]:19080 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S1751507AbWCUMN6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 07:13:58 -0500
Content-Disposition: inline
In-Reply-To: <200603210000.36552.lkml@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote (ao):
> This patch addresses a number of weird behaviours observed
> for the sata_mv driver, by fixing an "off by one" bug in processing
> of the EDMA response queue.
> 
> Basically, sata_mv was looking in the wrong place for
> command results, and this produced a lot of unpredictable behaviour.

2.6.16 with this patch and your former patch applied, crashes during
stressing a raid5 connected to a MV88SX6081.

2.6.16-rc6 crashes too.

2.6.16-rc6-mm2 is rock solid wrt sata_mv.

I get no output of the crash on netconsole. Would it help if I get the
output of the crash (if any)? In that case I'll connect a screen and see
what it produces.

I'll test 2.6.16-rc6-mm2 with your patches now.

I'll also try 2.6.16-rc6-mm1 to see if it is fixed between -rc6 and
-rc6-mm1, or between -rc6-mm1 and -rc6-mm2.

As soon as 2.6.16-mm1 comes out, I'll check to see if sata_mv still
works for me. Whatever fixes it should stay in :-)

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
