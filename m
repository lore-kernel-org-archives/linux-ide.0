From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] Revert "ata: sata_mv: Convert to devm_ioremap_resource()"
Date: Wed, 24 May 2017 15:12:37 +0200
Message-ID: <20170524131237.GA24980@lunn.ch>
References: <1495582775-3717-1-git-send-email-andrew@lunn.ch>
 <87d1aywgrj.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:43000 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030200AbdEXNMp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 24 May 2017 09:12:45 -0400
Content-Disposition: inline
In-Reply-To: <87d1aywgrj.fsf@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jason Cooper <jason@lakedaemon.net>, linux-ide@vger.kernel.org

> However, as the same set of register are accessed by two drivers, is
> there a risk for a race condition ?

Hi Gregory

I checked this when i wrote the PHY driver.

phy_power_on() and phy_power_off() are only used in the probe and
remove function. Everything is done synchronously. So there is no
chance of a race.

       Andrew
 
