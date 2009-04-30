From: Theodore Tso <tytso@mit.edu>
Subject: Re: No NCQ support on X61s Ultrabay?  (Intel ICH8 SATA controller
	question)
Date: Thu, 30 Apr 2009 07:34:45 -0400
Message-ID: <20090430113445.GA4809@mit.edu>
References: <E1LzLgA-0004j6-9W@closure.thunk.org> <49F90CA2.4080602@garzik.org> <20090430083309.437f9248@lithium.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:36797 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763342AbZD3LfA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Apr 2009 07:35:00 -0400
Content-Disposition: inline
In-Reply-To: <20090430083309.437f9248@lithium.local.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alex Buell <alex.buell@munted.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, Matthew Wilcox <willy@linux.intel.com>, Linux IDE mailing list <linux-ide@vger.kernel.org>

On Thu, Apr 30, 2009 at 08:33:09AM +0100, Alex Buell wrote:
> On Wed, 29 Apr 2009 22:27:46 -0400, I waved a wand and this message
> magically appears in front of Jeff Garzik:
> 
> > As Tejun noted, try switching to AHCI mode in BIOS.
> 
> But is there a way to switch modes without needing to go through the
> BIOS? Some laptops won't let you do that through BIOS. 

The BIOS setting already is in AHCI mode, and not in "compatibility
mode".  This is with BIOS version 2.19 on the X61s.  I can check to
see if there is a newer BIOS revision... hmm, there is a 2.20, but it
claims the only thing it fixes is:

- Fixed an issue where the AMT menu of BIOS Setup Utility might not be
  displayed.

I can try upgrading to it and see if it's any better.  Or maybe
someone on the Linux-thinkpad mailing list with contacts inside Lenovo
can bug them.  Sounds like there's no way to work around this except
for a BIOS-level fix then?  :-(

						- Ted
