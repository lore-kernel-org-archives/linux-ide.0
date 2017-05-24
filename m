From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 16:29:56 +0200
Message-ID: <20170524142956.GE26577@lunn.ch>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
 <87d1aywgrj.fsf@free-electrons.com>
 <1495632972.6967.104.camel@linux.intel.com>
 <20170524134127.GB26577@lunn.ch>
 <1495634404.6967.109.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:43147 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdEXOaC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 24 May 2017 10:30:02 -0400
Content-Disposition: inline
In-Reply-To: <1495634404.6967.109.camel@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Wed, May 24, 2017 at 05:00:04PM +0300, Andy Shevchenko wrote:
> On Wed, 2017-05-24 at 15:41 +0200, Andrew Lunn wrote:
> > > I'm wondering where exactly first resource acquiring is happening.
> > 
> > drivers/phy/phy-mvebu-sata.c
> > 
> 
> In which tree? I have nothing like this in linux-next.

git log drivers/phy/phy-mvebu-sata.c

It has been there since Tue Dec 17 21:21:50 2013.

> I'm on the side that revert just hides the real issue back.

What issue? You are allowed to have overlapping memory resources.

     Andrew
