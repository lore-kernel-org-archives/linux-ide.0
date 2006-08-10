From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Merging libata PATA support into the base kernel
Date: Thu, 10 Aug 2006 21:54:25 +0200
Message-ID: <200608102154.25594.rjw@sisk.pl>
References: <1155144599.5729.226.camel@localhost.localdomain> <20060810190222.GA12818@knob.reflex> <20060810194734.GE11829@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:15744 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751139AbWHJTz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Aug 2006 15:55:27 -0400
In-Reply-To: <20060810194734.GE11829@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jason Lunz <lunz@falooley.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 10 August 2006 21:47, Jens Axboe wrote:
> On Thu, Aug 10 2006, Jason Lunz wrote:
> > In gmane.linux.kernel, you wrote:
]--snip--[
> > 
> > It's not surprising you're not getting many bug reports. It's common for
> > several things to go wrong during s2ram, and the user often ends up
> > looking at a hung system with a dead screen. It takes some quality time
> > with netconsole to even begin to narrow down that it's IDE hanging the
> > system, after which you can *begin* solving the no-video-on-resume
> > issue.
> 
> I'm not on any of the suspend lists, I was merely comparing the
> suspend-others or suspend-libata ration to suspend-ide on linux-kernel,
> and the latter is clearly in the minority. I've used ide suspend quite a
> bit myself, and never had issues with it (or whichever ones I saw
> initially, I fixed). Of course it depends very much on the hardware. I'd
> still say that ide suspend probably supports a much wider range of
> hardware, than does libata suspend.

As far as the suspend to disk is concerned, you are probably right, but
I'm not sure about the suspend to RAM.

Greetings,
Rafael
