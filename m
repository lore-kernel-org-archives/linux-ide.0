From: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Wed, 13 Feb 2008 19:47:11 +0200
Message-ID: <20080213174711.GB22274@rhun.haifa.ibm.com>
References: <20080213001506.GA13933@kroah.com> <20080213001638.GB13933@kroah.com> <20080213093225.GA16985@rhun.haifa.ibm.com> <20080213173203.GC10733@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:15203 "EHLO
	mtagate6.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbYBMRrk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 12:47:40 -0500
Content-Disposition: inline
In-Reply-To: <20080213173203.GC10733@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: jdmason@kudzu.us, bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Wed, Feb 13, 2008 at 09:32:03AM -0800, Greg KH wrote:

> Is there some reason you aren't using the "real" PCI driver api here
> and registering a pci driver for these devices?  That would take the
> whole "loop over all pci devices" logic out of the code entirely.

I recall we had a reason, but I no longer recall what it was. Some
reason the "real" PCI driver API didn't fit at the time. If someone
were to whip up a working patch, I'd happily apply it.

> > Feel free to nuke it and walk the list forward.
> 
> So something like the patch below would be fine?

Yep, looks good. 

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
