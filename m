From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [sata] new driver -- AHCI
Date: Wed, 28 Apr 2004 23:17:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <409073B1.1020901@pobox.com>
References: <408C1F41.3060206@pobox.com> <40905997.9020107@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263041AbUD2DRS
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 28 Apr 2004 23:17:18 -0400
In-Reply-To: <40905997.9020107@tomt.net>
List-Id: linux-ide@vger.kernel.org
To: Andre Tomt <andre@tomt.net>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Andre Tomt wrote:
> Jeff Garzik wrote:
> 
>> So kudos to the AHCI folks (mainly at Intel), for making a decent, 
>> open controller.  I always prefer to work on drivers for decent 
>> hardware, whose hardware specification is open and public.
> 
> 
> Quick questions:
> 
> Is the Intel 6300ESB ("Hence Rapids") AHCI based? So far this looks like 
> ICH6 too me, but I may be mistaken.

The only Hance Rapids stuff I've seen was ICH5-R, but maybe it's carried 
forward to the ICH6-R as well.

I don't know, I mainly know the underlying chipsets not the boards they 
wind up being shipped on...


> What about the Marvell 88SX5040 PCI-X SATA Controller?

Coming RSN.  That's my next priority, but I'm not as thrilled because 
Marvell isn't an open design like AHCI.  I'm much more happy to promote 
AHCI's sane, open design.

	Jeff



