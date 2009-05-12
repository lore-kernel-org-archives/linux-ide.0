From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Tue, 12 May 2009 11:09:43 +0200
Message-ID: <18953.15575.632189.258813@pilspetsen.it.uu.se>
References: <200905062009.28087.markos@codex.gr>
	<4A086A76.3090008@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:35716 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbZELJLr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 05:11:47 -0400
In-Reply-To: <4A086A76.3090008@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

Jeff Garzik writes:
 > Konstantinos Margaritis wrote:
 > > (not subscribed please CC me)
 > > 
 > > I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found that 
 > > it failed to compile -lots of dmi related errors. I found that I had to 
 > > include the broken_systems handling code in #ifdef CONFIG_DMI (DMI is not 
 > > supported on platforms other than i386/x86_64). 
 > > 
 > > Lennert on #mklinux told me that this commit broke the non-dmi support, and 
 > > that a similar patch to mine is used on ARM systems :
 > > 
 > > commit e57db7bde7bff95ae812736ca00c73bd5271455b
 > > SATA Sil: Blacklist system that spins off disks during ACPI power off
 > > 
 > > With this patch, sata_sil compiles on ppc (and I guess on other platforms). 
 > > I'm using it for a while with no problems with a Delock 4-port SATA PCI card.
 > 
 > (CC'ing various Lennerts)

That would be Lennert Buytenhek.

 > What is the breakage?

Compile-time error because sata_sil is used on !x86 platforms and the
unconditional references to x86-only DMI stuff simply aren't valid.

I have an ARM + sata_sil NAS box that did have this problem a few
kernel releases back, but it got resolved before that kernel's -final.
(I can look up the details on Thursday when I'm back to my home network.)

 > Ideally the DMI subsystem should be provided wrappers for platforms 
 > without DMI, rendering patches like this unnecessary.

Another ARM NAS of mine uses pata_artop with a short 40-wire cable.
To correct the speed setting I need a cable type override function with
an "is it $this platform" check. The lack of a unified infrastructure
for these checks forces me to use ARM-specific code wrapped with
#ifdef CONFIG_ARM. So I agree with your comment, except I don't have
any opinion on whether a unified platform identification layer should
look like DMI, OF, or something else.

/Mikael
