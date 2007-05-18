From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 08/20] drivers/ata: remove the wildcard from sata_nv driver
Date: Thu, 17 May 2007 20:57:49 -0400
Message-ID: <464CFA0D.8090201@garzik.org>
References: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43698 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115AbXERA5w (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 May 2007 20:57:52 -0400
In-Reply-To: <200705110548.l4B5mnnx007636@shell0.pdx.osdl.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-ide@vger.kernel.org, pchen@nvidia.com, htejun@gmail.com

akpm@linux-foundation.org wrote:
> From: "Peer Chen" <pchen@nvidia.com>
> 
> Because nvidia SATA controllers onward base on AHCI, so wildcard in sata_nv
> driver is unnecessary.  Also the wildcard sometimes cause sata_nv driver to
> be loaded for AHCI controllers,which is not as expected.
> 
> Signed-off-by: Peer Chen <pchen@nvidia.com>
> Cc: Tejun Heo <htejun@gmail.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/ata/sata_nv.c |    6 ------
>  1 file changed, 6 deletions(-)

applied


