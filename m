From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon, 3 Feb 2014 17:20:10 +0100
Message-ID: <20140203162010.GE8038@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
 <20140203160315.GB30250@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:50362 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834AbaBCQU2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Feb 2014 11:20:28 -0500
Content-Disposition: inline
In-Reply-To: <20140203160315.GB30250@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, kishon@ti.com, linux-ide@vger.kernel.org

On Mon, Feb 03, 2014 at 11:03:15AM -0500, Tejun Heo wrote:
> On Sat, Feb 01, 2014 at 03:15:57PM +0100, Andrew Lunn wrote:
> > Make use of devm_phy_optional() in order to fix probe failures on
> > Armada 370, XP and others, when there is no phy driver available.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Looks good to me from the ata side.  How should these be routed?  I
> can take them through libata/for-3.14-fixes once phy people ack the
> changes or the other way around is fine too.

Hi Tejun

There should be a v2 today. I don't care too much how it goes in, but
we should aim to get them in by -rc2 since we have quite a few broken
platforms at the moment.

	  Andrew
