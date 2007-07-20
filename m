From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 15/21] libata: improve SATA PHY speed down logic
Date: Fri, 20 Jul 2007 08:20:30 -0400
Message-ID: <46A0A88E.9020108@garzik.org>
References: <11845637802220-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50089 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365AbXGTMUc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:20:32 -0400
In-Reply-To: <11845637802220-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Tejun Heo wrote:
> sata_down_spd_limit() first reads the current SPD from SStatus and
> limit the speed to the lower one of one below the current limit or one
> below the current SPD in SStatus.  SPD may not be accessible or valid
> when SPD down is requested making sata_down_spd_limit() fail when it's
> most needed.
> 
> This patch makes the current SPD cached after each successful reset
> and forces GEN I speed (1.5Gbps) if neither of SStatus or the cached
> value is valid, so sata_down_spd_limit() is now guaranteed to lower
> the speed limit if lower speed is available.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   29 ++++++++++++++++++++++-------
>  drivers/ata/libata-eh.c   |    6 ++++++
>  include/linux/libata.h    |    1 +
>  3 files changed, 29 insertions(+), 7 deletions(-)

applied 15-16


