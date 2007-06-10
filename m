From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-core/sff: Fix multiple assumptions about DMA
Date: Sat, 09 Jun 2007 22:43:47 -0400
Message-ID: <466B6563.9030107@garzik.org>
References: <20070607161915.2dbe3511@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35879 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761294AbXFJCnu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 9 Jun 2007 22:43:50 -0400
In-Reply-To: <20070607161915.2dbe3511@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> The ata IRQ ack functions are only used when debugging. Unfortunately
> almost every controller that calls them can cause crashes in some
> configurations as there are missing checks for bmdma presence.
> 
> In addition ata_port_start insists of installing DMA buffers and pad
> buffers for controllers regardless. The SFF controllers actually need to
> make that decision dynamically at controller setup time and all need the
> same helper - so we add ata_sff_port_start. Future patches will switch
> the SFF drivers to use this.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied to #upstream-fixes


