From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 3/5] sil24: use SRST for phy_reset
Date: Wed, 16 Nov 2005 09:46:07 -0500
Message-ID: <437B462F.80205@rtr.ca>
References: <20051116080505.GC22807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:48557 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030350AbVKPOqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Nov 2005 09:46:08 -0500
In-Reply-To: <20051116080505.GC22807@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> There seems to be no way to obtain device signature from sil24 after
> SATA phy reset and SRST is needed anyway for later port multiplier
> suppport.  This patch converts sil24_phy_reset to use SRST instaed.

Mmm.. I doubt that sil24 is the only SATA controller with
this issue.  The sata_qstor device, for example, requires PHY reset
*followed* by SRST if one wants to reliably detect a port multiplier.

Maybe the chipset drivers should simply do PHY / SRST as they're told,
and have libata-core ensure PHY + SRST before doing PM detection?

Cheers
