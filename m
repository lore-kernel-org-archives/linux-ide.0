From: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Subject: Re: IO_PAGE_FAULT from SATA card during boot
Date: Tue, 8 Feb 2011 11:41:57 +0100
Message-ID: <20110208104157.GU2106@amd.com>
References: <20110129112456.GA13204@arachsys.com>
 <4D44433F.1040607@gmail.com>
 <20110130015442.GB13204@arachsys.com>
 <AANLkTim7+9WVVJAjbj4pNMB9OKVmf2B+XNQ+exDt9_Tm@mail.gmail.com>
 <20110202135644.GG11670@arachsys.com>
 <4D49FB9F.9040304@gmail.com>
 <20110203085601.GB2490@arachsys.com>
 <20110207174838.GA21124@arachsys.com>
 <4D50A4B8.2070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.185]:18795
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752597Ab1BHK5I (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Feb 2011 05:57:08 -0500
Content-Disposition: inline
In-Reply-To: <4D50A4B8.2070608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Chris Webb <chris.webb@elastichosts.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Mon, Feb 07, 2011 at 09:04:40PM -0500, Robert Hancock wrote:
> On 02/07/2011 11:48 AM, Chris Webb wrote:
> > I've now done this, swapping in a Highpoint R620. I get the same
> > IO_PAGE_FAULT, same timeouts on the sata card, but lspci now shows up the
> > device 03:00.1. I've put the new dmesg and lspci output at
> >
> >    http://cdw.me.uk/tmp/sata-fault-hpt.dmesg
> >    http://cdw.me.uk/tmp/sata-fault-hpt.lspci
> >
> > Again, problem is present both with 2.6.32.25 and 2.6.37.
> 
> Curious.. We don't even have a driver loaded for the PATA device on that 
> chip so I don't see how we could be telling it to do anything. As far as 
> I can see there are a few possible causes: Either the device is 
> generating read requests which appear to come from the PATA function 
> rather than the SATA one for some reason, the IOMMU is picking up the 
> wrong device function for requests from that device, or something in the 
> platform is somehow misconfiguring the device to cause this error. It 
> may not be easy to figure out which one is the cause, however.

The most likely reason for this is, that the add-on card uses both
request-ids (03:00.0 and 03:00.1) for requests originating from the SATA
controler. The address in the page-fault looks like an address the IOMMU
driver would assign but from a device which has no driver loaded.
If this is a know feature of the card the BIOS should detect it an
report it in the IVRS table with an alias-range. The driver would handle
it in this situation. Otherwise it looks like a problem with the
addon-card.

		Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632

