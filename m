From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: tighten ATA kconfig dependancies
Date: Sun, 16 Jul 2006 07:58:57 +0200
Message-ID: <20060716055857.GA29733@mars.ravnborg.org>
References: <6yL2J-7rR-1@gated-at.bofh.it> <6yLco-7DB-1@gated-at.bofh.it> <E1G1p1y-0000ZU-Io@be1.lrz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:33242 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750739AbWGPF64 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Jul 2006 01:58:56 -0400
Content-Disposition: inline
In-Reply-To: <E1G1p1y-0000ZU-Io@be1.lrz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

On Sat, Jul 15, 2006 at 08:38:01PM +0200, Bodo Eggert wrote:
> >> A lot of prehistoric junk shows up on x86-64 configs.
> > 
> > ... but in general it helps compile testing if you're hacking stuff;
> > if your hacking IDE on x86-64 you now have to compile 32 bit as well to
> > see if you didn't break the compile for these as well
> > 
> > So please don't do this, just disable them in your config...
> 
> If you want to compile test these drivers, just revert the patch or edit
> the .config.
Editing .config will not do the trick. kconfig will make sure the kernel
is build with a valid config so they will get turned off.

A cross compile toolchain is the only real soluion. Otherwise we would
soon end up with far to many drivers selectable for x84-64.

	Sam
