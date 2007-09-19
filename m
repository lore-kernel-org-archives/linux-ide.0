From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Wed, 19 Sep 2007 11:53:05 -0400
Message-ID: <46F145E1.1050107@redhat.com>
References: <20070822233710.415faaf0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:35749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761347AbXISPxU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Sep 2007 11:53:20 -0400
In-Reply-To: <20070822233710.415faaf0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

On 08/22/2007 06:37 PM, Alan Cox wrote:
> This is useful when debugging, handling problem systems, or for
> distributions just to get the system installed so it can be sorted
> out later.
> 
> This is a bit smarter than the old IDE one and lets you do
> 
> libata.pata_dma=0		Disable all PATA DMA like old IDE
> libata.pata_dma=1		Disk DMA only
> libata.pata_dma=2		ATAPI DMA only
> libata.pata_dma=4		CF DMA only
> 
> (or combinations thereof - 0,1,3 being the useful ones I suspect)
> 

This doesn't help distro installers with modular libata, as there's
no good way to get the parameter to the driver. (libata.pata_dma=0
just causes "unrecognized parameter" message on boot.)
