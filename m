From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Fri, 04 Feb 2005 09:17:12 +1100
Message-ID: <1107469032.2363.44.camel@gaston>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>
	 <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
	 <1107299901.5624.28.camel@gaston>
	 <200502031358.16827.roffermanns@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from gate.crashing.org ([63.228.1.57]:65235 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263023AbVBCWRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Feb 2005 17:17:55 -0500
In-Reply-To: <200502031358.16827.roffermanns@sysgo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rolf Offermanns <roffermanns@sysgo.com>
Cc: list linux-ide <linux-ide@vger.kernel.org>

On Thu, 2005-02-03 at 13:58 +0100, Rolf Offermanns wrote:
> On Wednesday 02 February 2005 00:18, you wrote:
> 
> >
> > The IDE layer waits up to 30 seconds for a device to drop it's busy bit,
> > which is necessary for some drives that aren't fully initialized yet.
> >
> > I suspect in your case, it's reading "ff", which indicates either that
> > there is no hardware where the kernel tries to probe, or that there is
> > bogus IDE interfaces which don't properly have the D7 line pulled low so
> > that BUSY appears not set in absence of a drive.
> >
> I have the same kind of bogus hardware here. What would be the right place to 
> workaround this? (unfortunately it's not possible to fix/change the 
> hardware).

Do not register interfaces that you know aren't populated...

One thing is, the wait code does explicitely check for a value of 0xff
and exists in this case (assuming this means no HW at all is wired
there). So for some reason, you interface is returning something else,
it would be interesting to "see" what value you are getting.

Ben.


