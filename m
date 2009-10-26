From: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Mon, 26 Oct 2009 07:36:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
 <200910221144.04471.bzolnier@gmail.com> <Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
 <200910231644.29919.bzolnier@gmail.com> <Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
 <20091023175157.3a898525@lxorguk.ukuu.org.uk> <4AE1E78A.2090801@ru.mvista.com>
 <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44372 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715AbZJZLg6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Oct 2009 07:36:58 -0400
In-Reply-To: <20091023192250.600edc9b@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

On Fri, 23 Oct 2009, Alan Cox wrote:

> >     Yeah. The libata driver however doesn't make use of that register, 
> > unlike  cmd64x. It doesn't even touch the interrupt bits on PCI0646, only 
> > manipulation the "old" bits on PCI-64[89].
> 
> Yes I purposefully left out all the complexity because when I tested the
> cards I had it simply wasn't needed. I'm also not sure we should merge
> anything from the old to the new one until we know why the old one
> corrupts and the new one merely gets upset. Accidentally porting over a
> corruptor would be very bad indeed.

Well, if Daniela showed that cmd64[36] docs say it needs serialization, 
then just add it there. Don't rely on the fact that the corruption didn't 
happen in my case.

Mikulas
