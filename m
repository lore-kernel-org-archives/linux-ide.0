From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATA IDE is slower in newer versions of kernel
Date: Sat, 18 Sep 2010 22:04:16 +0200
Message-ID: <201009182204.17255.arnd@arndb.de>
References: <00d401cb55f7$33a78210$9af68630$@com> <010901cb5754$ae6735a0$0b35a0e0$@com> <1284837774.12425.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1284837774.12425.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Joshua Hintze <joshh@imsar.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Saturday 18 September 2010 21:22:54 Maxim Levitsky wrote:
> On Sat, 2010-09-18 at 11:12 -0600, Joshua Hintze wrote:
> > I'm dedicated to continue working on the problem, I just need to advice from 
> > the linux community. I've tried different I/O schedulers such as noop and
> > anticipatory and I'm studying the ide-dma code but still lost to where this
> > is happening.
> > 
> > Thanks!
> > 
> Maybe you can just bisect this?

That would probably help to pinpoint the problem. A regression somewhere
between 2.6.10 and 2.6.32 is not that interesting when people are working
on stabilizing 2.6.36 and adding features to 2.6.37.

One important question would be if this happens with the libata drivers
in 2.6.36-rc4 or linux-next as well. Note that the IDE subsystem has been
replaced with libata a few years ago, and that is what all development
happens on. If libata is good enough, there is probably no point in
chasing down ide bugs.

	Arnd
