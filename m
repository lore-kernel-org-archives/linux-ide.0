From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [REGRESSION] 3.14-rc2 boot failure on Kirkwood (qnap ts-119p+)
Date: Sun, 16 Feb 2014 21:29:57 +0100
Message-ID: <20140216202957.GC26583@lunn.ch>
References: <21248.39509.418884.931848@gargle.gargle.HOWL>
 <20140216143735.GA8680@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57532 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbaBPUae (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Feb 2014 15:30:34 -0500
Content-Disposition: inline
In-Reply-To: <20140216143735.GA8680@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Mikael Pettersson <mikpelinux@gmail.com>, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org

On Sun, Feb 16, 2014 at 11:45:20AM -0300, Ezequiel Garcia wrote:
> Hi Mikael,
> 
> On Sun, Feb 16, 2014 at 12:00:37PM +0100, Mikael Pettersson wrote:
> > My Kirkwood box worked fine with the 3.13 kernel, but with 3.14-rc2
> > boot always fails due to a kernel NULL dereference in __clk_put.
> > 
> > This is a non-DT kernel, with:
> > 
> > CONFIG_ARCH_KIRKWOOD=y
> > CONFIG_KIRKWOOD_LEGACY=y
> > CONFIG_MACH_TS219=y
> > # CONFIG_ARCH_KIRKWOOD_DT is not set
> > 
> 
> Thanks for the report. I thought this issue was already fixed, but I
> cannot find it on either the mailing lists or linux-next.
> 
> So, in case it hasn't been fixed here's an untested fix for you to test.
> Please try this patch and let us know.
> 
> Your SATA won't work but if the patch is OK the kernel wont't blow away.
> 
> Andrew? Do we support the new phy requirement in non-DT platforms?

Hi Ezequiel

I consider Non-DT kirkwood now pretty much near death. Probably with
3.16 it will of gone altogether. So i did not plan for Non-DT to
support SATA phy. I did however want it to at least boot, so i broke
something here :-(

I will take a look at your fix and what we can expect in the next -rc.

  Andrew
