From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] IDE: Fix platform device registration in Swarm IDE
	driver
Date: Fri, 3 Oct 2008 19:25:43 +0100
Message-ID: <20081003182542.GA24989@linux-mips.org>
References: <20080922122853.GA15210@linux-mips.org> <20080928175450.GA8478@linux-mips.org> <48DFFC62.9050300@ru.mvista.com> <200810031900.55214.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ditditdahdahdah-dahditditditdit.dl5rb.org.uk ([217.169.26.26]:42563
	"EHLO ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751759AbYJCS0A (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 3 Oct 2008 14:26:00 -0400
Content-Disposition: inline
In-Reply-To: <200810031900.55214.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org

On Fri, Oct 03, 2008 at 07:00:54PM +0200, Bartlomiej Zolnierkiewicz wrote:

> > > The Swarm IDE driver uses a release method which is defined in the driver
> > > itself thus potentially oopsable.  The simple fix would be to just leak
> > > the device but this patch goes the full length and moves the entire
> > > handling of the platform device in the platform code and retains only
> > > the platform driver code in drivers/ide/mips/swarm.c.
> > >
> > > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> wow, v2 happened really quickly :)

It not just tidying up, it fixing a potencial crash so had to happen
quickly to (hopefully) make the release ...

> [ I removed no longer needed BLK_DEV_IDE_SWARM from ide/Kconfig while at it ]

Thanks!

  Ralf
