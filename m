From: Andreas Werner <andreas.werner@men.de>
Subject: Re: [v2 0/2] ata/libata-eh.c: introduce ATA_FLAG_NO_LOG_PAGE
Date: Tue, 8 Dec 2015 07:12:19 +0100
Message-ID: <20151208061214.GA25602@awelinux>
References: <cover.1449248754.git.andreas.werner@men.de>
 <20151207152630.GD9175@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.152]:27400 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932820AbbLHGO0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Dec 2015 01:14:26 -0500
Content-Disposition: inline
In-Reply-To: <20151207152630.GD9175@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andreas Werner <andreas.werner@men.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Mon, Dec 07, 2015 at 10:26:30AM -0500, Tejun Heo wrote:
> On Fri, Dec 04, 2015 at 06:12:24PM +0100, Andreas Werner wrote:
> > This patchset add a new ata port flag ATA_FLAG_NO_LOG_PAGE to be able
> > to blacklist ports/controller which e.g. locks up on a log page read.
> > 
> > This flag is added to the sata_fsl driver which is the first affected
> > one.
> > 
> > The lockup was detected on Freescale P1013/P1022, T4240 using a ATP
> > mSATA.
> > The device failed during initialisation if the SATA device includes the
> > devslp feature.
> > 
> > With this patchset, we blacklist the fsl sata controller and return
> > a error on any attempt to read a log page. This allows us to access
> > the mSATA.
> 
> Applied 1-2 to libata/for-4.4-fixes.
> 
> Thanks.
> 
> -- 
> tejun

Thanks Tejun for the discussion and that the patch was applied :-)

Regards
Andy
