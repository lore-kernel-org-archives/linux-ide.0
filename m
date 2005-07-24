From: Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: Support for the PATA port in sata_promise
Date: Sun, 24 Jul 2005 12:23:40 -0400
Message-ID: <355e5e5e050724092372cf8990@mail.gmail.com>
References: <1122193788.42e3517c7f059@www.hosting-agency.de>
Reply-To: Lukasz Kosewski <lkosewsk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.202]:17735 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261395AbVGXQXm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 24 Jul 2005 12:23:42 -0400
Received: by zproxy.gmail.com with SMTP id r28so438789nza
        for <linux-ide@vger.kernel.org>; Sun, 24 Jul 2005 09:23:40 -0700 (PDT)
In-Reply-To: <1122193788.42e3517c7f059@www.hosting-agency.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Simon Raffeiner <sturmflut@lieberbiber.de>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 7/24/05, Simon Raffeiner <sturmflut@lieberbiber.de> wrote:
> Hello,
> 
> I've got an Asus A8V Deluxe Mainboard with an onboard Promise SATA 378
> (PDC20378) controller. Because four PATA ports are never enough one of my hard
> disks is connected to the PATA port of the Promise chip. I use Ubuntu Linux
> 5.04 (Hoary) and after upgrading to kernel 2.6.11 the port stopped working. It
> seems that Ubuntu kernel 2.6.10 contains a version of the sata_promise driver
> that features PATA support, but later that patch was dropped and also vanilla
> kernels up to 2.6.12.3 don't feature it.

If you want to use 2.6.11 (for stability?  Nostalgia?), check out the
2.6.11-libata-dev1 patch
(http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-libata-dev1.patch.bz2),
which added the PATA support.  If you don't mind testing the latest
and greatest, try Andrew Morton's -mm patch to the 2.6.13-rc3 kernel,
which also has the patch.  If you check the 'broken-out' patches which
Andrew has, you can grab just the patch itself and modify it to
whatever kernel you want to apply it to, but unless you know what
you're doing I wouldn't recommend that route.

> Some other distributions seem to include a PATA-enabled version, but when will
> support for the PATA port be included in vanilla kernels? The version Ubuntu
> kernel 2.6.10 uses works fine. Unfortunately it is not compatible with newer
> vanilla kernels.

I guess that depends on when it's deemed stable, but I guess either
2.6.13 or 2.6.14.

Cheers,

Luke Kosewski
Human Cannonball
Net Integration Technologies
