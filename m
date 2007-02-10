From: Soeren Sonnenburg <sonne@nn7.de>
Subject: Re: [PATCH] AHCI PCI ID for MacBook Pro
Date: Sat, 10 Feb 2007 17:07:02 +0100
Message-ID: <1171123622.31813.9.camel@localhost>
References: <82530.66623.qm@web25412.mail.ukl.yahoo.com>
	 <200702091527.08447.rootkit85@yahoo.it>
	 <1171032893.8134.13.camel@localhost>
	 <200702091839.52316.rootkit85@yahoo.it>  <45CDD0CB.2070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nn7.de ([85.214.94.156]:34873 "EHLO nn7.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932740AbXBJQNq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 11:13:46 -0500
In-Reply-To: <45CDD0CB.2070608@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Matteo Croce <rootkit85@yahoo.it>, linux-ide@vger.kernel.org

On Sat, 2007-02-10 at 09:03 -0500, Tejun Heo wrote:
> Matteo Croce wrote:
> > On Friday 09 February 2007 15:54:53 you wrote:
> >> On Fri, 2007-02-09 at 15:27 +0100, Matteo Croce wrote:
> >>> +	{ PCI_VDEVICE(INTEL, 0x27c4), board_ahci }, /* ICH7M */
> >> Wasn't this PCI ID proposed for addition a while ago, and subsequently
> >> rejected?  Or am I missing something?
> > 
> > rejected? why?
> 
> Ah... right.
> 
> All ICH7 R/M silicons can be put into either IDE or AHCI mode.  Which 
> mode is used is currently determined by BIOS.  If BIOS puts the 
> controller into ahci mode on boot, ahci is attached; otherwise, 
> ata_piix.  This sometimes reduces confusion level but more importantly 

So this means on macbook* one can use either mode ?!

> in some cases it's not possible to use the other mode because PCI 
> resource allocation is upto BIOS and it's not guaranteed to allocate all 
> the needed resources for the mode not in use.
> 
> Till now, the policy to follow BIOS setting has worked well enough. 
> Most desktop BIOSen give choice between the two modes anyway.  There 
> have been some cases where some desktops and many notebooks where the 
> silicon itself is capable of ahci but BIOS doesn't allow it.  It seems 
> Mac is one of them.

I don't get it. Why is it rejected then ? If I'd like to use the ahci
mode of the ich7 r/m driver I just compile it into the kernel, else the
piix ?!

Soeren
-- 
For the one fact about the future of which we can be certain is that it
will be utterly fantastic. -- Arthur C. Clarke, 1962
