From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 17:22:58 +0000
Message-ID: <20091118172258.59894130@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
	<20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
	<20091117.043002.224755438.davem@davemloft.net>
	<Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60333 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757679AbZKRRVU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 12:21:20 -0500
In-Reply-To: <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

> Transcend makes various versions of their SSDs and all begin with TS. You 
> can assume that Transcend SSDs with different capacity or format won't 
> work too because they likely use the same controller. The naming is this:

You don't want to assume that because then you will never find out if
there is no problem.

> So the problem is that if you match against the full string, you are going 
> to miss the other Transcend devices and the patch becomes quite useless.

Quite the reverse. It's not implausible that only one or two devices are
affected, but match TS SSD is going to match zillions of devices of many
generations for years to come. Thats not good.

Experience is also that very few of the existing blacklist entries we
have grow to be large scale wildcards.
