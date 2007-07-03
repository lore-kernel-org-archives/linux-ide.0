From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] pata_hpt3x3: Major reworking and testing
Date: Tue, 3 Jul 2007 22:12:01 +0200
Message-ID: <200707032212.01619.bzolnier@gmail.com>
References: <20070703161002.1576c39d@the-village.bc.nu> <200707031938.20956.bzolnier@gmail.com> <20070703185652.0b807fcc@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:28914 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbXGCU0z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 16:26:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so170452ugf
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 13:26:54 -0700 (PDT)
In-Reply-To: <20070703185652.0b807fcc@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jeff@garzik.org

On Tuesday 03 July 2007, Alan Cox wrote:
> > The new improved driver is not really better than the old one because
> > the old one is broken. :)
> > 
> > Old driver does identical configuration when it comes to PIO modes.
> 
> No the old driver doesn't even do that. It starts up. It spuriously
> adjusts some non writable PCI BAR registers, prints a message about
> resources being in use already then exits.

OK, thanks for clarifying this.

> I had a poke around the setup. As far as I can observe we break even if
> the ROM timing values are used as is. I suspect documentation or a good
> deal of luck is needed.

Yeah.

BTW the original Andre's driver had some references to misc configuration
registers at offsets 0x10 and 0x11 of PCI BAR4.

http://www.linuxhq.com/kernel/v2.3/10/drivers/block/hpt343.c

Does anybody have DOS driver for HPT343?  Google doesn't have it...

Thanks,
Bart
