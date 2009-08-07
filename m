From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: [PATCH] kill @force_restart and refine CLO for ahci_kick_engine()
Date: Fri, 7 Aug 2009 16:04:01 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30E50F90@sshaexmb1.amd.com>
References: <1249628752.3413.6.camel@zm-desktop> <4A7BDE9F.6020408@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:39444
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755187AbZHGIEN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 04:04:13 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A7BDE9F.6020408@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> 
> Please make the subject look like,
> 
>  [PATCH #upstream] ahci: kill @force_restart....
> 
> Shane Huang wrote:
> > This patch refines ahci_kick_engine() after discussion with 
> Tejun about
> > FBS(FIS-based switching) support preparation:
> > a. Kill @force_restart and always kick the engine. The only 
> case where
> >    @force_restart is zero is when it's called from 
> ahci_p5wdh_hardreset()
> >    Actually at that point, BSY is pretty much guaranteed to be set.
> > b. If PMP is attached, ignore busy and always do CLO. (AHCI-1.3 9.2)
> > 
> > Signed-off-by: Shane Huang <shane.huang@amd.com>
> > Cc: Tejun Heo <tj@kernel.org>
> 
> And put the followings here
> ---
> DIFFSTAT OUTPUT
> 
> > 
> > diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > --- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
> > +++ b/drivers/ata/ahci.c	2009-08-06 17:36:59.000000000 +0800
> > @@ -1578,7 +1578,7 @@
> 
> and use -p when generating diffs.  It's usually best to generate diff
> from a git tree.
> 
> Other than the above peripheral issues,
> 
> Acked-by: Tejun Heo <tj@kernel.org>

 
OK, I will follow your suggestions next time when I submit patches,
for this patch, I will not re-submit.


Thanks
Shane

