From: Jeff Garzik <jeff@garzik.org>
Subject: Re: linux-next: libata/avr32 build failure
Date: Fri, 04 Apr 2008 14:45:58 -0400
Message-ID: <47F67766.6030903@garzik.org>
References: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>	<47F5E1A0.4060905@garzik.org> <20080404095408.88a92c7c.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38375 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607AbYDDSqI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 14:46:08 -0400
In-Reply-To: <20080404095408.88a92c7c.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-ide@vger.kernel.org

Randy Dunlap wrote:
> On Fri, 04 Apr 2008 04:06:56 -0400 Jeff Garzik wrote:
> 
>> Stephen Rothwell wrote:
>>> Hi Jeff,
>>>
>>> For a while the linux-next build for avr32 defconfig (and others) has
>>> been failing like this:
>>>
>>> drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' undeclared here (not in a function)
>>>
>>> It seems to be because the declaration of ata_pci_default_filter is
>>> protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
>>> only.
>>>
>>> Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
>>> March 29).
>> fixed being pushed right now (patch from Tejun fixed it)
> 
> Some fixes other than what was in today's (April 04)
> [git patches] libata fixes?
> 
> I hope there is more.  I don't see how that fixes this error.
> Nor does gcc see how, after I apply that patch.

It wasn't sent in #upstream-fixes, it was applied to #upstream...

Is that where you are looking?

	Jeff



