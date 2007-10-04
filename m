From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sata Sil3512 bug?
Date: Thu, 04 Oct 2007 10:27:18 +0900
Message-ID: <47044176.80803@gmail.com>
References: <1097480701.20070927155135@zonnet.nl> <46FCF2A1.30204@gmail.com> <1619914792.20070928172536@zonnet.nl> <20070928165150.2a93524e@the-village.bc.nu> <46FD3213.6050204@gmail.com> <1128907118.20071002212023@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:6896 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbXJDB12 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2007 21:27:28 -0400
Received: by an-out-0708.google.com with SMTP id d31so752and
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2007 18:27:27 -0700 (PDT)
In-Reply-To: <1128907118.20071002212023@zonnet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: MisterE <MisterE2002@zonnet.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

Hello,

MisterE wrote:
> I build another setup with almost the same hardware.
> This motherboard had already the latest bios.
> I notice that the computer does almost never find the hard drive
> although the controller is found every time (with lspci).

What do you mean by "almost never"?  Does it find the harddisk
sometimes?  Also, please post kernel boot log after disk detection
failure.  lspci result just indicates only that the PCI device is present.

> So i get no
> drive (sda) assigned. I don't always see the "bios" screen from the
> controller at startup. And in the past it showed the hard drive.
> So i could not experiment with this motherboard.

Can you re-seat the controller or move it to another slot and see
whether things change?

> After that i installed Windows XP and used the orginal (sweex)
> drivers with the first motherboard. This also makes the data corrupt.
> So it seems not to be an linux problem. So there is something wrong with
> the motherboard or the 3512 controller.
> 
> After that i plugged both hard drives (ide with windows and sata disk)
> to the Asus board. No data corruption. So the hard disks are'nt the
> problem either.

Hmmm... It's relieving to know that the problem isn't caused by sata_sil
but I don't have much idea than it seems like something goes wrong on
the PCI bus.  :-(

> I'm thinking of replacing both 3512 controllers with a Promise SATA300
> TX4. Do you know if there are problems with this device?

I see occasional bug reports on sata_promise but AFAIK there haven't
been any data corruption report.  Mikael knows much better about promise
controllers.

Thanks.

-- 
tejun
