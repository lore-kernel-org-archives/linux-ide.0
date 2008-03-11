From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] devres: implement pcim_iomap_regions_request_all()
Date: Tue, 11 Mar 2008 11:18:35 -0700
Message-ID: <20080311181835.GA27567@kroah.com>
References: <47D6643A.6060001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58068 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbYCKTyg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 15:54:36 -0400
Content-Disposition: inline
In-Reply-To: <47D6643A.6060001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tue, Mar 11, 2008 at 07:51:38PM +0900, Tejun Heo wrote:
> Some drivers need to reserve all PCI BARs to prevent other drivers
> misusing unoccupied BARs.  pcim_iomap_regions_request_all() requests
> all BARs and iomap specified BARs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> ---
> After acked, it's probably best to push this through libata-dev as
> that's the only user for now.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

Feel free to push this through the libata-dev tree.

thanks,

greg k-h
