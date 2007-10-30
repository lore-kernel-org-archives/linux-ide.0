From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata/pata_it821x: Improve handling of poorly
 compatible emulations
Date: Tue, 30 Oct 2007 13:33:50 +0000
Message-ID: <20071030133350.687a5360@the-village.bc.nu>
References: <20071025142116.7e38ee86@the-village.bc.nu>
	<47273128.4090406@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40769 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbXJ3NcG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 09:32:06 -0400
In-Reply-To: <47273128.4090406@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

> > The other IT821x change is a bit ugly, we slightly abuse the cable type
> > hook to fiddle with the identify data for the devices. We could add a new
> > hook for this but as we have only one offender and no more seeming likely
> > it seems better to keep libata-core clean.
> > 
> > Please let this sit in -mm briefly, just in case the relaxed checking
> > breaks some other emulated interface.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> Two questions:
> 
> 1) should I queue for 2.6.24-rc?

Can we leave it once cycle in -mm and aim for 2.6.25-rc. There is a tiny
possibility we will find someone who finds slave returning 0 produces a
ghost drive or decode problem. Probably paranoia.

> 2) why is ->dev_config() insufficient?

It is called (I think correctly) after we have performed identify
dependant actions including HPA sizing.

Alan
