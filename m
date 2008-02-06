From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.26-git0: IDE oops during boot
Date: Wed, 6 Feb 2008 12:08:05 +0100
Message-ID: <20080206110805.GB3613@elf.ucw.cz>
References: <20080206105334.GA3664@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52680 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753042AbYBFLUb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Feb 2008 06:20:31 -0500
Content-Disposition: inline
In-Reply-To: <20080206105334.GA3664@elf.ucw.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Wed 2008-02-06 11:53:34, Pavel Machek wrote:
> Hi!
> 
> Trying to boot 2.6.25-git0 (few days old), I get
> 
> BUG: unable to handle kernel paging request at ffff..ffb0
> IP at init_irq+0x42e
> 
> Call trace:
> ide_device_add_all
> ide_generic_init
> kernel_init
> child_rip
> vgacon_cursor
> kernel_init
> child_rip
> 
> Excerpt from config:
> 
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y

Disabling CONFIG_IDE made my machine boot, as it was using libata
anyway.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
