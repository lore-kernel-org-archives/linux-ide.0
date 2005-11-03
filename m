From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Incorrect device link for ide-cs
Date: Thu, 3 Nov 2005 10:57:15 +0100
Message-ID: <58cb370e0511030157l5e47a15h25832fb98e46173a@mail.gmail.com>
References: <4369D693.4040500@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.200]:62115 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932287AbVKCJ5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2005 04:57:19 -0500
Received: by nproxy.gmail.com with SMTP id q29so18057nfc
        for <linux-ide@vger.kernel.org>; Thu, 03 Nov 2005 01:57:15 -0800 (PST)
In-Reply-To: <4369D693.4040500@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>

Hi,

>      hw_regs_t hw;
>      memset(&hw, 0, sizeof(hw));
> -    ide_init_hwif_ports(&hw, io, ctl, NULL);
> +    ide_std_init_ports(&hw, io, ctl);

Could you separate this into another patch?

This change fixes ide-cs for some archs but OTOH we should verify that
there are no ide-cs specific hacks in ide_init_hwif_ports() on other archs.

Otherwise patch looks fine.

Thanks,
Bartlomiej
