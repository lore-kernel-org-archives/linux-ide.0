From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: fix ATAPI issues with memory over 4GB (v7)
Date: Wed, 06 Feb 2008 07:04:14 -0500
Message-ID: <47A9A23E.5060006@garzik.org>
References: <47A7BE36.1010902@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40543 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761876AbYBFMER (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 07:04:17 -0500
In-Reply-To: <47A7BE36.1010902@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Robert Hancock wrote:
> This fixes some problems with ATAPI devices on nForce4 controllers in ADMA mode
> on systems with memory located above 4GB. We need to delay setting the 64-bit
> DMA mask until the PRD table and padding buffer are allocated so that they don't
> get allocated above 4GB and break legacy mode (which is needed for ATAPI
> devices). Also, if either port is in ATAPI mode we need to set the DMA mask
> for the PCI device to 32-bit to ensure that the IOMMU code properly bounces
> requests above 4GB, as it appears setting the bounce limit does not guarantee
> that we will not try to map requests above this point.
> 
> Reported to fix https://bugzilla.redhat.com/show_bug.cgi?id=351451
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied, though it can still be improved...  let's see if this sticks.


