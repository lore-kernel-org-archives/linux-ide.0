From: "John Stoffel" <john@stoffel.org>
Subject: Re: PATA drivers queued for 2.6.19
Date: Tue, 5 Sep 2006 09:30:46 -0400
Message-ID: <17661.31750.457301.687508@smtp.charter.net>
References: <44FC0779.9030405@garzik.org>
	<1157371363.30801.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:47243 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965006AbWIENax (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Sep 2006 09:30:53 -0400
In-Reply-To: <1157371363.30801.31.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Ar Llu, 2006-09-04 am 07:01 -0400, ysgrifennodd Jeff Garzik:
>> The following must be in all caps, though:
>> 
>> drivers/ide IS STILL THE PATA DRIVER SET THAT USERS AND DISTROS SHOULD 
>> CHOOSE.

Alan> Except optionally for the following for chips not handled by or broken
Alan> totally in drivers/ide:

Alan> 	pata_mpiix - some early pentium era laptops
Alan> 	pata_oldpiix - original "PIIX" chipset
Alan> 	pata_radisys - embedded chipset

What about pata_hpt37x and it's failure to work with my HPT302 Rev one
controller?  I admit it could be just an IRQ problem, but since
2.6.18-rc5-mm1 works with the old ide/pci/hpt366.c, but not with the
new version?  It's using the same interrupt each time too.

John
