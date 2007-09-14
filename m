From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Fri, 14 Sep 2007 13:17:25 -0400
Message-ID: <46EAC225.70003@redhat.com>
References: <20070822233710.415faaf0@the-village.bc.nu> <46E0CC76.70101@gmail.com> <46E1D4FB.8030409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:59773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbXINRRg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Sep 2007 13:17:36 -0400
In-Reply-To: <46E1D4FB.8030409@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org

On 09/07/2007 06:47 PM, Jeff Garzik wrote:
>>> This is useful when debugging, handling problem systems, or for
>>> distributions just to get the system installed so it can be sorted
>>> out later.
>>>
>>> This is a bit smarter than the old IDE one and lets you do
>>>
>>> libata.pata_dma=0        Disable all PATA DMA like old IDE
>>> libata.pata_dma=1        Disk DMA only
>>> libata.pata_dma=2        ATAPI DMA only
>>> libata.pata_dma=4        CF DMA only
>>>
> 
> FWIW -- as I noted to Alan personally at KS, I would rather drop the
> "pata_" and have it apply to all, PATA or SATA.
> 

Not sure that's a good idea for people who need to use it as a workaround.
E.g. they might have DMA working on some SATA devices but not on PATA, and
only want to disable the PATA DMA. Either adding a separate "sata_dma" or
additional bitfields for SATA would be useful.
