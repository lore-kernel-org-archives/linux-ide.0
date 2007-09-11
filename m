From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes]: libata clear horkage on ata_dev_init()
Date: Mon, 10 Sep 2007 22:10:09 -0400
Message-ID: <46E5F901.8010404@garzik.org>
References: <20070903032011.GA16890@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59101 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757645AbXIKCKM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Sep 2007 22:10:12 -0400
In-Reply-To: <20070903032011.GA16890@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> dev->horkage should be cleared over device hotunplug/plug.  Clear it
> in ata_dev_init().
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |    1 +
>  1 file changed, 1 insertion(+)

applied


