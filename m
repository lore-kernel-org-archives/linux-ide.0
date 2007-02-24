From: Jim Paris <jim@jtan.com>
Subject: Re: Disk stuck in error recovery loop with AHCI
Date: Sat, 24 Feb 2007 03:00:39 -0500
Message-ID: <20070224080039.GA25323@jim.sh>
References: <20070221052022.GA15964@jim.sh> <20070223072826.GA2763@jim.sh> <45DFBD9A.6090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:36123 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933422AbXBXIAl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 24 Feb 2007 03:00:41 -0500
Content-Disposition: inline
In-Reply-To: <45DFBD9A.6090204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jim Paris wrote:
> > Still, it seems that some improvements could be made to the EH when
> > this sort of thing happens.  For example, after "speed down requested
> > but no transfer mode left" a few times in a row, maybe it would make
> > sense to just fail the disk and give up.  That would have allowed
> > higher layers like MD to recover.
> 
> That's SD retrying sector-by-sector a large request as libata doesn't
> report proper failed sector info.  Please try 2.6.20.  md will fail the
> drive after a few errors.

Hi Tejun,

It was 2.6.20.  The system was stuck repeating EH for about half an
hour before I physically pulled the disk to get MD to fail the device
and to bring the system back to a responsive state.

> Patches to improve EH behavior further went into 2.6.21 devel tree and
> some are pending.

Great, I've hopefully eliminated the cause of my errors but I'll give
that a try if I run into this again.

-jim
