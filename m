From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/3] ata: sata_mv: Fix probe failures with optional phys
Date: Sat, 1 Feb 2014 15:56:59 +0100
Message-ID: <20140201145659.GF26003@lunn.ch>
References: <0140131114857.GC26148@htj.dyndns.org>
 <1391264157-2112-1-git-send-email-andrew@lunn.ch>
 <1391264157-2112-3-git-send-email-andrew@lunn.ch>
 <20140201144457.GA20358@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49906 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932857AbaBAO5M (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Feb 2014 09:57:12 -0500
Content-Disposition: inline
In-Reply-To: <20140201144457.GA20358@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, tj@kernel.org, kishon@ti.com, linux-ide@vger.kernel.org

> IMHO, this new series look much better. However, I still think the above code
> is highly confusing (took me some time to see why you don't print the warning
> on PROBE_DEFER, but do the goto in all cases).
> 
> Would it be too much to ask to add some comments to it? Your previous
> explanation about why we need to fail on EPROBE_DEFER, to allow the phy
> driver to load, was great. Adding some of that here would be nice.

Hi Ezequiel

Anybody writing device drivers should know about EPROBE_DEFER.  If
they don't they are writing broken drivers. So putting in a comment
here would be just pointing out the obvious.

What i can however do is add a comment that devm_phy_get_optional()
returns a valid phy if there is no error. Might that help with the
confusion?

Thanks
	Andrew
