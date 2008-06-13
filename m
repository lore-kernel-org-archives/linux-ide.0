From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ahci: workarounds for mcp65
Date: Fri, 13 Jun 2008 02:43:10 -0400
Message-ID: <485216FE.3010404@garzik.org>
References: <484D4880.2050103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40302 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbYFMGnP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 02:43:15 -0400
In-Reply-To: <484D4880.2050103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>, Peer Chen <pchen@nvidia.com>

Tejun Heo wrote:
> MCP65 ahci can do NCQ but doesn't set the CAP bit and rev A0 and A1
> can't do MSI but have MSI capability.  Implement AHCI_HFLAG_YES_NCQ
> and apply appropriate workarounds.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Peer Chen <pchen@nvidia.com>
> ---
>  drivers/ata/ahci.c |   40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)

applied


