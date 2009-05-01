From: Matthew Wilcox <willy@linux.intel.com>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
	question)
Date: Fri, 1 May 2009 04:35:33 -0700
Message-ID: <20090501113533.GB10704@linux.intel.com>
References: <E1LzLgA-0004j6-9W@closure.thunk.org> <49F90CA2.4080602@garzik.org> <20090430083309.437f9248@lithium.local.net> <20090430113445.GA4809@mit.edu> <20090430113814.GB4809@mit.edu> <49FA55A0.8080303@gmail.com> <20090501025132.GA7275@mit.edu> <49FA78B4.2070900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:4655 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752941AbZEALfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 07:35:34 -0400
Content-Disposition: inline
In-Reply-To: <49FA78B4.2070900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Alex Buell <alex.buell@munted.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thu, Apr 30, 2009 at 10:21:08PM -0600, Robert Hancock wrote:
> I'm suspecting that that Ultrabay slot might be using the PATA ports on  
> the chipset, with a PATA-SATA bridge chip or something. I haven't seen  
> an Intel chipset with some SATA ports using AHCI and some in PIIX mode  
> before, the ones I've seen with both had the PIIX mode driving PATA  
> ports. If it is indeed bridged through PATA on that laptop, there's no  
> way you're going to get any NCQ support on that slot.
>
> I don't know why Lenovo would do that, as it would kind of cripple SATA  
> drives in that slot, but hardware people do some bizarre things 
> sometimes..

I have to agree with Robert.  If you look at the ich8 data sheet
(313056-003), the mobile version has 3 ATA ports and 1 IDE port "that
can be electrically isolated".  See pages 41, 43, and 50-51.  on page 41,
it says the IDE port has "Tri-state modes to enable swap bay".

So I don't blame Lenovo for hooking up the Ultrabay slot using the IDE
port.  They were pretty much told to do it.
