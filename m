From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] pci: allow multiple calls to pcim_enable_device()
Date: Wed, 30 Jan 2008 19:58:00 -0800
Message-ID: <20080131035800.GA11513@kroah.com>
References: <47A04144.3070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34894 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbYAaHwW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 02:52:22 -0500
Content-Disposition: inline
In-Reply-To: <47A04144.3070106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, IDE/ATA development list <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

On Wed, Jan 30, 2008 at 06:20:04PM +0900, Tejun Heo wrote:
> There's no reason not to allow multiple calls to pcim_enable_device().
> Calls after the first one can simply be noop.  All PCI resources will
> be released when the initial pcim_enable_device() resource is
> released.
> 
> This allows more flexibility to managed PCI users.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> This will be used to fix some libata issues.  After Greg's ACK, would
> it be okay to push this through libata-dev#upstream?

That's fine with me, please add:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

To the patch if you want to send it through the ata tree.

thanks,

greg k-h
