From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to
 devm_ioremap_resource()"
Date: Thu, 25 May 2017 15:53:40 +0300
Message-ID: <1495716820.6967.111.camel@linux.intel.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
         <87d1aywgrj.fsf@free-electrons.com>
         <1495632972.6967.104.camel@linux.intel.com>
         <20170524134127.GB26577@lunn.ch>
         <1495634404.6967.109.camel@linux.intel.com>
         <20170524142956.GE26577@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60351 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751220AbdEYM4x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 25 May 2017 08:56:53 -0400
In-Reply-To: <20170524142956.GE26577@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Wed, 2017-05-24 at 16:29 +0200, Andrew Lunn wrote:
> On Wed, May 24, 2017 at 05:00:04PM +0300, Andy Shevchenko wrote:
> > On Wed, 2017-05-24 at 15:41 +0200, Andrew Lunn wrote:
> > > > I'm wondering where exactly first resource acquiring is
> > > > happening.
> > > 
> > > drivers/phy/phy-mvebu-sata.c
> > > 
> > 
> > In which tree? I have nothing like this in linux-next.
> 
> git log drivers/phy/phy-mvebu-sata.c
> 
> It has been there since Tue Dec 17 21:21:50 2013.
> 
> > I'm on the side that revert just hides the real issue back.
> 
> What issue? You are allowed to have overlapping memory resources.

Exactly, and then the question why did you do a revert?

AFAIU the problem is that platform core tries to reserve the resource
and you can't do it twice for overlapping region (see insert_resource()
call implementation).

Since it's allowed and we have more devices which requires that
(basically that ones that have phy embedded in common address space) we
might reconsider the policy used in platform core.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
