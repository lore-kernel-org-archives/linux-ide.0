From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Fri, 07 Sep 2007 12:58:46 +0900
Message-ID: <46E0CC76.70101@gmail.com>
References: <20070822233710.415faaf0@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:45340 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbXIGD6y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Sep 2007 23:58:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so322413rvb
        for <linux-ide@vger.kernel.org>; Thu, 06 Sep 2007 20:58:54 -0700 (PDT)
In-Reply-To: <20070822233710.415faaf0@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
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
> (I've split CF as it seems to be a seperate case of pain and suffering
> different to the others and caused by assorted PIO wired adapters etc)
> 
> SATA is not affected - for one its not clear it makes sense to disable
> DMA for SATA if even always possible, for two we've seen no failure 
> evidence to justify needing to support this kind of hammer on SATA.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
