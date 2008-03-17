From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH UPDATED] devres: implement pcim_iomap_regions_request_all()
Date: Mon, 17 Mar 2008 08:27:16 -0400
Message-ID: <47DE63A4.6070709@garzik.org>
References: <47D6643A.6060001@gmail.com> <20080311230825.fd631e29.akpm@linux-foundation.org> <47D7779A.3070005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47609 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbYCQM1T (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Mar 2008 08:27:19 -0400
In-Reply-To: <47D7779A.3070005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Some drivers need to reserve all PCI BARs to prevent other drivers
> misusing unoccupied BARs.  pcim_iomap_regions_request_all() requests
> all BARs and iomap specified BARs.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Jeff Garzik <jeff@garzik.org>
> ---
> Aieee...  Sorry Andrew.  I forgot doing "quilt add" on the file and
> subsequently missed that pci.h was modified while gitting the repo.
> 
> Here's the corrected version.
> 
>  include/linux/pci.h |    2 ++
>  lib/devres.c        |   25 +++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)

applied


