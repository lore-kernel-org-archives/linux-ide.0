From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: linux-next: libata/avr32 build failure
Date: Fri, 4 Apr 2008 09:54:08 -0700
Message-ID: <20080404095408.88a92c7c.randy.dunlap@oracle.com>
References: <20080404171040.d3d64c2d.sfr@canb.auug.org.au>
	<47F5E1A0.4060905@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:51850 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbYDDQzI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Apr 2008 12:55:08 -0400
In-Reply-To: <47F5E1A0.4060905@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-ide@vger.kernel.org

On Fri, 04 Apr 2008 04:06:56 -0400 Jeff Garzik wrote:

> Stephen Rothwell wrote:
> > Hi Jeff,
> > 
> > For a while the linux-next build for avr32 defconfig (and others) has
> > been failing like this:
> > 
> > drivers/ata/libata-core.c:127: error: 'ata_pci_default_filter' undeclared here (not in a function)
> > 
> > It seems to be because the declaration of ata_pci_default_filter is
> > protected by CONFIG_PCI but the usage above is protected by CONFIG_ATA
> > only.
> > 
> > Also reported by Randy Dunlap (on March 26) and Haavard Skinnemoen (on
> > March 29).
> 
> fixed being pushed right now (patch from Tejun fixed it)

Some fixes other than what was in today's (April 04)
[git patches] libata fixes?

I hope there is more.  I don't see how that fixes this error.
Nor does gcc see how, after I apply that patch.

---
~Randy
