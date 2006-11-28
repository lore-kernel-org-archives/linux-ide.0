From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: fix scsi_host_template in drivers
Date: Tue, 28 Nov 2006 03:42:45 -0500
Message-ID: <456BF685.3090004@pobox.com>
References: <20061122060411.GW2184@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7810 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S935698AbWK1Ims (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 03:42:48 -0500
In-Reply-To: <20061122060411.GW2184@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> This patch fixes the followings regarding sht usage in libata drivers.
> 
> * sht->max_sectors is overrided unconditionally in ->slave_configure.
>   There's no reason to set it to any value.
> 
> * Many LLDs are missing sht->slave_destroy.  The method is mandatory
>   to support device warm unplugging (echo 1 > /sys/.../delete).
>   Without it, libata might access released scsi device.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> 
> Another candidate for #upstream-fixes.

if you want stuff in #upstream-fixes, you have to cut the patch down to 
its bare minimum.  the max_sectors change in this case is a cleanup.

I ACK the patch, but ask:  would you prefer to split the patch, or just 
this into #upstream?


