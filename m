From: Tejun Heo <tj@kernel.org>
Subject: Re: SATA II NCQ and multi-port add-on card (PCI or PCIe x1)
Date: Thu, 30 Jul 2009 14:05:38 +0900
Message-ID: <4A712A22.6030708@kernel.org>
References: <0KNK00628MWA08Z1@vms173005.mailsrvcs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44493 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbZG3FD3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jul 2009 01:03:29 -0400
In-Reply-To: <0KNK00628MWA08Z1@vms173005.mailsrvcs.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: dhdurgee@verizon.net
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Hello,

dhdurgee@verizon.net wrote:
>> JMB360 is an ahci controller.  ahci PMP support upto ahci1.1 doesn't
>> support FIS-based switching and performance is likely quite lower than
>> sil3132.
> 
> In that case I think I can leave JMB360 out of my plans.

Well, intel ahcis don't support FIS based switching yet either.

> In addition to the SiI3132 chipset I am also seeing cards with the SiI3531
> chipset.  I see one of these for $12 shipped to me, so it certainly is
> reasonably priced!  Is this a good alternative to the SiI3132, or are
> there better alternatives?
> 
> As noted in my subject, I am now seeking an add-on card and have only PCI
> and PCIe-x1 slots available to place it in.  I am open for any
> recommendations of particular chipsets and cards.  The ARC-5020 can
> support SiI, Intel, Nvidia and Marvell NCQ methods, so I am flexible in
> that area.
> 
> Thanks in advance for any assistance you can provide me in this area.

I know sil3132 generally works well although it's quirky at times and
has bandwidth limitation.  Mark, how well do marvell chips preform?
Do they have performance limitations like 3132s?

Thanks.

-- 
tejun
