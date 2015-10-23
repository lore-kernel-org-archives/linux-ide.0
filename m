From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 00/10] add support SATA for BMIPS_GENERIC
Date: Fri, 23 Oct 2015 13:35:11 -0700
Message-ID: <20151023203511.GN13239@google.com>
References: <1445564663-66824-1-git-send-email-jaedon.shin@gmail.com>
 <20151023035817.GA18907@mtj.duckdns.org>
 <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33767 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbJWUfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2015 16:35:14 -0400
Content-Disposition: inline
In-Reply-To: <CAGVrzcYLeoXDPkMKvAtfok1dwgGQDu06FxP05u6YiO9-nHJqqw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>

On Thu, Oct 22, 2015 at 09:51:30PM -0700, Florian Fainelli wrote:
> 2015-10-22 20:58 GMT-07:00 Tejun Heo <tj@kernel.org>:
> I think we have a bit too many compatible strings defined, I need to
> lookup tomorrow when I am back in the office which BCM7xxx started
> featuring a SATA3 AHCI compliant core, it might be 7420, but I am not
> sure

I thought it was BCM7425, but you probably have the resources to check
better than I do.

There were also some small (probably mostly undocumented) bugfixes at
some point. I think the early cores actually had problems with the
upstream libahci. You might look at AHCI_HFLAG_DELAY_ENGINE for that, if
you care.

You might also notice that the "strict-ahci" stuff we were using got
dropped:

commit f1df8641e27b7edb978bdc7aaf50c235bc9e8be9
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Sat Feb 22 17:22:53 2014 +0100

    ahci_platform: Drop support for ahci-strict platform device type

But that's less relevant, now that there's a proper brcmstb driver.

Brian
