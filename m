From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Use the fixup layer to fix the various SI3112 hangs
Date: Sat, 06 Nov 2004 00:50:47 +0000
Message-ID: <1099702245.5630.92.camel@localhost.localdomain>
References: <1099672950.5630.59.camel@localhost.localdomain>
	 <58cb370e04110514594adcb6e2@mail.gmail.com>
	 <58cb370e041105152431299ff7@mail.gmail.com>
	 <1099697668.5564.82.camel@localhost.localdomain>
	 <58cb370e04110517005a88562e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:42693 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261285AbUKFBxw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 20:53:52 -0500
In-Reply-To: <58cb370e04110517005a88562e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sad, 2004-11-06 at 01:00, Bartlomiej Zolnierkiewicz wrote:
> It depends which fixup you are talking about...
> 
> undecoded slave: hwif_init()->init_gendisk()-> drive->present checked
> (sysfs and devfs entries registered for "ghost" drive but fixup works)
> 
> siimage: hwif_init()->init_irq()->ide_init_queue()-> hwif->rqsize used
> (so fixup was executed too late previously)

Ok yes I missed that.

