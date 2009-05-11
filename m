From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Mon, 11 May 2009 14:12:06 -0400
Message-ID: <4A086A76.3090008@garzik.org>
References: <200905062009.28087.markos@codex.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:35933 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbZEKSMI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 14:12:08 -0400
In-Reply-To: <200905062009.28087.markos@codex.gr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Konstantinos Margaritis <markos@codex.gr>
Cc: linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

Konstantinos Margaritis wrote:
> (not subscribed please CC me)
> 
> I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found that 
> it failed to compile -lots of dmi related errors. I found that I had to 
> include the broken_systems handling code in #ifdef CONFIG_DMI (DMI is not 
> supported on platforms other than i386/x86_64). 
> 
> Lennert on #mklinux told me that this commit broke the non-dmi support, and 
> that a similar patch to mine is used on ARM systems :
> 
> commit e57db7bde7bff95ae812736ca00c73bd5271455b
> SATA Sil: Blacklist system that spins off disks during ACPI power off
> 
> With this patch, sata_sil compiles on ppc (and I guess on other platforms). 
> I'm using it for a while with no problems with a Delock 4-port SATA PCI card.

(CC'ing various Lennerts)

What is the breakage?

Ideally the DMI subsystem should be provided wrappers for platforms 
without DMI, rendering patches like this unnecessary.

	Jeff




