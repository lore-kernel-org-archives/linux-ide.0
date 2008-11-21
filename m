From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Fri, 21 Nov 2008 08:31:33 +0000
Message-ID: <20081121083133.GA23336@flint.arm.linux.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk> <20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39882 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239AbYKUIbr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 03:31:47 -0500
Content-Disposition: inline
In-Reply-To: <20081121003723.03bcef7e@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 21, 2008 at 12:37:23AM +0000, Alan Cox wrote:
> On Fri, 21 Nov 2008 00:25:21 +0000
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > Hi,
> > 
> > Last weekend I upgraded my old Thinkpad from Fedora Core 2 to F9
> > (a 2.6.9 kernel to a 2.6.25 kernel).  The old 2.6.9 kernel was
> > using the IDE drivers, and there have been no issues with IDE on
> > this hardware until this upgrade.
> 
> Can you double the timeouts for block I/O commands. The libata core uses
> 30 second timeouts for a lot of stuff and some PATA drives really do want
> 60.
> 
> Other than that there really isn't any difference in the settings the two
> drivers use as they are all written up exactly in the Intel docs.

I'm not sure that lengthening the timeout is going to help - with
the older IDE drivers, I've never had the laptop wait on disk IO
for longer than about 5 seconds even when the disk has been spun
down.

Is this timeout parameter is only changeable by rebuilding the kernel?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
