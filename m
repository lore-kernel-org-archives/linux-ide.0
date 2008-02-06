From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 2.6.26-git0: IDE oops during boot
Date: Wed, 6 Feb 2008 21:05:42 +0100
Message-ID: <200802062105.42929.bzolnier@gmail.com>
References: <20080206105334.GA3664@elf.ucw.cz> <20080206110805.GB3613@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:27735 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534AbYBFTv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 14:51:58 -0500
Received: by wa-out-1112.google.com with SMTP id v27so643707wah.23
        for <linux-ide@vger.kernel.org>; Wed, 06 Feb 2008 11:51:58 -0800 (PST)
In-Reply-To: <20080206110805.GB3613@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>


Hi,

On Wednesday 06 February 2008, Pavel Machek wrote:
> On Wed 2008-02-06 11:53:34, Pavel Machek wrote:
> > Hi!
> > 
> > Trying to boot 2.6.25-git0 (few days old), I get
> > 
> > BUG: unable to handle kernel paging request at ffff..ffb0
> > IP at init_irq+0x42e

init_irq? hmm...

> > Call trace:
> > ide_device_add_all

this comes from ide-generic
(Generic IDE host driver)

> > ide_generic_init
> > kernel_init
> > child_rip
> > vgacon_cursor
> > kernel_init
> > child_rip
> > 
> > Excerpt from config:
> > 
> > CONFIG_IDE=y
> > CONFIG_BLK_DEV_IDE=y
> 
> Disabling CONFIG_IDE made my machine boot, as it was using libata
> anyway.

Kamalesh/Pavel:

Could you try latest git and see if the OOPS is still there?

[ Yeah, I'm unable to reproduce it. :( ]

Thanks,
Bart
