From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 13:02:33 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0911181254260.20509@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
 <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
 <20091117.043002.224755438.davem@davemloft.net>
 <Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
 <20091118172258.59894130@lxorguk.ukuu.org.uk>
 <Pine.LNX.4.64.0911181224280.5068@hs20-bc2-1.build.redhat.com>
 <20091118175059.22c8ae87@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40542 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758007AbZKRSCg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Nov 2009 13:02:36 -0500
In-Reply-To: <20091118175059.22c8ae87@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

On Wed, 18 Nov 2009, Alan Cox wrote:

> > I can be certain that no company would be stupid enough to design a 
> > separate controller for each capacity and form factor of their devices. 
> > They use one or a very few chips.
> 
> But they do fix the firmware, and you see that with hard disks as well.

So match it against a firmware revision (V0826 in my case, so blacklist 
all lower).

Anyway, I think it is bug on the motherboard because similar lockups can 
be seen with one WD 40G disk operating at UDMA0 or UDMA1 (UDMA2 is OK). 
And if this is old buggy motherboard, Transcend will fix nothing.

> > Why no good? People just get lower performance (on an old motherboard, 
> > where no one expects high performance anyway).
> 
> Which they don't notice or report

If they don't notice it, it is not a problem :)

Mikulas
