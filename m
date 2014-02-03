From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Mon, 3 Feb 2014 11:21:39 -0500
Message-ID: <20140203162139.GE30250@htj.dyndns.org>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
 <20140203160315.GB30250@htj.dyndns.org>
 <20140203162010.GE8038@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:56396 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbaBCQVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Feb 2014 11:21:43 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so10160315qab.23
        for <linux-ide@vger.kernel.org>; Mon, 03 Feb 2014 08:21:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140203162010.GE8038@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: kishon@ti.com, linux-ide@vger.kernel.org

On Mon, Feb 03, 2014 at 05:20:10PM +0100, Andrew Lunn wrote:
> On Mon, Feb 03, 2014 at 11:03:15AM -0500, Tejun Heo wrote:
> > On Sat, Feb 01, 2014 at 03:15:57PM +0100, Andrew Lunn wrote:
> > > Make use of devm_phy_optional() in order to fix probe failures on
> > > Armada 370, XP and others, when there is no phy driver available.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Looks good to me from the ata side.  How should these be routed?  I
> > can take them through libata/for-3.14-fixes once phy people ack the
> > changes or the other way around is fine too.
> 
> Hi Tejun
> 
> There should be a v2 today. I don't care too much how it goes in, but
> we should aim to get them in by -rc2 since we have quite a few broken
> platforms at the moment.

I'm okay either way.  If the phy tree wants to take it, please feel
free to add my Acked-by when posting v2.

Thanks.

-- 
tejun
