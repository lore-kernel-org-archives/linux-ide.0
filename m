From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: sil680 MMIO changes moved to branch
Date: Fri, 25 May 2007 14:11:52 +1000
Message-ID: <1180066312.32247.1098.camel@localhost.localdomain>
References: <4656591A.6090701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47099 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXEYEMA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 May 2007 00:12:00 -0400
In-Reply-To: <4656591A.6090701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan <alan@lxorguk.ukuu.org.uk>

On Thu, 2007-05-24 at 23:33 -0400, Jeff Garzik wrote:
> I moved the sil680 MMIO changes from 'upstream' (queued for 2.6.23) to
> a 
> side branch 'sil680-mmio'.
> 
> To be clear, I am still quite interested in the patch (w/ the reset 
> fix), but I did not want to delay other unrelated stuff that was
> about 
> to be queued into #upstream.
> 
> The patch will still appear in -mm, and it is trivial to pull it from 
> #sil680-mmio into #upstream once people are happy. 

Fine with me. I've been busy with other things and waiting for you and
Alan to decide what should be done for the reset stuff anway :-)

So Alan, do you think we should add something or do you think that just
reading altstat like ata_pause does is good enough ?

Cheers,
Ben.


