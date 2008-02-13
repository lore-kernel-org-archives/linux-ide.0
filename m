From: Greg KH <greg@kroah.com>
Subject: Re: "ide=reverse" do we still need this?
Date: Tue, 12 Feb 2008 20:43:04 -0800
Message-ID: <20080213044304.GA10101@kroah.com>
References: <20080213001506.GA13933@kroah.com> <20080213024329.GA6912@deepthought>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:60054 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764712AbYBMGCH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 01:02:07 -0500
Content-Disposition: inline
In-Reply-To: <20080213024329.GA6912@deepthought>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: bzolnier@gmail.com, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

On Wed, Feb 13, 2008 at 02:43:29AM +0000, Ken Moffat wrote:
> On Tue, Feb 12, 2008 at 04:15:07PM -0800, Greg KH wrote:
> > 
> > I'm curious if we really still support the ide=reverse option?  It's a
> > config option that I don't think the distros still enable (SuSE does
> > not).  Is this still needed these days?
> > 
>  My "server" has a consumer-grade desktop amd64 mobo, with all that
> implies about cheap hardware and strange/misleading bios options.
> It also has an add-in dual IDE card with the main data on raid1.
> It's set to ide=reverse, without that it doesn't boot (the add-ins
> are IDE, system drive is SATA, so I guess it probably tries to boot
> from the DVD - it's been a long time since it bit me and I don't
> remember the full details.
> 
>  That was how it was set for 2.6.18.6, and how it now boots from
> 2.6.22.18.  I think at one time the order of the interfaces might
> have been different.  Certainly, I carry forward a fallback without
> ide=reverse in lilo.conf, just in case the disks move on my next
> kernel upgrade.

Can't you just boot with /dev/disk/by-id/ and an initramfs to not have
to worry about such a thing in the future?

Have you tried the PATA drivers instead of IDE to see if this solves the
"moves around" issue?  If they work, then you would not need the command
line option at all.

thanks,

greg k-h
