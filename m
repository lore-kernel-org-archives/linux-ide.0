From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Thu, 5 Nov 2009 22:46:05 +0000
Message-ID: <20091105224605.10583ce8@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
	<200910231644.29919.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
	<20091023175157.3a898525@lxorguk.ukuu.org.uk>
	<4AE1E78A.2090801@ru.mvista.com>
	<20091023192250.600edc9b@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
	<20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
	<20091105104018.357be391@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911051657490.1166@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:32849 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbZKEWoX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2009 17:44:23 -0500
In-Reply-To: <Pine.LNX.4.64.0911051657490.1166@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, Daniela Engert <dani@ngrt.de>

> The device ID string is: TS64GSSD25-M, serial 002328450083, revision V0826
> The south bridge is VIA VT82C586B
> 
> The lockup happens on partition scan, sometimes the scan passes and it 
> locks up when loading init. It doesn't get further.

The Linux driver doesn't set all the time setup strictly but it does set
it to be a safer maximum value. That might be worth checking but it would
still be a device naughty if so.

> The lockup is not dependent on IDE driver. I experienced it with Linux 2.6 
> IDE, Linux 2.6 LIBATA, Daniela's OS/2 DANIS506 driver (Daniela, if you 
> maintain a blacklist, you can add it there too) - switching to MWDMA 
> helped. Linux 2.2 locked up too (it doesn't set transfer mode and relies 
> on BIOS) and disabling UDMA in BIOS cured the problem.

> I tested it in a motherboard with VIA133 IDE and it works there. I think 
> it also worked with that VT6421 card, but I can't test it now because I 
> moved root to that Transcend SSD and it wouldn't boot of that.

Thanks - so basically its a specific card/device combination (or a dud
device you own), that makes it easier as any blacklisting can be very
much narrower.

> 1106 8598 0000 0000 06 04 00 00
>         Bridge - PCI bridge - Normal decode
>         VIA Technologies, Inc. - VT82C598/694x [Apollo MVP3/Pro133x AGP]

Ok so its also a dinosaur which might explain the lack of other reports.


Thanks

Alan
