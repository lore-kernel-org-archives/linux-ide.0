From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Don't use UDMA on VIA UDMA33 controller with Transcend
 SSD
Date: Wed, 18 Nov 2009 17:50:59 +0000
Message-ID: <20091118175059.22c8ae87@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
	<20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911042021530.19963@hs20-bc2-1.build.redhat.com>
	<20091117.043002.224755438.davem@davemloft.net>
	<Pine.LNX.4.64.0911181151140.5068@hs20-bc2-1.build.redhat.com>
	<20091118172258.59894130@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0911181224280.5068@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41174 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757836AbZKRRtT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Nov 2009 12:49:19 -0500
In-Reply-To: <Pine.LNX.4.64.0911181224280.5068@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org

> I can be certain that no company would be stupid enough to design a 
> separate controller for each capacity and form factor of their devices. 
> They use one or a very few chips.

But they do fix the firmware, and you see that with hard disks as well.

> Why no good? People just get lower performance (on an old motherboard, 
> where no one expects high performance anyway).

Which they don't notice or report
> 
> On the other hand, if you miss a device from the blacklist, people get 
> crashes.

Which they do notice or report (and in the meantime can boot with
libata.dma=0 or one of the MWDMA settings).

> Crashes are worse than lower performance.

Not always. Inflicting poor performance (and also *much* lower data
integrity) on people isn't a good idea in this case IMHO. That's based
upon experience with disks and what gets fixed.
