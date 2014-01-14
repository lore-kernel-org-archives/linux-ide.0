From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
Date: Tue, 14 Jan 2014 15:28:45 +0000
Message-ID: <20140114152845.GI15937@n2100.arm.linux.org.uk>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org> <20140114151404.GN19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:36601 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751413AbaANP26 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jan 2014 10:28:58 -0500
Content-Disposition: inline
In-Reply-To: <20140114151404.GN19878@titan.lakedaemon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Simon Guinot <simon.guinot@sequanux.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, stable@vger.kernel.org, linux-ide@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Tejun Heo <tj@kernel.org>, Gregory Clement <gregory.clement@free-electrons.com>, Jeff Garzik <jgarzik@redhat.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> Simon,
> 
> On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > Hello,
> > 
> > This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> > SoCs: once a disk is removed from a SATA port, then the re-plug events
> > are not detected by the sata_mv driver.
> > 
> > This should be applied to the -stable kernels 3.10 and onwards. 
> 
> Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> were both introduced in v3.6, so I would probably use:
> 
> Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Armada XP with DT)

Correction - it's format is:

Fixes: <commit-hash> ("oneline")

Double-quotes inside the parens.  (Don't ask me why, that's just how it
was decided.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
