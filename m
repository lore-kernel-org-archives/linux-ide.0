From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to
 devm_ioremap_resource()"
Date: Thu, 25 May 2017 16:34:26 +0300
Message-ID: <1495719266.6967.120.camel@linux.intel.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
         <87d1aywgrj.fsf@free-electrons.com>
         <1495632972.6967.104.camel@linux.intel.com>
         <20170524134127.GB26577@lunn.ch>
         <1495634404.6967.109.camel@linux.intel.com>
         <20170524142956.GE26577@lunn.ch>
         <1495716820.6967.111.camel@linux.intel.com> <20170525132639.GK1788@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:46626 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424225AbdEYNeb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 25 May 2017 09:34:31 -0400
In-Reply-To: <20170525132639.GK1788@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Thu, 2017-05-25 at 15:26 +0200, Andrew Lunn wrote:
> > > What issue? You are allowed to have overlapping memory resources.
> > 
> > Exactly, and then the question why did you do a revert?
> 
> Because we are at -rc2.

No, my point is that (repeating myself) revert just *hides* the actual
issue. 

Yes, I understand that it's a quick fix, and it should not be considered
as best solution.

>  We need a quick fix now, so that my NAS box
> disks start spinning again. You can then spend some time to consider a
> better fix, and get it merged in the 4.13 merge window.
> 

> Please feel free to Cc: me and the other Marvell maintainers on
> patches, so we can test them.

I'm not going to do that since I have no such issue, no possibility to
test and actually choose best strategy with your hardware.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
