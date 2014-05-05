From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCHv3 5/5] ARM: configs: add ahci_mvebu to multi_v7_defconfig
Date: Mon, 5 May 2014 14:51:21 -0700
Message-ID: <20140505215121.GG29245@quad.lixom.net>
References: <1397574006-5868-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397574006-5868-6-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140426002518.GL28159@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:37942 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932595AbaEEVvQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2014 17:51:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id kx10so7525066pab.5
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2014 14:51:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140426002518.GL28159@titan.lakedaemon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Fri, Apr 25, 2014 at 08:25:18PM -0400, Jason Cooper wrote:
> Arnd, Olof, Kevin,
> 
> On Tue, Apr 15, 2014 at 05:00:06PM +0200, Thomas Petazzoni wrote:
> > The Marvell Armada 38x platform needs the ahci_mvebu driver enabled
> > for the AHCI interfaces, so this commit enables the corresponding
> > Kconfig option in multi_v7_defconfig.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Conflict-ridden file, please take directly.
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

Just like many other maintainers, just getting added on cc on the ack doesn't
fit our work flows very well.

When I get one of these, I have to go hunting for the original patch on
whatever list it was posted on, verifying that it's indeed the right one,
and then apply it, and then add your ack.

It's much easier if we get the patch remailed to us, or resubmitted with the
ack and sent to us. It's how others (like Greg) tend to prefer to get patches
as well.

So, Thomas, care to resend us (arm@kernel.org) the patch with the ack
appended?  Thanks!


-Olof
