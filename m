From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: sata_sil24: swiotlb buffer is full ?
Date: Mon, 31 Oct 2016 15:09:18 -0400
Message-ID: <20161031190918.GE15811@char.us.oracle.com>
References: <8b6da1a2-ca9c-e15a-10a8-f3cda092698c@shaw.ca>
 <20161031161825.GA26364@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:35758 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932404AbcJaTJ0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2016 15:09:26 -0400
Content-Disposition: inline
In-Reply-To: <20161031161825.GA26364@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Ryder <tireman@shaw.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 31, 2016 at 10:18:25AM -0600, Tejun Heo wrote:
> Hello,
> 
> On Sat, Oct 29, 2016 at 11:40:29PM -0400, Andrew Ryder wrote:
> > I have some disks attached to a "Silicon Image, Inc. SiI 3124 PCI-X Serial
> > ATA Controller" and it repeatedly locks up the system with the message
> > whenever there is heavy disk i/o. The system the controller is attached to
> > is a via EPIA-M910 board.
> > 
> > sata_sil24: 0000:06:03.0: swiotlb buffer is full: 65536 bytes)
> > DMA: Out of SW-IOMMU space for 65536 bytes at device .."
> > sata_sil24 0000:06:03.0: swiotlb buffer is full (sz: 65536 bytes .."
> > 
> > For the past week I have been running with two additional boot parameters
> > (iommu=allowdac swiotlb=131072) which seem to have solved the issue, but I
> > was curious if this is a driver bug or not?

Usually it means that the device (sta_sil24) can only handle certain
DMA addresses and hence needs the assistance of the bounce buffers (swiotlb).

Increasing the number of them is the right way to make it work.

I would call this hardware limitation - if you provide the lspci -n -s 06:03.0
one can look in the driver and see where it sets the DMA mask.

> 
> (cc'ing swiotbl maintainer, hi!)
> 
> That looks like iotlb area running out.  I don't think there's much to
> be done from driver side and we've traditionally been pretty bad at
> handling iotlb errors.  Konrad, do you have any ideas?
> 
> Thanks.
> 
> -- 
> tejun
