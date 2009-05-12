From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Tue, 12 May 2009 05:26:17 -0400
Message-ID: <4A0940B9.5080905@garzik.org>
References: <200905062009.28087.markos@codex.gr>	<4A086A76.3090008@garzik.org> <18953.15575.632189.258813@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:38182 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbZELJ00 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 May 2009 05:26:26 -0400
In-Reply-To: <18953.15575.632189.258813@pilspetsen.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

Mikael Pettersson wrote:
> Jeff Garzik writes:
>  > Konstantinos Margaritis wrote:
>  > > (not subscribed please CC me)
>  > > 
>  > > I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found that 
>  > > it failed to compile -lots of dmi related errors. I found that I had to 
>  > > include the broken_systems handling code in #ifdef CONFIG_DMI (DMI is not 
>  > > supported on platforms other than i386/x86_64). 
>  > > 
>  > > Lennert on #mklinux told me that this commit broke the non-dmi support, and 
>  > > that a similar patch to mine is used on ARM systems :
>  > > 
>  > > commit e57db7bde7bff95ae812736ca00c73bd5271455b
>  > > SATA Sil: Blacklist system that spins off disks during ACPI power off
>  > > 
>  > > With this patch, sata_sil compiles on ppc (and I guess on other platforms). 
>  > > I'm using it for a while with no problems with a Delock 4-port SATA PCI card.
>  > 
>  > (CC'ing various Lennerts)
> 
> That would be Lennert Buytenhek.
> 
>  > What is the breakage?
> 
> Compile-time error because sata_sil is used on !x86 platforms and the
> unconditional references to x86-only DMI stuff simply aren't valid.
> 
> I have an ARM + sata_sil NAS box that did have this problem a few
> kernel releases back, but it got resolved before that kernel's -final.
> (I can look up the details on Thursday when I'm back to my home network.)

Yes, I was asking for specific details of the breakage.

It is common practice to create no-op stubs for the !CONFIG_FEATURE 
case, thereby saving individual drivers from being littered with 
CONFIG_xxx ifdefs all over the place.

You can see this in the bottom half of include/linux/dmi.h, which is 
clearly intended to support !CONFIG_DMI platforms.

Therefore, it is an open question of what _specifically_ is the 
breakage, because include/linux/dmi.h is not working as intended on 
non-DMI platforms.

	Jeff


