From: Craig Metz <cmetz@inner.net>
Subject: Re: Linux libata, Sil3124, and SATA staggered spin-up support
Date: Wed, 11 Apr 2007 09:53:46 -0400
Message-ID: <20070411135346.BB560582C@rmail.inner.net>
References: <20070331162941.93F61582C@rmail.inner.net> <461C9AB2.9070807@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rmail.inner.net ([199.33.248.12]:4279 "EHLO rmail.inner.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbXDKNmd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Apr 2007 09:42:33 -0400
In-reply-to: <461C9AB2.9070807@gmail.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

In message <461C9AB2.9070807@gmail.com>, you write:
>Yeah, the silicon can do staggered spin up.  SATA disks shouldn't spin
>up till PHY gets reset.  libata currently probes each port serially, so
>it should sequentially spin up each drive.  Or do they spin up during
>controller initialization?

  On a cold boot, if I disable the BIOS, all of the drives begin their spin up
at once (or so close to not be staggered). It appears to be happenning in
sil24_init_controller(), where it loops through all ports and resets the PHYs.

  So it appears that the control flow there would need to be changed so that
we go all the way to having libata identify port 1 before we go back and
initialize the PHY for port 2.

  If I put all the drives into suspend mode (hdparm -z) and warm reboot, the
drives are spun up in libata's ata_device_add(). In the second loop, the
drives are all spun up, then in the third loop they're identified. In this
case a simple change to combine loops 2 ("probe begin") & 3 ("host probe
begin") in order that they happen more serially seemed to cause a resonable
staggerring behavior to happen. On my drives, the identify commands seemed to
complete a bit before the drives were finished spinning up, so there was still
some overlap in power draw, but over a large population of drives this
shouldn't be a big deal.

  I don't have any port multipliers handy to play with, but I expect that they
make this problem a bit more complex and require some thinking about.

									-Craig
