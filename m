From: "Adrian McMenamin" <lkmladrian@gmail.com>
Subject: Re: [PATCH 2/3] Add GD-Rom support to the SEGA Dreamcast
Date: Thu, 20 Dec 2007 21:53:54 +0000
Message-ID: <8b67d60712201353y71a85498p9d77f1f21761856c@mail.gmail.com>
References: <8b67d60712151621j2101c411p19d75125c6d1c2f9@mail.gmail.com>
	 <20071216095019.GA12184@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:20029 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbXLTVxz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Dec 2007 16:53:55 -0500
Received: by py-out-1112.google.com with SMTP id u77so103785pyb.16
        for <linux-ide@vger.kernel.org>; Thu, 20 Dec 2007 13:53:54 -0800 (PST)
In-Reply-To: <20071216095019.GA12184@linux-sh.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Adrian McMenamin <lkmladrian@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, axboe@kernel.dk

On 16/12/2007, Paul Mundt <lethal@linux-sh.org> wrote:

>
> Also, __devinit/__devexit annotations?
>

Is there any difference between __init and __devint? I am using
__init/__exit already

> > +static struct platform_driver gdrom_driver = {
> > +     .probe = probe_gdrom,
> > +     .remove = remove_gdrom,
>
> __devexit_p()?
>
> > +static void __exit exit_gdrom(void)
> > +{
> > +     blk_cleanup_queue(gd.gdrom_rq);
> > +     free_irq(HW_EVENT_GDROM_CMD, &gd);
> > +     free_irq(HW_EVENT_GDROM_DMA, &gd);
> > +     del_gendisk(gd.disk);
> > +     if (gdrom_major)
> > +             unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
> > +     platform_device_unregister(pd);
> > +     platform_driver_unregister(&gdrom_driver);
> > +     if (gd.toc)
> > +             kfree(gd.toc);
> > +}
> > +
> Ah, here's where you do the rest of the cleanup. This is non-intuitive,
> remove should balance the work done by probe and exit the work done by
> init.
>
