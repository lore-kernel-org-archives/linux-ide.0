From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ATIIXP support (SATA, ATA133)
Date: Fri, 17 Dec 2004 12:44:28 +0100
Message-ID: <58cb370e041217034449d1b2a9@mail.gmail.com>
References: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.199]:5966 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262788AbULQLo3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Dec 2004 06:44:29 -0500
Received: by wproxy.gmail.com with SMTP id 36so43400wra
        for <linux-ide@vger.kernel.org>; Fri, 17 Dec 2004 03:44:28 -0800 (PST)
In-Reply-To: <878y7x2qhq.fsf@kosh.ultra.csn.tu-chemnitz.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: linux-ide@vger.kernel.org

On Fri, 17 Dec 2004 11:01:05 +0100, Enrico Scholz
<enrico.scholz@informatik.tu-chemnitz.de> wrote:
> Hello,

Hi,

> are there plans to support newer ATI IXP chipsets? I mean:
> 
> * PCI 1002:4376 which is an ATA133 controller; this should probably work
>   with the already existing drivers/ide/pci/atiixp.c driver

Have you tested it?

> * PCI 1002:4379 which is a SATA controller; I verified that it works
>   with the drivers/ide/pci/atiixp.c driver of 2.6.9 also.

Care to make a patches for 1002:4376 and 1002:4379?

> * PCI 1002:436E and 1002:437A which are both SATA controller. I saw them
>   in the windoze driver file only and can not tell whether they work
>   with atiixp.c
> 
> Although at least one SATA chipset works with the IDE driver, an own
> driver using libata would be the better solution. Does there exist
> already something which can be tested?

At least some of ATi SATA chipsets are based on Silicon Image SATA
so it should be possible to use sata_sil.c for them.

Bartlomiej
