From: Michael Spiegle <mike@nauticaltech.com>
Subject: Re: AHCI driver for ICH6M
Date: Wed, 01 Feb 2006 08:15:51 -0800
Message-ID: <1138810551.9300.0.camel@localhost>
References: <1138771289.15467.9.camel@localhost>
	 <1138793371.4449.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blue.nauticaltech.com ([64.71.32.16]:50181 "EHLO
	blue.nauticaltech.com") by vger.kernel.org with ESMTP
	id S964982AbWBAQP5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Feb 2006 11:15:57 -0500
In-Reply-To: <1138793371.4449.27.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-ide@vger.kernel.org

On Wed, 2006-02-01 at 12:29 +0100, Erik Slagter wrote:
> > I was trying to use the AHCI driver included in kernel 2.6.15 to drive
> > the SATA controller on my Asus Z71V laptop which supposedly has an ICH6M
> > controller.  I noticed that the PCI ID of my controller shows up in the
> > AHCI source code, so I assume that means I should have support.  I'm not
> > terribly good with linux or C, but I think I was able to troubleshoot my
> > issue down to a specific line of code.  Ultimately, I get the error:
> > 
> > ahci: probe of 0000:00:1f.2 failed with error -12
> 
> A very familiar problem. It means that your bios configures your ICH
> chipset for legacy (or whatever name it has) mode, which means it will
> respond to the old-fashioned IDE ports and IRQs. This also means you
> cannot drive it in AHCI mode :-( unless there is an option in your BIOS
> to switch between legacy and ahci mode, but afaik no single laptop has
> this option. So you're on your own here :-( (just like me, btw).

thank you for your reply!  Looks like i'll need to wait for my laptop
manufacturer to realize this is an important feature.... or load up my
hex editor =)

