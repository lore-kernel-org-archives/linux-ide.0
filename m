From: Andreas Werner <andreas.werner@men.de>
Subject: Re: libata-core: devslp fails on ATP mSATA
Date: Wed, 2 Dec 2015 10:33:10 +0100
Message-ID: <20151202093310.GE10207@awelinux>
References: <20151201092234.GB29791@awelinux>
 <20151201161715.GA12922@mtj.duckdns.org>
 <20151201190410.GA21252@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.117]:13907 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756930AbbLBJlp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Dec 2015 04:41:45 -0500
Content-Disposition: inline
In-Reply-To: <20151201190410.GA21252@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>, "Martin K. Petersen" <martin.petersen@oracle.com>

On Tue, Dec 01, 2015 at 02:04:10PM -0500, Tejun Heo wrote:
> On Tue, Dec 01, 2015 at 11:17:15AM -0500, Tejun Heo wrote:
> > So, I suppose this is a fallout from 9faa643855df ("libata: use
> > READ_LOG_DMA_EXT").  The description just says "we should try use it"
> > but is there any benefit from using NCQ variant of read log page?  I
> > mean, it's used during config and error handling, so it's not like
> > queueing is gonna help anything.  It ends up issuing NCQ commands on
> > controllers which don't support NCQ and causes failures on devices
> > which lie about supporting the feature.
> 
> Hmmm... so, the controller locks up on READ_LOG_EXT issued as pio?
> That's just weird.  I suppose you can blacklist the controller so that
> any attempt to read the log page fails without actually issuing the
> command.
> 
> Thanks.
> 
> -- 
> tejun

Hi,
yes since i am using 3.14 where the READ_LOG_DMA_EXT is not it, it
seems that the controller locks up even on READ_LOG_EXT as PIO.

I have checked the current ERRATA sheet of the CPU but there
are no issues regarding this problem.

Test on a Freescale T4240 show the same behaviour as on P1013/P1022.
It seems that some FSL Cpus are affected.
I have asked my FAE at Freescale if he has some information about
that kind of issue.

Blacklisting the controller would be a solution yes, but I just
wanna wait the answer from the FAE to be sure we really have a
problem.

What kind of identifier can I use for blacklisting? The driver name
from the host driver? (fsl-sata) I did not find any register
in the sata controller to read out an ID.

Regards
Andy


