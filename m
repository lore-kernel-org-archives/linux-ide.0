From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata-rb532-cf: fix signature of the xfer function
Date: Mon, 01 Dec 2008 14:24:35 -0500
Message-ID: <493439F3.7020309@garzik.org>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194600.2FDF7386B1A6@mail.ifyouseekate.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58995 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637AbYLATYk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Dec 2008 14:24:40 -0500
In-Reply-To: <20081128194600.2FDF7386B1A6@mail.ifyouseekate.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Phil Sutter wrote:
> Per definition, this function should return the number of bytes
> consumed. As the original parameter "buflen" is being decremented inside
> the read/write loop, save it in "retlen" at the beginning.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> Acked-by: Sergei Shtyltov <sshtylyov@ru.mvista.com>
> Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Acked-by: Florian Fainelli <florian@openwrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |    4 +++-

applied


