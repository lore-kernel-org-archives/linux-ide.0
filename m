From: Tejun Heo <tj@kernel.org>
Subject: Re: [v3.14-rc3 BUG] 1) panic and 2) SATA not working (Was Re:
 [PATCH] ATA: SATA_MV: Add missing Kconfig select statememnt)
Date: Tue, 18 Feb 2014 17:50:52 -0500
Message-ID: <20140218225052.GH31892@mtj.dyndns.org>
References: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
 <1390420593-27697-1-git-send-email-andrew@lunn.ch>
 <20140129182035.GM30842@htj.dyndns.org>
 <20140217151315.GB2765@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33011 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbaBRWu5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 17:50:57 -0500
Received: by mail-qa0-f53.google.com with SMTP id cm18so24143076qab.40
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 14:50:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140217151315.GB2765@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org

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

Will push out soon.  Thanks.

-- 
tejun
