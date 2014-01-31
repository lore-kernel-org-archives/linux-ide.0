From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ATA: SATA_MV: Fix probe failure when no phy exists
Date: Fri, 31 Jan 2014 06:04:22 -0500
Message-ID: <20140131110422.GA26148@htj.dyndns.org>
References: <1391115035-25960-1-git-send-email-andrew@lunn.ch>
 <20140130221228.GB1063@localhost>
 <20140131105411.GC26003@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:44302 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146AbaAaLEZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Jan 2014 06:04:25 -0500
Received: by mail-qc0-f181.google.com with SMTP id e9so6803049qcy.12
        for <linux-ide@vger.kernel.org>; Fri, 31 Jan 2014 03:04:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140131105411.GC26003@lunn.ch>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-ide@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On Fri, Jan 31, 2014 at 11:54:11AM +0100, Andrew Lunn wrote:
> EPROBE_DEFER: We need to fail the probe, but it is not fatal.
> ENOSYS: No generic PHY framework, sata_mv can load.
> ENODEV: No phy, probably because it is optional and not there, sata_mv can load.
> ENOMEM, EINVAL, etc are real errors and should probably be fatal and
> returned by the probe function.
> 
> So i could reverse the comparison, look for ENOSYS and ENODEV and
> allow the probe to succeed and return the error in all other cases.

Or add a helper, e.g. is_phy_error_fatal(), so that the knowledge
about specific error codes don't end up getting spread through the
code base?

Thanks.

-- 
tejun
