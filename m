From: Luke Ross <luke@lukeross.name>
Subject: Re: [PATCH #upstream-fixes 2/2] libata: implement
	ATAPI_HORKAGE_NOPIO and apply it to GGW-H10N
Date: Wed, 18 Jun 2008 07:48:28 -0400
Message-ID: <20080618114828.GB19903@lukeross.name>
References: <4857313A.1000405@kernel.org> <48573174.9050103@kernel.org> <20080617094354.338e186b@lxorguk.ukuu.org.uk> <48578080.5030605@kernel.org> <20080617095439.GA9359@lukeross.name> <20080617110450.668f37e2@lxorguk.ukuu.org.uk> <4857ADC3.3040106@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ziller.vpsland.com ([64.22.91.115]:35571 "EHLO
	ziller.vpsland.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbYFRLsq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 07:48:46 -0400
In-Reply-To: <4857ADC3.3040106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On Tue, Jun 17, 2008 at 09:27:47PM +0900, Tejun Heo wrote:
> Alan Cox wrote:
> >> Originally the drive was bought for a different PC with a Silicon Image
> >> 3114 controller. The drive worked fine with this (sata_sil). Then I
> > 
> > Ok that proves the point quite nicely. If there is a problem it is not
> > the one suggested.
> 
> Yeah, indeed.  It's still weird tho.  The difference between
> ATAPI_PROT_PIO and ATAPI_PROT_DMA is very small especially on ahci.  The
> data are still transferred using the same FIS.  Only the completion
> mechanism is different.  It would be great to try the drive on another
> ahci controller preferably intel one.  Luke, do you have access to any
> machine which has intel ahci?

I tried it out on a machine with an Intel ICH7 controller using the AHCI
driver (using a Fedora 9 LiveCD). On the ICH7 the drive wrote a CD
without issue, so possibly it's the drive/controller pair that causes
the problem. I was careful to ensure I was using the ahci driver and not 
the ata_piix driver.

Luke
