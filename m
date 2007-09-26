From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_via: kill SATA_PATA_SHARING register handling
Date: Tue, 25 Sep 2007 22:27:21 -0400
Message-ID: <46F9C389.400@garzik.org>
References: <20070921085544.GE10660@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:52206 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbXIZC1X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Sep 2007 22:27:23 -0400
In-Reply-To: <20070921085544.GE10660@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> The SATA_PATA_SHARING register doesn't have anything to do with the
> SATA part of the controller.  It indicates whether an extern SATA PHY
> is attached to the PATA part of the controller and if so how it is
> wired.  As the PATA part is driven by pata_via, sata_via has no reason
> to care about that.  Also, pata_via should work fine under all
> configurations.
> 
> This patch removes unnecessary attach failures.  It seems recent via
> chipsets are defaulting to different values or are actually connected
> to SATA PHY triggering this more often.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/sata_via.c |   16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

applied to #upstream


