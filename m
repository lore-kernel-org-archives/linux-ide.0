From: Jason Lunz <lunz@falooley.org>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 15:02:22 -0400
Message-ID: <20060810190222.GA12818@knob.reflex>
References: <1155144599.5729.226.camel@localhost.localdomain> <p733bc5nm5g.fsf@verdi.suse.de> <1155213464.22922.6.camel@localhost.localdomain> <20060810122056.GP11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.reflexsecurity.com ([72.54.64.74]:23714 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S932301AbWHJTCk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Aug 2006 15:02:40 -0400
In-Reply-To: <20060810122056.GP11829@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

In gmane.linux.kernel, you wrote:
> You make it sound much worse than it is. Apart for HPA, I'm not aware of
> any setups that require extra treatment. And the amount of reported bugs
> against it are pretty close to zero :-)

*ahem*.

I needed to do this to cure IDE hangs on resume:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch

Are you watching the suspend mailing lists? There's no shortage of them:

suspend-devel:	http://dir.gmane.org/gmane.linux.kernel.suspend.devel
linux-pm:	http://dir.gmane.org/gmane.linux.power-management.general
suspend2-devel:	http://dir.gmane.org/gmane.linux.swsusp.devel
suspend2-users:	http://dir.gmane.org/gmane.linux.swsusp.general

I'm currently trying to help out one Sheer El-Showk, whose piix ide
requires 30 seconds of floundering followed by a bus reset to resume:

http://thread.gmane.org/gmane.linux.kernel.suspend.devel/276/focus=347

But I know next-to-nothing about ATA.

It's not surprising you're not getting many bug reports. It's common for
several things to go wrong during s2ram, and the user often ends up
looking at a hung system with a dead screen. It takes some quality time
with netconsole to even begin to narrow down that it's IDE hanging the
system, after which you can *begin* solving the no-video-on-resume
issue.

Jason
