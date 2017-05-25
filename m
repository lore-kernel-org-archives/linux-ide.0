From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Thu, 25 May 2017 15:26:39 +0200
Message-ID: <20170525132639.GK1788@lunn.ch>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
 <87d1aywgrj.fsf@free-electrons.com>
 <1495632972.6967.104.camel@linux.intel.com>
 <20170524134127.GB26577@lunn.ch>
 <1495634404.6967.109.camel@linux.intel.com>
 <20170524142956.GE26577@lunn.ch>
 <1495716820.6967.111.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:44456 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965907AbdEYN0p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 25 May 2017 09:26:45 -0400
Content-Disposition: inline
In-Reply-To: <1495716820.6967.111.camel@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

> > What issue? You are allowed to have overlapping memory resources.
> 
> Exactly, and then the question why did you do a revert?

Because we are at -rc2. We need a quick fix now, so that my NAS box
disks start spinning again. You can then spend some time to consider a
better fix, and get it merged in the 4.13 merge window.

Please feel free to Cc: me and the other Marvell maintainers on
patches, so we can test them.

       Andrew
