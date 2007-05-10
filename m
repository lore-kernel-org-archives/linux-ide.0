From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_via: add missing PM hooks
Date: Wed, 09 May 2007 20:17:35 -0400
Message-ID: <4642649F.5080208@garzik.org>
References: <463B357A.4090703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50615 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759384AbXEJARh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 20:17:37 -0400
In-Reply-To: <463B357A.4090703@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, Jeroen Janssen <jeroen.janssen@gmail.com>

Tejun Heo wrote:
> For some reason, sata_via is missing PM hooks.  Add them.  Spotted by
> Jeroen Janssen <jeroen.janssen@gmail.com>.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Jeroen Janssen <jeroen.janssen@gmail.com>
> ---
> I have no idea how we missed this.  This is for both libata-dev &&
> -stable.  Thanks.

applied


