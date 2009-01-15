From: Greg KH <greg@kroah.com>
Subject: Re: [stable] [Bugme-new] [Bug 12351] New: sata_nv hotplug not work
	in 2.6.27.10
Date: Thu, 15 Jan 2009 10:45:02 -0800
Message-ID: <20090115184502.GC10674@kroah.com>
References: <bug-12351-10286@http.bugzilla.kernel.org/> <20090105153644.8a0eea74.akpm@linux-foundation.org> <4962AC5C.1000605@shaw.ca> <20090106102758.GA7309@libero.it> <4963F520.4060500@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:44271 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755421AbZAOTDY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Jan 2009 14:03:24 -0500
Content-Disposition: inline
In-Reply-To: <4963F520.4060500@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: gpanco@tiscali.it, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org, bugme-daemon@bugzilla.kernel.org

On Tue, Jan 06, 2009 at 06:19:44PM -0600, Robert Hancock wrote:
> Giovanni Pancotti wrote:
> > On Monday 05 January 2009, alle 18:57, Robert Hancock wrote:
> > 
> >>>> Hardware Environment:x86 ASUS M2N-E
> >> OK, this is an MCP61 board. We're now using softreset instead of hardreset 
> >> on hotplug and apparently that doesn't work. Thing is that:
> > 
> > no, it is not MCP61, but MCP55:
> 
> Ahh, ok, that is less contradictory then :-) Presumably we should still 
> be using hardreset on that chipset.

So, do we know how to solve this in the 2.6.27.y tree?

thanks,

greg k-h
