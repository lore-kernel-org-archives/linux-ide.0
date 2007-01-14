From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: sata_vsc.c cache line size question
Date: Sun, 14 Jan 2007 00:03:01 -0800
Message-ID: <20070114080301.GD61246@sgi.com>
References: <92952AEF1F064042B6EF2522E0EEF43703EE316A@EXNA.corp.stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:60646 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751150AbXANIDE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 Jan 2007 03:03:04 -0500
Content-Disposition: inline
In-Reply-To: <92952AEF1F064042B6EF2522E0EEF43703EE316A@EXNA.corp.stratus.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Dailey, Nate" <Nate.Dailey@stratus.com>
Cc: linux-ide@vger.kernel.org

On Fri, Jan 12, 2007 at 02:45:23PM -0500, Dailey, Nate wrote:
> Hoping someone on this list might shed some light on this...
> 
> I was investigating a problem of poor sequential write performance
> (IOmeter, various size sequential writes) with an embedded Vitesse 7174,
> maxing out (with disk write cache on) at around 10 MB/s...
> 
> After noticing that Windows on the same hardware was using 0x10 for the
> cache line size, but Linux was using 0x80, I tried removing the
> following from sata_vsc.c:
> 
> 381         /*
> 382          * Due to a bug in the chip, the default cache line size
> can't be used
> 383          */
> 384         pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x80);
> 
> Now, with cache line size the same as Windows, Linux is doing more like
> 43 MB/s.
> 
> Just wondering what the deal with this "bug in the chip" might be, since
> for me it seems that the default cache line size is better? If there's a
> real bug, I don't want to do anything dangerous by removing this code
> (though I've heard--haven't seen the code--that the Windows driver
> doesn't touch the cache line size, nor does the Linux non-libata
> reference driver from Vitesse).


The problem is that it can't be zero, which is the default value
after reset.

So I suppose the driver should be modified to set it to 0x80 only
if it's 0.  I believe that most PCI implementations will set it in
the BIOS or whatever.

Care to send a patch?

jeremy
