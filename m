From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kill @force_restart and refine CLO for ahci_kick_engine()
Date: Fri, 07 Aug 2009 16:58:23 +0900
Message-ID: <4A7BDE9F.6020408@kernel.org>
References: <1249628752.3413.6.camel@zm-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33303 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086AbZHGH4G (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 03:56:06 -0400
In-Reply-To: <1249628752.3413.6.camel@zm-desktop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: shane.huang@amd.com
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello, Shane.

Please make the subject look like,

 [PATCH #upstream] ahci: kill @force_restart....

Shane Huang wrote:
> This patch refines ahci_kick_engine() after discussion with Tejun about
> FBS(FIS-based switching) support preparation:
> a. Kill @force_restart and always kick the engine. The only case where
>    @force_restart is zero is when it's called from ahci_p5wdh_hardreset()
>    Actually at that point, BSY is pretty much guaranteed to be set.
> b. If PMP is attached, ignore busy and always do CLO. (AHCI-1.3 9.2)
> 
> Signed-off-by: Shane Huang <shane.huang@amd.com>
> Cc: Tejun Heo <tj@kernel.org>

And put the followings here
---
DIFFSTAT OUTPUT

> 
> diff -ruN a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> --- a/drivers/ata/ahci.c	2009-07-29 14:38:39.000000000 +0800
> +++ b/drivers/ata/ahci.c	2009-08-06 17:36:59.000000000 +0800
> @@ -1578,7 +1578,7 @@

and use -p when generating diffs.  It's usually best to generate diff
from a git tree.

Other than the above peripheral issues,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
