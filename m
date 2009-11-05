From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Thu, 5 Nov 2009 10:40:18 +0000
Message-ID: <20091105104018.357be391@lxorguk.ukuu.org.uk>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37051 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752840AbZKEKio (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 5 Nov 2009 05:38:44 -0500
In-Reply-To: <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

On Wed, 4 Nov 2009 20:25:21 -0500 (EST)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Hi
> 
> Here is another patch for SSD for VIA UDMA33. Alan, please backport it 
> into libata.

I might consider adding the TS device to the blacklist on libata IFF
- I have the full ID string so I can match device accurately not blanket
  cripple hardware
- I had a much more detailed bug report - eg exact dmesg data up to the
  lock
- I know which exact controller card(s) it occurs on (rather than
  blanket "via")
- If I knew it occurred on libata
- If I knew it wasn't an IDE and/or shared IDE/libata bug or didn't
  appear to be one.

Crippling every other transcend device user on the planet for your
specific report (that nobody else has so far reported to me) would almost
certainly be a regression on a massive scale.

Does your TS device work with other controllers - do you just have a
faulty unit or marginal cabling ?

For any real failure case like this I'd expect a pile of entries in
bugzillas from multiple people. Now it could simply be yours is the first
in which case I'll look at it a blacklist when I see a few more.

Alan
