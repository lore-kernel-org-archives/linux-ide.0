From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: Use the fixup layer to fix the various SI3112 hangs
Date: Fri, 05 Nov 2004 23:34:29 +0000
Message-ID: <1099697668.5564.82.camel@localhost.localdomain>
References: <1099672950.5630.59.camel@localhost.localdomain>
	 <58cb370e04110514594adcb6e2@mail.gmail.com>
	 <58cb370e041105152431299ff7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:36293 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261269AbUKFAhg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 5 Nov 2004 19:37:36 -0500
In-Reply-To: <58cb370e041105152431299ff7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

On Gwe, 2004-11-05 at 23:24, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 5 Nov 2004 23:59:09 +0100, Bartlomiej Zolnierkiewicz
> <bzolnier@gmail.com> wrote:
> > all fixup patches applied
> > (after merging into 2 changesets & cleanup)
> 
> and fixed bug preventing both fixups from correct working,
> fixup() must be called _before_ hwif_init() call!!!

Moving it is definitely better I agree there - it also allows fixup to
be used for irq mangling and sg table tweaks which couldn't be done
before. 

I don't see why ita a bug in the present situation - and the code
certainly works against 10rc1 and 2.6.9 that way but since moving it is
better I've no problem at all



