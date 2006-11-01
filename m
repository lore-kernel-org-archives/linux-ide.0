From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: handle 0xff status properly
Date: Tue, 31 Oct 2006 23:50:16 -0500
Message-ID: <45482788.9050804@pobox.com>
References: <20061009093215.GF10832@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51162 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161302AbWKAEuU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2006 23:50:20 -0500
In-Reply-To: <20061009093215.GF10832@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Joe Jin <lkmaillist@gmail.com>

Tejun Heo wrote:
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

applied to #upstream


