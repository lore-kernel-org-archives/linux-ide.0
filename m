From: Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.24-rc1, sata_nv: MCP51 is boned with SWNCQ too
Date: Thu, 25 Oct 2007 06:48:06 -0400
Message-ID: <47207466.6030507@garzik.org>
References: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51189 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350AbXJYKsJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Oct 2007 06:48:09 -0400
In-Reply-To: <34545.86.7.220.119.1193306052.squirrel@wmbeta.mxes.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew <andrew@nelless.net>
Cc: linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Andrew wrote:
> Hi,
> 
> I've noticed a thread reporting that SWNCQ can't be disabled
> on the sata_nv.
> 
> Gerhard Dirschl
> *	BUG: sata_nv swncq cannot be disabled
> 
> and another with a patch switching MCP61 to GENERIC instead
> of SWNCQ
> 
> Kuan Luo
> *	[PATCH] ata: sata_nv MCP61 using GENERIC instead of SWNCQ
> 
> 
> I would like to to report that the MCP51 on my Asus A8NVM CSM
> mainboard is dead due to timeouts with SWNCQ. Reverting sata_nv.c
> to the version prior to git commit
> f140f0f12fc8dc7264d2f97cbe663564e7d24f6d works around the problem.
> 
> My drives are all Seagate drives, ST3320620AS, ST3500630AS,
> ST3300831AS.


Really?  That's a showstopper bug, as swncq is supposed to be disabled 
by default.

	Jeff


