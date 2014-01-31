From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Fri, 31 Jan 2014 12:46:19 +0100
Message-ID: <20140131114619.GD26003@lunn.ch>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
 <20140131105411.GC26003@lunn.ch>
 <20140131110422.GA26148@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:49641 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753901AbaAaLq2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 31 Jan 2014 06:46:28 -0500
Content-Disposition: inline
In-Reply-To: <20140131110422.GA26148@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Fri, Jan 31, 2014 at 06:04:22AM -0500, Tejun Heo wrote:
> On Fri, Jan 31, 2014 at 11:54:11AM +0100, Andrew Lunn wrote:
> > EPROBE_DEFER: We need to fail the probe, but it is not fatal.
> > ENOSYS: No generic PHY framework, sata_mv can load.
> > ENODEV: No phy, probably because it is optional and not there, sata_mv can load.
> > ENOMEM, EINVAL, etc are real errors and should probably be fatal and
> > returned by the probe function.
> > 
> > So i could reverse the comparison, look for ENOSYS and ENODEV and
> > allow the probe to succeed and return the error in all other cases.
> 
> Or add a helper, e.g. is_phy_error_fatal(), so that the knowledge
> about specific error codes don't end up getting spread through the
> code base?

Hi Tejun

The problem here is there is a different between optional and non
optional phys. If it is not optional, ENODEV is fatal. If it is
optional ENODEV is not fatal. So it needs at least to be

bool is_phy_error_fatal(struct phy *phy, bool optional)

Also, EPROBE_DEFER is not fatal, but still needs the probe to return
an error code. So the code ends up something like

	phy = devm_phy_get(...);
   	if (IS_ERR(phy) {
      		if (is_phy_error_fatal(phy, true)) {
			dev_err(dev, "Fatal phy error);
	 		goto out;
      		}
		if (PTR_ERR(phy) == -EPROBE_DEFER)
			goto out;
	}

I can implement this if you want.

  Andrew
