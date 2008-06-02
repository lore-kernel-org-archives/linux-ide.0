From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH] ata: ahci: power off unused ports
Date: Mon, 2 Jun 2008 09:57:10 -0700
Message-ID: <20080602095710.1b0de376@appleyard>
References: <20080508161008.59361de5@appleyard>
	<20080527030854.GC7515@mit.edu>
	<20080527143202.4bab5bf0@appleyard>
	<20080527225926.GE6843@mit.edu>
	<20080527163251.04054a74@appleyard>
	<20080531080015.GG5405@ucw.cz>
	<4842F5A8.9020708@garzik.org>
	<20080602080440.25fc663c@core>
	<4843A4A7.3020809@garzik.org>
	<4843EF88.2040606@rtr.ca>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47786 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbYFBRGg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jun 2008 13:06:36 -0400
In-Reply-To: <4843EF88.2040606@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, Theodore Tso <tytso@mit.edu>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 02 Jun 2008 09:03:04 -0400
Mark Lord <liml@rtr.ca> wrote:

> Jeff Garzik wrote:
> > Alan Cox wrote:
> >>> If you are talking about SATA -- incorrect.
> >>>
> >>> The patch deals with policy, and the user MUST have the ability to 
> >>> control this stuff.  Otherwise you create a situation where the user 
> >>> might be denied hotplug use in valid cases, or similar negative 
> >>> situations.
> >>
> >> The policy isn't however complicated. Tejun added the stuff for forcing
> >> cable type and mode on setup and has therefore written all the per device
> >> setup code we might need. Alternatively a single
> >>
> >>     foo=1/0
> >>
> >> option has been fine for acpi and will do fine for this. Total additional
> >> cost - 1 line.
> > 
> > The key requirement is per-port control.  Ideally via hdparm or another 
> > userspace tool, but kernel command line (module options) or sysfs would 
> > be just fine too.  And agreed, the minimal you need is simply 1/0 for 
> > the port's policy.
> ..
> 
> Btw.. hdparm-8.7 (unreleased) can grok /sys now, so that interface is
> as good as any from a userspace viewpoint now.
> 
> For the power-off of unused ports, the current patch still sounds
> extremely vendor-specific (Intel).

Wrong - this patch is implemented according to the AHCI spec and
has absolutely nothing vendor specific in it.

> 
> Does it actually work (demonstrate, please) on any other hardware ?

If someone would like to test it on another AHCI compliant chipset
that would be great.  I have none.
