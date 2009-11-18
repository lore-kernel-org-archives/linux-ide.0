From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 12:37:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911181224280.5068@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
 <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
 <20091117.043002.224755438.davem@davemloft.net>
 <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
 <20091118172258.59894130@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758039AbZKRRh4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Nov 2009 12:37:56 -0500
In-Reply-To: <20091118172258.59894130@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

> > Transcend makes various versions of their SSDs and all begin with TS. You 
> > can assume that Transcend SSDs with different capacity or format won't 
> > work too because they likely use the same controller. The naming is this:
> 
> You don't want to assume that because then you will never find out if
> there is no problem.

I can be certain that no company would be stupid enough to design a 
separate controller for each capacity and form factor of their devices. 
They use one or a very few chips.

Furthemore, even if they upgrade the chip and produce 64G 2.5" MLC device 
with the new working chip, you can't tell it from the ID string at all.

> > So the problem is that if you match against the full string, you are going 
> > to miss the other Transcend devices and the patch becomes quite useless.
> 
> Quite the reverse. It's not implausible that only one or two devices are
> affected, but match TS SSD is going to match zillions of devices of many
> generations for years to come. Thats not good.

Why no good? People just get lower performance (on an old motherboard, 
where no one expects high performance anyway).

On the other hand, if you miss a device from the blacklist, people get 
crashes.

Crashes are worse than lower performance.

> Experience is also that very few of the existing blacklist entries we
> have grow to be large scale wildcards.

Mikulas
