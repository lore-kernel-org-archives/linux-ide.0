From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to
 devm_ioremap_resource()"
Date: Wed, 24 May 2017 16:36:12 +0300
Message-ID: <1495632972.6967.104.camel@linux.intel.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
         <87d1aywgrj.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:26531 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967094AbdEXNgQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 24 May 2017 09:36:16 -0400
In-Reply-To: <87d1aywgrj.fsf@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Wed, 2017-05-24 at 15:01 +0200, Gregory CLEMENT wrote:
> Hi Andrew,
>  
>  On mer., mai 24 2017, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > This reverts commit 368e5fbdfc60732643f34f538823ed4bc8829827.
> > 
> > devm_ioremap_resource() enforces that there are no overlapping
> > resources, where as devm_ioremap() does not. The sata phy driver
> > needs
> > a subset of the sata IO address space, so maps some of the sata
> > address space. As a result, sata_mv now fails to probe, reporting it
> > cannot get its resources, and so we don't have any SATA disks.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> For this patch as it fixes a regresssion:
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> However, as the same set of register are accessed by two drivers, is
> there a risk for a race condition ?
> 
> In this case we may consider to use a regmap.
> 
> Or maybe they never aces the same register ?

I'm wondering where exactly first resource acquiring is happening.

For me seems that the initial patch unhides the issue.

> 
> In this case it is safe to let the driver as is, but adding a comment
> could be useful.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
