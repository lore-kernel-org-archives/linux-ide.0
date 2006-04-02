From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 6/7] libata: improve ata_bus_probe()
Date: Sun, 02 Apr 2006 06:47:23 -0400
Message-ID: <442FABBB.80203@pobox.com>
References: <11439680863401-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:3054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932310AbWDBKr1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Apr 2006 06:47:27 -0400
In-Reply-To: <11439680863401-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> +
> + fail:
> +	switch (rc) {
> +	case -EINVAL:
> +	case -ENODEV:
> +		tries[dev->devno] = 0;
> +		break;
> +	case -EIO:
> +		ata_down_sata_spd_limit(ap);


I starting to think that separating ata_down_sata_spd_limit() from the 
actual phy programming is a bad idea.

However, I'm not going to NAK it just yet, we'll see where this goes.

	Jeff


