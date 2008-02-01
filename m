From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pci: allow multiple calls to pcim_enable_device()
Date: Fri, 01 Feb 2008 12:20:29 -0500
Message-ID: <47A354DD.3010003@garzik.org>
References: <47A04144.3070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41706 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbYBARUc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 12:20:32 -0500
In-Reply-To: <47A04144.3070106@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
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
> 
> Thanks.
> 
>  drivers/pci/pci.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

applied, w/ greg's sign-off


