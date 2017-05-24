From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 16:11:14 +0200
Message-ID: <874lwawdj1.fsf@free-electrons.com>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
        <87d1aywgrj.fsf@free-electrons.com>
        <1495632972.6967.104.camel@linux.intel.com>
        <20170524134127.GB26577@lunn.ch>
        <1495634404.6967.109.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41788 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940388AbdEXOLQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 24 May 2017 10:11:16 -0400
In-Reply-To: <1495634404.6967.109.camel@linux.intel.com> (Andy Shevchenko's
        message of "Wed, 24 May 2017 17:00:04 +0300")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Tejun Heo <tj@kernel.org>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

Hi Andy,
 
 On mer., mai 24 2017, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, 2017-05-24 at 15:41 +0200, Andrew Lunn wrote:
>> > I'm wondering where exactly first resource acquiring is happening.
>> 
>> drivers/phy/phy-mvebu-sata.c
>> 
>
> In which tree? I have nothing like this in linux-next.

in v4.12-rc2 it still exist:
http://elixir.free-electrons.com/linux/v4.12-rc2/source/drivers/phy/phy-mvebu-sata.c

Gregory

>
> I'm on the side that revert just hides the real issue back.
>
> So, it looks like better to remove exclusivity from platform core
> instead.
>
> -- 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
