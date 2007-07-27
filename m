From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] pci: rename __pci_reenable_device() to
	pci_reenable_device()
Date: Thu, 26 Jul 2007 23:22:09 -0700
Message-ID: <20070727062209.GA4040@kroah.com>
References: <20070710063605.GA21994@htj.dyndns.org> <20070710065543.GA23568@htj.dyndns.org> <46A66842.6040803@garzik.org> <20070724225747.1dd4d141@the-village.bc.nu> <46A677C3.9090107@garzik.org> <46A98607.7000401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:35053 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758420AbXG0GYw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2007 02:24:52 -0400
Content-Disposition: inline
In-Reply-To: <46A98607.7000401@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, owner-linux-pci@atrey.karlin.mff.cuni.cz

On Fri, Jul 27, 2007 at 02:43:35PM +0900, Tejun Heo wrote:
> Rename __pci_reenable_device() to pci_reenable_device().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> Jeff, Greg wanted to drop the preceding underscores before exporting
> the function and the updated patch was posted but the earlier version
> was applied.  This patch renames the function.

Yeah, that is nicer :)

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


thanks,

greg k-h
