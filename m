From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux hangs during IDE initialization at boot for 30 sec
Date: Thu, 03 Feb 2005 10:03:07 +0000
Message-ID: <1107332790.14787.118.camel@localhost.localdomain>
References: <200502011257.40059.brade@informatik.uni-muenchen.de>
	 <pan.2005.02.01.20.21.46.334334@surrey.ac.uk>
	 <1107299901.5624.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from clock-tower.bc.nu ([81.2.110.250]:62852 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S263006AbVBCLII
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Feb 2005 06:08:08 -0500
In-Reply-To: <1107299901.5624.28.camel@gaston>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ee21rh@surrey.ac.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, list linux-ide <linux-ide@vger.kernel.org>

On Maw, 2005-02-01 at 23:18, Benjamin Herrenschmidt wrote:
> On Tue, 2005-02-01 at 20:22 +0000, Richard Hughes wrote:
> > On Tue, 01 Feb 2005 12:57:33 +0100, Michael Brade wrote:
> I suspect in your case, it's reading "ff", which indicates either that
> there is no hardware where the kernel tries to probe, or that there is
> bogus IDE interfaces which don't properly have the D7 line pulled low so
> that BUSY appears not set in absence of a drive.
> 
> I'm not sure how the list of intefaces is probed on this machine, that's
> probably where the problem is.

Known, fixed

There is a patch that allows probing for ISA ide4,5,6 etc only if there
is
no PCI bus

