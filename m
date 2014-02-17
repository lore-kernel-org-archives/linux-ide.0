From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [v3.14-rc3 BUG] 1) panic and 2) SATA not working (Was Re:
 [PATCH] ATA: SATA_MV: Add missing Kconfig select statememnt)
Date: Mon, 17 Feb 2014 10:23:23 -0500
Message-ID: <20140217152323.GP7862@titan.lakedaemon.net>
References: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
 <1390420593-27697-1-git-send-email-andrew@lunn.ch>
 <20140129182035.GM30842@htj.dyndns.org>
 <20140217151315.GB2765@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33275 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750830AbaBQPXh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Feb 2014 10:23:37 -0500
Content-Disposition: inline
In-Reply-To: <20140217151315.GB2765@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 17, 2014 at 12:13:16PM -0300, Ezequiel Garcia wrote:
> On Wed, Jan 29, 2014 at 01:20:35PM -0500, Tejun Heo wrote:
> > On Wed, Jan 22, 2014 at 08:56:33PM +0100, Andrew Lunn wrote:
> > > SATA_MV depends on GENERIC_PHY. So if SATA_MV is built in, GENERIC_PHY
> > > cannot be modular. Fixes build error found by kbuild test robot.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Applied to libata/for-3.14-fixes.  Thanks.
> > 
> 
> Tejun, Jason:
> 
> The lack of this patch in -rc3, just made my Armada XP GP board panic.
> 
> The panic is the same as this one (reported on Kirkwood):
> http://www.spinics.net/lists/arm-kernel/msg308080.html
> 
> Which is fixed in linux-next (and should be in -rc4, right?) by:
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=8ad116e649b21a42e3cccfb3c1b8d5ea52ba19e5
> 
> The SATA won't get probed unless this commit from linux-next is also applied:
> 
> commit 49c8f1ffe26ffddfb7244a24db21c0b4a79e1c52
> Author: Andrew Lunn <andrew@lunn.ch>
> Date:   Wed Jan 22 20:56:33 2014 +0100
> 
>     ATA: SATA_MV: Add missing Kconfig select statememnt
> 
> I guess it felt through someone cracks...

Well, sort of.  By the time I saw it, and realized it should be kept
next to the phy series fixes, Tejun had already taken it.

Looking back, I don't have the patch in my inbox...

thx,

Jason.
