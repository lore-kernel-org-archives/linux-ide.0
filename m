From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: claim ctl port for legacy SFF ports
Date: Fri, 8 Jun 2007 09:55:17 -0400
Message-ID: <20070608135517.GA24346@havoc.gtf.org>
References: <20070604235157.GD31462@havoc.gtf.org> <20070608114119.GE29122@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:57145 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966904AbXFHNzT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 8 Jun 2007 09:55:19 -0400
Content-Disposition: inline
In-Reply-To: <20070608114119.GE29122@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Fri, Jun 08, 2007 at 08:41:19PM +0900, Tejun Heo wrote:
> libata used to claim only cmd ports for legacy SFF ports.  Claim ctl
> ports too.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This has been this way as long as I can remember.  It's almost
> pleasant to see that it survived through all the devres/init rework.
> I guess it's time for a change.

pci_request_regions() should claims everything, if Alan did his job :)

All this goes through ata_pci_init_one(), which guarantees it's PCI IDE.

	Jeff


