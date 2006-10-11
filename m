From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: handle 0xff status properly
Date: Wed, 11 Oct 2006 17:16:28 +0100
Message-ID: <1160583388.16513.27.camel@localhost.localdomain>
References: <20061009093215.GF10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:949 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1161090AbWJKPvU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Oct 2006 11:51:20 -0400
In-Reply-To: <20061009093215.GF10832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Joe Jin <lkmaillist@gmail.com>

Ar Llu, 2006-10-09 am 18:32 +0900, ysgrifennodd Tejun Heo:
> libata waits for !BSY even when the status register reports 0xff.
> This causes long boot delays when D8 isn't pulled down properly.  This
> patch does the followings.
> 
> * don't wait if status register is 0xff in all wait functions
> 
> * make ata_busy_sleep() return 0 on success and -errno on failure.
>   -ENODEV is returned on 0xff status and -EBUSY on other failures.
> 
> * make ata_bus_softreset() succeed on 0xff status.  0xff status is not
>   reset failure.  It indicates no device.  This removes unnecessary
>   retries on such ports.  Note that the code change assumes unoccupied
>   port reporting 0xff status does not produce valid device signature.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Joe Jin <lkmaillist@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>

