From: Greg KH <greg@kroah.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Thu, 14 Feb 2008 23:17:03 -0800
Message-ID: <20080215071703.GA9022@kroah.com>
References: <20080213001506.GA13933@kroah.com> <20080213001638.GB13933@kroah.com> <20080213093225.GA16985@rhun.haifa.ibm.com> <20080213173203.GC10733@kroah.com> <20080213174711.GB22274@rhun.haifa.ibm.com> <20080213181459.GA8960@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56791 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757050AbYBOHZx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 02:25:53 -0500
Content-Disposition: inline
In-Reply-To: <20080213181459.GA8960@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: jdmason@kudzu.us, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Wed, Feb 13, 2008 at 10:14:59AM -0800, Greg KH wrote:
> On Wed, Feb 13, 2008 at 07:47:11PM +0200, Muli Ben-Yehuda wrote:
> > On Wed, Feb 13, 2008 at 09:32:03AM -0800, Greg KH wrote:
> > 
> > > Is there some reason you aren't using the "real" PCI driver api here
> > > and registering a pci driver for these devices?  That would take the
> > > whole "loop over all pci devices" logic out of the code entirely.
> > 
> > I recall we had a reason, but I no longer recall what it was. Some
> > reason the "real" PCI driver API didn't fit at the time. If someone
> > were to whip up a working patch, I'd happily apply it.
> 
> "at the time"?  It's been in place since the 2.2 days :)
> 
> Is the problem that other drivers also want access to this PCI device
> for some reason?
> 
> I'll whip up a patch for you to test with in a bit...

Hm, that's wierd.  I thought I got something, until I realized that you
are doing a lot of logic before you ever even determine that your
hardware is present in the system.  Why are you calling
calgary_locate_bbars() and doing all of that work?  Or am I mising
something in the code flow here?

Also, it looks like you use the pci_get_device() to find the pci device,
then you do somethings, and then drop the device, never to use it again.

So, a traditional "probe" might not work as well, but it could be used
if you want to.

thanks,

greg k-h
