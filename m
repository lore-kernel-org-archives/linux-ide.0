From: jayakumar ide <jayakumar.ide@gmail.com>
Subject: Re: [RFC 2.6.13.1 1/1] Cleanup for CS5535 IDE driver
Date: Mon, 3 Oct 2005 15:56:25 +0800
Message-ID: <ed723e820510030056o36b4867drf0cfd724bb6e5f36@mail.gmail.com>
References: <200509230301.j8N31n7W019129@localhost.localdomain>
	 <58cb370e05092705114bf4504d@mail.gmail.com>
Reply-To: jayakumar ide <jayakumar.ide@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:57663 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932183AbVJCH40 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Oct 2005 03:56:26 -0400
Received: by zproxy.gmail.com with SMTP id 13so251177nzn
        for <linux-ide@vger.kernel.org>; Mon, 03 Oct 2005 00:56:25 -0700 (PDT)
In-Reply-To: <58cb370e05092705114bf4504d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On 9/27/05, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> On 9/23/05, jayakumar.ide@gmail.com <jayakumar.ide@gmail.com> wrote:
> > I think we can leave this as is because the cs5535 is a SOC companion that
> > doesn't have hotplug capability. Is that okay?
>
> Even if chipset itself doesn't have hotplug capability please
> abstract cable detection code to match future IDE core changes.

Ok. Will do.

>
> Please use __devinit:
> * there is fake PCI hotplug driver which allows you to hot(un)plug any devices
> * sparse complains about wrong __init usage

Will do.

> > +       /* If no DMA speed was available then disable DMA and use PIO. */
> > +       if (!speed) {
> > +               speed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>
> just return 0 and let cs5535_dma_check() take care of tuning PIO mode
>

Will do.

> > +       } else if ((id->capability & 8) || (id->field_valid & 2)) {
> > +fast_ata_pio:
> > +               speed = ide_get_best_pio_mode(drive, 255, 5, NULL);
>
> wrong arguments (max PIO is 4 not 5)

Oops. Corrected. I'll send these changes shortly.

Thanks,
jaya
