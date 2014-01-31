From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Fri, 31 Jan 2014 06:48:57 -0500
Message-ID: <20140131114857.GC26148@htj.dyndns.org>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
 <20140131105411.GC26003@lunn.ch>
 <20140131110422.GA26148@htj.dyndns.org>
 <20140131114619.GD26003@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:43134 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143AbaAaLtB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Jan 2014 06:49:01 -0500
Received: by mail-qa0-f45.google.com with SMTP id ii20so6084720qab.32
        for <linux-ide@vger.kernel.org>; Fri, 31 Jan 2014 03:49:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140131114619.GD26003@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Fri, Jan 31, 2014 at 12:46:19PM +0100, Andrew Lunn wrote:
> The problem here is there is a different between optional and non
> optional phys. If it is not optional, ENODEV is fatal. If it is
> optional ENODEV is not fatal. So it needs at least to be
> 
> bool is_phy_error_fatal(struct phy *phy, bool optional)
> 
> Also, EPROBE_DEFER is not fatal, but still needs the probe to return
> an error code. So the code ends up something like
> 
> 	phy = devm_phy_get(...);
>    	if (IS_ERR(phy) {
>       		if (is_phy_error_fatal(phy, true)) {
> 			dev_err(dev, "Fatal phy error);
> 	 		goto out;
>       		}
> 		if (PTR_ERR(phy) == -EPROBE_DEFER)
> 			goto out;
> 	}
> 
> I can implement this if you want.

Ugh... it's too ugly.  This really should be contained in phy layer.
How about introducing devm_phy_get_optional() which does the error
value interpretation inside it and just returns 0 if probing can go on
and -errno if it shouldn't.

Thanks.

-- 
tejun
