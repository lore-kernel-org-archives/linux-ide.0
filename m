From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: So, is there support for IDE devices that have no IRQ?
Date: Thu, 25 Mar 2004 01:04:10 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200403250104.10142.bzolnier@elka.pw.edu.pl>
References: <20040324232905.GA11286@buici.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:42193 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262561AbUCXX4F
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 24 Mar 2004 18:56:05 -0500
In-Reply-To: <20040324232905.GA11286@buici.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Marc Singer <elf@buici.com>
Cc: linux-ide@vger.kernel.org


Probing code uses polling but actual NODATA/PIO/DMA handlers require IRQ
so it needs much effort to make it work.

Cheers,
Bartlomiej

On Thursday 25 of March 2004 00:29, Marc Singer wrote:
> I'm getting the impression that there isn't.  I've got a system with
> compact flash and no interrupt line to the device.  Setting the
> hwif->irq value to -1 causes the kernel to crash, though there is a
> IDE_NO_IRQ constant.  I'm good to make this work, but I want to make
> sure that I'm heading in a reasonable direction.
>
> The thing that's confusing me is that I'm not getting an ide0 device
> even though I can see the code probing for drives.
>
> Cheers.

