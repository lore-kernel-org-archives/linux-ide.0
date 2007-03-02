From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] pata_jmicron: drop unnecessary device programming
 in [re]init
Date: Thu, 01 Mar 2007 20:19:54 -0500
Message-ID: <45E77BBA.9040502@garzik.org>
References: <20070226110902.GD20322@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46271 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422671AbXCBBT5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Mar 2007 20:19:57 -0500
In-Reply-To: <20070226110902.GD20322@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, justin@jmicron.com

Tejun Heo wrote:
> Channel redirect and AHCI mode enable programmings are done via PCI
> quirk for both probe and resume paths.  Drop duplicate and possibly
> unsafe device programming from pata_jmicron().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/pata_jmicron.c |   32 +-------------------------------
>  1 file changed, 1 insertion(+), 31 deletions(-)

applied 1-3


