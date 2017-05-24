From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to
 devm_ioremap_resource()"
Date: Wed, 24 May 2017 17:00:04 +0300
Message-ID: <1495634404.6967.109.camel@linux.intel.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
         <87d1aywgrj.fsf@free-electrons.com>
         <1495632972.6967.104.camel@linux.intel.com>
         <20170524134127.GB26577@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:28815 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965567AbdEXOAI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 24 May 2017 10:00:08 -0400
In-Reply-To: <20170524134127.GB26577@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

On Wed, 2017-05-24 at 15:41 +0200, Andrew Lunn wrote:
> > I'm wondering where exactly first resource acquiring is happening.
> 
> drivers/phy/phy-mvebu-sata.c
> 

In which tree? I have nothing like this in linux-next.

I'm on the side that revert just hides the real issue back.

So, it looks like better to remove exclusivity from platform core
instead.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
