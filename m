From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: PATA timeouts on old thinkpad
Date: Mon, 24 Nov 2008 12:48:01 +0000
Message-ID: <20081124124801.GA11139@flint.arm.linux.org.uk>
References: <20081121002521.GA12626@flint.arm.linux.org.uk> <20081121003723.03bcef7e@lxorguk.ukuu.org.uk> <20081121083133.GA23336@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40059 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYKXMsR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 07:48:17 -0500
Content-Disposition: inline
In-Reply-To: <20081121083133.GA23336@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 21, 2008 at 08:31:33AM +0000, Russell King wrote:
> On Fri, Nov 21, 2008 at 12:37:23AM +0000, Alan Cox wrote:
> > On Fri, 21 Nov 2008 00:25:21 +0000
> > Russell King <rmk@arm.linux.org.uk> wrote:
> > 
> > > Hi,
> > > 
> > > Last weekend I upgraded my old Thinkpad from Fedora Core 2 to F9
> > > (a 2.6.9 kernel to a 2.6.25 kernel).  The old 2.6.9 kernel was
> > > using the IDE drivers, and there have been no issues with IDE on
> > > this hardware until this upgrade.
> > 
> > Can you double the timeouts for block I/O commands. The libata core uses
> > 30 second timeouts for a lot of stuff and some PATA drives really do want
> > 60.
> > 
> > Other than that there really isn't any difference in the settings the two
> > drivers use as they are all written up exactly in the Intel docs.
> 
> I'm not sure that lengthening the timeout is going to help - with
> the older IDE drivers, I've never had the laptop wait on disk IO
> for longer than about 5 seconds even when the disk has been spun
> down.

To repeat: I really don't think this is the issue.  Firstly the
reason I give above.

Secondly, you can hear what this disk is doing - and it's spun up,
the drive light is on solidly, and there's just the noise of the disk
spinning, nothing else.  The machine has been idle with cron etc
disabled, so it's not going to be doing a lot of IO.  It's not running
gnome or even X, it's just being used as a text terminal with 8 VTs
running kerberos.  It does run dhclient, ntp and a local exim which is
probably responsible for the occasional disk IO.

After the soft reset, there isn't much IO that's done since the drive
light turns off.

That's the normal pattern that this laptop has had for the last N years -
the occasional bit of disk IO which normally results in the disk light
only being on for less than the 3 seconds that it takes the drive to
spin up and perform the IO.

No 30 second waits on IO have ever been experienced with the old IDE
driver.

So, I believe that increasing the timeout from 30 to 60 seconds will just
increase the time that has to be waited for things to be kicked back into
operation.

What I do know is that the APM BIOS seems to talk to the IDE drive via
some method to control the spin down - for instance, if I disable spindown
with hdparm -S 0 /dev/sda, then at some point it will be magically
re-enabled - I just did precisely that and within 60 seconds the drive's
spun back down.  So I wonder if PATA is talking to the drive differently
from the old IDE driver, in a way that the BIOS doesn't understand, and
there's a race between PATA and the APM BIOS causing the drive to get
confused.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
