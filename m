From: Chris Webb <chris.webb@elastichosts.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Tue, 8 Feb 2011 11:00:36 +0000
Message-ID: <20110208110036.GA18763@arachsys.com>
References: <20110129112456.GA13204@arachsys.com>
 <4D44433F.1040607@gmail.com>
 <20110130015442.GB13204@arachsys.com>
 <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
 <20110202135644.GG11670@arachsys.com>
 <4D49FB9F.9040304@gmail.com>
 <20110203085601.GB2490@arachsys.com>
 <20110207174838.GA21124@arachsys.com>
 <4D50A4B8.2070608@gmail.com>
 <20110208104157.GU2106@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.arachsys.com ([91.203.57.7]:54060 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab1BHLAp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 06:00:45 -0500
Content-Disposition: inline
In-Reply-To: <20110208104157.GU2106@amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

"Roedel, Joerg" <Joerg.Roedel@amd.com> writes:

> On Mon, Feb 07, 2011 at 09:04:40PM -0500, Robert Hancock wrote:
> > On 02/07/2011 11:48 AM, Chris Webb wrote:
> > > I've now done this, swapping in a Highpoint R620. I get the same
> > > IO_PAGE_FAULT, same timeouts on the sata card, but lspci now shows up the
> > > device 03:00.1. I've put the new dmesg and lspci output at
> > >
> > >    http://cdw.me.uk/tmp/sata-fault-hpt.dmesg
> > >    http://cdw.me.uk/tmp/sata-fault-hpt.lspci
> > >
> > > Again, problem is present both with 2.6.32.25 and 2.6.37.
> > 
> > Curious.. We don't even have a driver loaded for the PATA device on that 
> > chip so I don't see how we could be telling it to do anything. As far as 
> > I can see there are a few possible causes: Either the device is 
> > generating read requests which appear to come from the PATA function 
> > rather than the SATA one for some reason, the IOMMU is picking up the 
> > wrong device function for requests from that device, or something in the 
> > platform is somehow misconfiguring the device to cause this error. It 
> > may not be easy to figure out which one is the cause, however.
> 
> The most likely reason for this is, that the add-on card uses both
> request-ids (03:00.0 and 03:00.1) for requests originating from the SATA
> controler. The address in the page-fault looks like an address the IOMMU
> driver would assign but from a device which has no driver loaded.
> If this is a know feature of the card the BIOS should detect it an
> report it in the IVRS table with an alias-range. The driver would handle
> it in this situation. Otherwise it looks like a problem with the
> addon-card.

Hi Joerg. What's particularly puzzling here is that the symptoms are pretty
much the same with two completely different AHCI SATA cards. I expected to
be able to work around the problem by swapping in a different SATA card with
a different chipset, but it seems to be a problem with both.

Cheers,

Chris.
