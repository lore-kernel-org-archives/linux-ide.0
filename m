From: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: [PATCH] updates to Vitesse SATA driver
Date: Wed, 22 Sep 2004 13:07:29 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040922200729.GC151463@sgi.com>
References: <8746466a04092114163b3c0618@mail.gmail.com> <20040922020614.GA148273@sgi.com> <8746466a0409220859ed0682f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omx3-ext.sgi.com ([192.48.171.20]:36483 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266838AbUIVUID (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 22 Sep 2004 16:08:03 -0400
Content-Disposition: inline
In-Reply-To: <8746466a0409220859ed0682f@mail.gmail.com>
List-Id: linux-ide@vger.kernel.org
To: Dave <dave.jiang@gmail.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wed, Sep 22, 2004 at 08:59:06AM -0700, Dave wrote:
> > It actually does work already on IA64.
> > Why would a writeb not work?  All it does is set the appropriate byte
> > selects.  The platform doesn't care what the register size is, and the
> > target (PCI chip) seems to be able to figure it out, so there must be
> > something else wrong.
> > 
> > What is an XScale, btw?
> 
> XScale is a CPU branched off from the ARM family by Intel. Mostly you
> will see them in PDAs. However, there are other XScale platforms that
> are used as network processors or I/O processors.  I probably need to
> do some PCI-X sniffing but all I know currently is that after the
> writeb the mask register remains unchanged. However if I do a writel
> it changes. So currently if I load the driver as it is, I get
> infinitely interrupt calls because the irq isn't masked and the irq
> handler doesn't know what to do with the interrupt. Since this isn't
> really a fast path routine anyhow, wouldn't it be better to make all
> platforms happy?

The problem you have is that if you use writel, I think you'll be
subject to race conditions, unless you single thread updates of
the mask register among the different ports.  I don't know that they
are today (Jeff would), because different ports usually have separate
registers.

jeremy
