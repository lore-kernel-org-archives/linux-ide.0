From: Akkana Peck <akkana@shallowsky.com>
Subject: Re: Problem with PCMCIA IDE
Date: Sun, 18 Nov 2007 18:58:38 -0800
Message-ID: <20071119025837.GB23997@shallowsky.com>
References: <20071118202309.GE15355@shallowsky.com> <20071118223725.19c2424b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from adsl-69-105-235-1.dsl.pltn13.pacbell.net ([69.105.235.1]:40114
	"EHLO moon.timocharis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbXKSC6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Nov 2007 21:58:39 -0500
Content-Disposition: inline
In-Reply-To: <20071118223725.19c2424b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Alan Cox writes:
> Akkana Peck <akkana@shallowsky.com> wrote:
> 
> > I've been having problems getting PCMCIA IDE to work on my Vaio
> > laptop on recent kernels (I've been working most with 2.6.23.1 and
> > .8). I've been hesitant to report it as a kernel bug because it
> > may very well be a problem with my .config parameters -- the CDROM
> 
> Does the same happen if you disable the tickless NOHZ kernel option ?

Yes, same behavior without tickless.

Also, I had said that I didn't get the soft lockup if
CONFIG_IDEPCI_SHARE_IRQ=y and I think that's true, but with tickless
disabled I get the soft lockup regardless of the IRQ-sharing setting.

	...Akkana
