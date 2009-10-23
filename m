From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Fri, 23 Oct 2009 19:22:50 +0100
Message-ID: <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
	<200910231644.29919.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
	<20091023175157.3a898525@lxorguk.ukuu.org.uk>
	<4AE1E78A.2090801@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60569 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751480AbZJWSWR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 14:22:17 -0400
In-Reply-To: <4AE1E78A.2090801@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

>     Yeah. The libata driver however doesn't make use of that register, 
> unlike  cmd64x. It doesn't even touch the interrupt bits on PCI0646, only 
> manipulation the "old" bits on PCI-64[89].

Yes I purposefully left out all the complexity because when I tested the
cards I had it simply wasn't needed. I'm also not sure we should merge
anything from the old to the new one until we know why the old one
corrupts and the new one merely gets upset. Accidentally porting over a
corruptor would be very bad indeed.

>     It seems that I need to sync up these two, pata_cmd64x.c seems to be 
> lagging behind the changes in cmd64x.c. Well, not only this one, at least 
> pata_hpt* drivers are lagging behind too...

That would be useful - although several of the differences are because
the pata_hpt driver took from the vendor supplied reference code not the
old IDE code. It also seems more stable for having done that.

Alan
