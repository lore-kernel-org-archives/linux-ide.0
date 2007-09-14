From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Fri, 14 Sep 2007 21:54:10 +0200
Message-ID: <200709142154.10607.bzolnier@gmail.com>
References: <20070822233710.415faaf0@the-village.bc.nu> <46E1D4FB.8030409@garzik.org> <46EAC225.70003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:15918 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024AbXINTvM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2007 15:51:12 -0400
Received: by wr-out-0506.google.com with SMTP id 36so552392wra
        for <linux-ide@vger.kernel.org>; Fri, 14 Sep 2007 12:51:11 -0700 (PDT)
In-Reply-To: <46EAC225.70003@redhat.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, linux-ide@vger.kernel.org

On Friday 14 September 2007, Chuck Ebbert wrote:
> On 09/07/2007 06:47 PM, Jeff Garzik wrote:
> >>> This is useful when debugging, handling problem systems, or for
> >>> distributions just to get the system installed so it can be sorted
> >>> out later.
> >>>
> >>> This is a bit smarter than the old IDE one and lets you do
> >>>
> >>> libata.pata_dma=0        Disable all PATA DMA like old IDE

2.6.24 will have "hdx=nodma"

> >>> libata.pata_dma=1        Disk DMA only
> >>> libata.pata_dma=2        ATAPI DMA only
> >>> libata.pata_dma=4        CF DMA only
> >>>
> > 
> > FWIW -- as I noted to Alan personally at KS, I would rather drop the
> > "pata_" and have it apply to all, PATA or SATA.
> > 
> 
> Not sure that's a good idea for people who need to use it as a workaround.
> E.g. they might have DMA working on some SATA devices but not on PATA, and
> only want to disable the PATA DMA. Either adding a separate "sata_dma" or
> additional bitfields for SATA would be useful.
