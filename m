From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: fix drive side 80c cable check, take 2
Date: Thu, 12 Jul 2007 22:34:16 +0400
Message-ID: <46967428.5090402@ru.mvista.com>
References: <20070205074713.GF1625@htj.dyndns.org> <20070205111837.1981bda2@localhost.localdomain> <20070205124713.GL1625@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:36690 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754526AbXGLScQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jul 2007 14:32:16 -0400
In-Reply-To: <20070205124713.GL1625@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, stable@kernel.org, linux-ide@vger.kernel.org

Hello.

Tejun Heo wrote:

> eighty_ninty_three() had word 93 validitity check but not the 80c bit
> test itself (bit 12).  This increases the chance of incorrect wire
> detection especially because host side cable detection is often
> unreliable and we sometimes soley depend on drive side cable
> detection.  Fix it.

> Signed-off-by: Tejun Heo <htejun@gmail.com>

> diff --git a/drivers/ide/ide-iops.c b/drivers/ide/ide-iops.c
> index badde63..6558055 100644
> --- a/drivers/ide/ide-iops.c
> +++ b/drivers/ide/ide-iops.c
> @@ -607,6 +607,8 @@ u8 eighty_ninty_three (ide_drive_t *drive)
>  	if(!(drive->id->hw_config & 0x4000))
>  		return 0;
>  #endif /* CONFIG_IDEDMA_IVB */
> +	if (!(drive->id->hw_config & 0x2000))
> +		return 0;

    Haha, you know just *why* this was wrong? Bit 13 of the word 93 when *set* 
means 40c cable, not 80c!  Look at the table 9 in ATA/PI-6, for example, and 
then into the bit description in the table 27.

>  	return 1;
>  }

MBR, Sergei
