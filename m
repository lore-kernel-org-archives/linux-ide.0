From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil24: swiotlb buffer is full ?
Date: Mon, 31 Oct 2016 10:18:25 -0600
Message-ID: <20161031161825.GA26364@mtj.duckdns.org>
References: <8b6da1a2-ca9c-e15a-10a8-f3cda092698c@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33101 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933675AbcJaQS2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2016 12:18:28 -0400
Content-Disposition: inline
In-Reply-To: <8b6da1a2-ca9c-e15a-10a8-f3cda092698c@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Ryder <tireman@shaw.ca>
Cc: linux-ide@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org

Hello,

On Sat, Oct 29, 2016 at 11:40:29PM -0400, Andrew Ryder wrote:
> I have some disks attached to a "Silicon Image, Inc. SiI 3124 PCI-X Serial
> ATA Controller" and it repeatedly locks up the system with the message
> whenever there is heavy disk i/o. The system the controller is attached to
> is a via EPIA-M910 board.
> 
> sata_sil24: 0000:06:03.0: swiotlb buffer is full: 65536 bytes)
> DMA: Out of SW-IOMMU space for 65536 bytes at device .."
> sata_sil24 0000:06:03.0: swiotlb buffer is full (sz: 65536 bytes .."
> 
> For the past week I have been running with two additional boot parameters
> (iommu=allowdac swiotlb=131072) which seem to have solved the issue, but I
> was curious if this is a driver bug or not?

(cc'ing swiotbl maintainer, hi!)

That looks like iotlb area running out.  I don't think there's much to
be done from driver side and we've traditionally been pretty bad at
handling iotlb errors.  Konrad, do you have any ideas?

Thanks.

-- 
tejun
