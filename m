From: Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: [PATCH] speed up SATA
Date: Sun, 28 Mar 2004 20:52:39 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40672D07.2060201@vgertech.com>
References: <4066021A.20308@pobox.com> <20040328175436.GL24370@suse.de> <20040328181223.GA791@holomorphy.com> <200403282030.11743.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-b3-74-209.telepac.pt ([213.13.74.209]:18311 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S262399AbUC1Twf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 28 Mar 2004 14:52:35 -0500
In-Reply-To: <200403282030.11743.bzolnier@elka.pw.edu.pl>
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: William Lee Irwin III <wli@holomorphy.com>, Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bartlomiej Zolnierkiewicz wrote:
| On Sunday 28 of March 2004 20:12, William Lee Irwin III wrote:
|
|>On Sun, Mar 28, 2004 at 07:54:36PM +0200, Jens Axboe wrote:
|>

[...]

|>>hardware. I absolutely refuse to put a global block layer 'optimal io
|>>size' restriction in, since that is the ugliest of policies and without
|>>having _any_ knowledge of what the hardware can do.
|>
|>How about per-device policies and driver hints wrt. optimal io?
|
|
| Yep, user-tunable per-device policies with sane driver defaults.
|

I think that automagic configuration for the common workload with some
way (sysfs|proc) to retrieve and set policies is the way to go.

With this kind of control we could have /etc/init.d/io-optimize that
paused the startup for 10 seconds and tests every device|controller in
fstab and optimizes according to the .conf file for latency or speed...
Or a daemon that retrieves statistics and adjusts the policies every minute?

Also, everybody says "do it in userland". This is doing (some of) it in
userland :)

Regards,
Nuno Silva


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAZy0GOPig54MP17wRAmWMAKDT3GKF/Wp/yYDzxyX+YK9kkTuMFgCg5mD3
HlngYjEwzo/lRAfHn/tnsQg=
=bC9f
-----END PGP SIGNATURE-----
