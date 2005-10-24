From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: toshiba satellite 335CDT DMA not working
Date: Mon, 24 Oct 2005 14:17:33 +0200
Message-ID: <58cb370e0510240517r20bed4dbr5c3ab08dbc22a59b@mail.gmail.com>
References: <20051024113648.51667.qmail@web31005.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.207]:32157 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750963AbVJXMRg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Oct 2005 08:17:36 -0400
Received: by nproxy.gmail.com with SMTP id q29so129110nfc
        for <linux-ide@vger.kernel.org>; Mon, 24 Oct 2005 05:17:33 -0700 (PDT)
In-Reply-To: <20051024113648.51667.qmail@web31005.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Lynch <lynchaj@yahoo.com>
Cc: linux-ide@vger.kernel.org

Hi,

It is an ISA controller so DMA is not supported in Linux.

Toshiba has a dedicated Windows driver for this controller
so you would need to write a Linux driver to make DMA work.

Bartlomiej

On 10/24/05, Andrew Lynch <lynchaj@yahoo.com> wrote:
> Hi,
> I have a Toshiba Satellite 335CDT laptop. I cannot get
> the hda DMA to work with the ide controller. hdparm
> -d1 /dev/hda reports no IDE DMA and gives error
> message. The drive is capable of DMA according to
> hdparm -i.
>
> My problem appears closely related to this persons
> problem last February:
>
> http://marc.theaimsgroup.com/?t=110789166000004&r=1&w=2
>
> In short, the IDE controller does not appear in the
> PCI devices list (lspci) but it does appear in the PNP
> BIOS table of devices (lspnp). I believe the problem
> is that the IDE chipset is not recognized. I believe
> the default linux behavior is to not enable IDE DMA
> unless it recognizes the IDE chipset. I have tried all
> the IDE kernel modules including ide_generic with the
> same result.
>
> I am running Debian Testing with the default linux
> 2.6.12 kernel.
>
> Any suggestions on how to get this IDE chipset
> recognized by the linux kernel?
>
> I will post any additional information you request to
> help with this but it is all very similar to the prior
> posts.
>
> Thank you in advance for your help.
>
> Andrew Lynch
