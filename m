From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] pata_platform: move ARCH_RPC to use MACH_HAS_PATA_PLATFORM
Date: Mon, 19 Nov 2007 14:12:55 +0000
Message-ID: <20071119141255.GK26444@trinity.fluff.org>
References: <20071119124340.GJ26444@trinity.fluff.org> <20071119125014.GM31701@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:48332 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbXKSONM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 09:13:12 -0500
Content-Disposition: inline
In-Reply-To: <20071119125014.GM31701@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ben Dooks <ben-linux@fluff.org>, Sam Ravnborg <sam@ravnborg.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Vincent Sanders <vince@simtec.co.uk>

On Mon, Nov 19, 2007 at 12:50:15PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 19, 2007 at 12:43:40PM +0000, Ben Dooks wrote:
> > Move ARCH_RPC to using MACH_HAS_PATA_PLATFORM as an example
> > of using this new configuration.
> 
> I thought that it had been agreed (on linux-arch) that the name of these
> options shall be HAVE_foo to enable a driver configuration symbol of
> foo.
> 
> IOW, this should be HAVE_PATA_PLATFORM not MACH_HAS_PATA_PLATFORM.

Ok, HAVE_PATA_PLATFORM should be unique enough without adding anything
like HAVE_DRIVER_PATA_PLATFORM. If no-one else objects, I will submit
a new version of these two patches.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

