From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Serialize CMD643 and CMD646 to fix a hardware bug with
 SSD
Date: Mon, 26 Oct 2009 12:18:04 +0000
Message-ID: <20091026121804.3789c4c0@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.64.0910211452160.17897@hs20-bc2-1.build.redhat.com>
	<200910221144.04471.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231024240.324@hs20-bc2-1.build.redhat.com>
	<200910231644.29919.bzolnier@gmail.com>
	<Pine.LNX.4.64.0910231050330.3007@hs20-bc2-1.build.redhat.com>
	<20091023175157.3a898525@lxorguk.ukuu.org.uk>
	<4AE1E78A.2090801@ru.mvista.com>
	<20091023192250.600edc9b@lxorguk.ukuu.org.uk>
	<Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39186 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755876AbZJZMRB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Oct 2009 08:17:01 -0400
In-Reply-To: <Pine.LNX.4.64.0910260731460.21316@hs20-bc2-1.build.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, David Miller <davem@davemloft.net>, linux-ide@vger.kernel.org, elendil@planet.nl

On Mon, 26 Oct 2009 07:36:48 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Fri, 23 Oct 2009, Alan Cox wrote:
> 
> > >     Yeah. The libata driver however doesn't make use of that register, 
> > > unlike  cmd64x. It doesn't even touch the interrupt bits on PCI0646, only 
> > > manipulation the "old" bits on PCI-64[89].
> > 
> > Yes I purposefully left out all the complexity because when I tested the
> > cards I had it simply wasn't needed. I'm also not sure we should merge
> > anything from the old to the new one until we know why the old one
> > corrupts and the new one merely gets upset. Accidentally porting over a
> > corruptor would be very bad indeed.
> 
> Well, if Daniela showed that cmd64[36] docs say it needs serialization, 
> then just add it there. Don't rely on the fact that the corruption didn't 
> happen in my case.

Daniela sent me the relevant document - it doesn't exactly match what is
being described here as it relates to motherboards improperly timing out
PCI access requests.

Basically the fix is "don't touch the task file on one channel while DMA
is live on the other". That means that for libata serialize is not
sufficient on a shared IRQ set up as we'll touch ALTSTATUS. Plus it is
overkill as you can have parallel issue PIO commands.

For libata the best way to fix it seems to be to avoid parallel issuing
commands with an ATA_PROT_DMA/ATAPI_PROT_DMA command outstanding, and to
check the IRQ bits. Patch to follow when I get a moment.
