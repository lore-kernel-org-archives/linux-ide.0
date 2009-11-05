From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Thu, 5 Nov 2009 18:19:39 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911051802160.1166@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910221144.04471.bzolnier@gmail.com> <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
 <200910231644.29919.bzolnier@gmail.com> <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
 <20091023175157.3a898525@lxorguk.ukuu.org.uk> <4AE1E78A.2090801@ru.mvista.com>
 <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
 <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
 <20091105104018.357be391@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911051657490.1166@hs20-bc2-1.build.redhat.com>
 <20091105224605.10583ce8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5140 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752684AbZKEXTo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 5 Nov 2009 18:19:44 -0500
In-Reply-To: <20091105224605.10583ce8@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, Daniela Engert <dani@ngrt.de>



On Thu, 5 Nov 2009, Alan Cox wrote:

> > The device ID string is: TS64GSSD25-M, serial 002328450083, revision V0826
> > The south bridge is VIA VT82C586B
> > 
> > The lockup happens on partition scan, sometimes the scan passes and it 
> > locks up when loading init. It doesn't get further.
> 
> The Linux driver doesn't set all the time setup strictly but it does set
> it to be a safer maximum value. That might be worth checking but it would
> still be a device naughty if so.

I tried UDMA 0 and 1 and no help. I didn't try to fiddle the timing 
register manually. You mean, try set the disk to UDMA 2 and set the 
register to a lower timing? Or the other way? I can try ...

Mikulas
