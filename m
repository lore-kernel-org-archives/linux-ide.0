From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Make sure we scan SWARM IDE interface for devices
Date: Mon, 24 Jul 2006 20:26:47 +0400
Message-ID: <44C4F4C7.3070601@ru.mvista.com>
References: <20060720210449.GA5447@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:59460 "EHLO
	imap.sh.mvista.com") by vger.kernel.org with ESMTP id S1751301AbWGXQ2F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Jul 2006 12:28:05 -0400
In-Reply-To: <20060720210449.GA5447@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-ide@vger.kernel.org

Hello.

Martin Michlmayr wrote:
> From: Peter Horton <pdh@colonel-panic.org>

> [PATCH] Make sure we scan SWARM IDE interface for devices

> Signed-off-by: Peter Horton <pdh@colonel-panic.org>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> 
> 
> --- linux.git.orig/drivers/ide/mips/swarm.c	2006-01-23 22:48:58.000000000 +0000
> +++ linux.git/drivers/ide/mips/swarm.c	2006-01-24 08:32:45.000000000 +0000
> @@ -127,6 +127,7 @@
>  	memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
>  	hwif->irq = hwif->hw.irq;
>  
> +	probe_hwif_init(hwif);
>  	dev_set_drvdata(dev, hwif);
>  
>  	return 0;

    I think this should go right to Andrew Morton now...

WBR, Sergei

