From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Tue, 16 Aug 2005 13:55:58 +0100
Message-ID: <1124196958.17555.8.camel@localhost.localdomain>
References: <200508111424.43150.bjorn.helgaas@hp.com>
	 <1123836012.22460.16.camel@localhost.localdomain>
	 <200508151507.22776.bjorn.helgaas@hp.com>
	 <58cb370e050816023845b57a74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:28887 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932680AbVHPM2l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Aug 2005 08:28:41 -0400
In-Reply-To: <58cb370e050816023845b57a74@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org

On Maw, 2005-08-16 at 11:38 +0200, Bartlomiej Zolnierkiewicz wrote:
> * removing IDE_ARCH_OBSOLETE_INIT define has some implications,
>   * non-functional ide-cs driver (but there is no PCMCIA on IA64?)

IA64 systems can support PCI->Cardbus/PCMCIA cards so they do actually
need this support. They could also do with cardbus IDE support but that
means a whole pile of patches still although the refcounting stuff means
its a lot closer to doable now

>   * ordering change for ide-pnp interfaces in case of no IDE devices
>     on default IDE PCI ports, (but there aren't any ide-pnp devices on IA64?)

No ISAPnP

