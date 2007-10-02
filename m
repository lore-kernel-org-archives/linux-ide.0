From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [regression] 2.6.23 sata_mv EH updates broke my 7042 controller
Date: Tue, 02 Oct 2007 19:23:10 -0400
Message-ID: <4702D2DE.1050504@pobox.com>
References: <20071001220439.GA15332@lixom.net> <470176B8.1000109@pobox.com> <20071002023000.GA19286@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbXJBXXN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Oct 2007 19:23:13 -0400
In-Reply-To: <20071002023000.GA19286@lixom.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Olof Johansson wrote:
> On Mon, Oct 01, 2007 at 06:37:44PM -0400, Jeff Garzik wrote:
>> Olof Johansson wrote:
>>> Hardware config in my case:
>>> Highpoint 2310 controller
>>> PPC (big endian)
>>> WD Raptor disk
>>> Works fine with the other controller I've been using (SIL24), and works
>>> fine if I revert the driver.
>>> It also works fine if I disable the IOMMU. This would point towards
>>> either a stale dma mapping, or a missing setup of one.
>>> Not being much at home in the SATA drivers I could keep digging but I
>>> figured I'd bring it up first in case it rings a bell for someone.
>> The IOMMU data point is certainly interesting.  Nothing jumps out on a 
>> re-review of the patch, so keep digging and let us know ;-)
> 
> Looks like it's caused by enabling vmerge (which tends to be on for the
> common PPC defconfigs). If I disable it, things look OK.
> 
> Perhaps the Marvell controller doesn't like requests larger than 64K,
> or wrapping some boundary. Do you have access to erratas/docs?
> 
> I have verified it on a powermac now as well (had a quick scare that it
> might have been some problem with the PA Semi IOMMU, but no).

FWIW:  I just tried the 6042 on my AMD64 platform with iommu=force, and 
was unable to reproduce any trouble.

You could try changing MV_DMA_BOUNDARY to 0xffffU and see what happens.

I'll also look through my errata, to see what is different between 6042 
and 7042, if anything.

	Jeff


