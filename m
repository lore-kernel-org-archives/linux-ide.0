From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: ST340823A disk size issue
Date: Thu, 02 Aug 2007 16:17:54 +0400
Message-ID: <46B1CB72.1010501@ru.mvista.com>
References: <20070801092903.GA1199@nalle> <200708012234.03375.bzolnier@gmail.com> <20070801215003.GA1864@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:37094 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754345AbXHBMPz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 08:15:55 -0400
In-Reply-To: <20070801215003.GA1864@nalle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Mikko Rapeli wrote:

> diff -ru linux-2.6.22.1/drivers/ide/ide-disk.c linux-2.6.22.1.new/drivers/ide/ide-disk.c
> --- linux-2.6.22.1/drivers/ide/ide-disk.c	2007-07-10 21:56:30.000000000 +0300
> +++ linux-2.6.22.1.new/drivers/ide/ide-disk.c	2007-08-01 22:59:47.000000000 +0300
> @@ -502,6 +502,17 @@
>  			 capacity, sectors_to_MB(capacity),
>  			 set_max, sectors_to_MB(set_max));
>  
> +	if ((set_max % 2)

    I hope gcc will convert this to (set_max & 1) but it wouldn't hurt to code 
this explicitly.

>  && (set_max == capacity + 1)) {

    Wait, isn't set_max an address of a last sector, and isn't capacity a 
sector count? Shouldn't it be (set_max == capacity)?

> +		printk(KERN_INFO "Old drive detected, keeping current capacity.\n");
> +		return;
> +	}
> +
>  	if (lba48)
>  		set_max = idedisk_set_max_address_ext(drive, set_max);
>  	else

MBR, Sergei
