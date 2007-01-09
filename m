From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/3] atiixp.c: add cable detection support for ATI IDE
Date: Tue, 09 Jan 2007 08:04:07 -0500
Message-ID: <45A392C7.1030309@garzik.org>
References: <5767b9100701060422p1abd1d21x606b758220815551@mail.gmail.com>	 <58cb370e0701061816s308155abw719a00d499f504ea@mail.gmail.com> <5767b9100701090453g51448661td14e4c05a4eceb2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34345 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbXAINEL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Jan 2007 08:04:11 -0500
In-Reply-To: <5767b9100701090453g51448661td14e4c05a4eceb2a@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Conke Hu <conke.hu@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, linux-ide@vger.kernel.org

Conke Hu wrote:
> ------------------------
> --- linux-2.6.20-rc4/drivers/ide/pci/atiixp.c.3    2007-01-09
> 15:37:42.000000000 +0800
> +++ linux-2.6.20-rc4/drivers/ide/pci/atiixp.c    2007-01-09
> 15:40:08.000000000 +0800
> @@ -291,8 +291,12 @@ fast_ata_pio:


Your patches are still getting word-wrapped...

	Jeff


