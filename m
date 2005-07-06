From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Date: Wed, 6 Jul 2005 16:35:11 +0200
Message-ID: <58cb370e05070607351fe5eced@mail.gmail.com>
References: <20050706133052.GF21330@wotan.suse.de>
	 <58cb370e050706070512c93ee1@mail.gmail.com>
	 <20050706140933.GH21330@wotan.suse.de>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.192]:195 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262246AbVGFOfN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 6 Jul 2005 10:35:13 -0400
Received: by nproxy.gmail.com with SMTP id n15so282230nfc
        for <linux-ide@vger.kernel.org>; Wed, 06 Jul 2005 07:35:11 -0700 (PDT)
In-Reply-To: <20050706140933.GH21330@wotan.suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, christoph@lameter.com

On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> > drive->hwif check is redundant, please remove it
> 
> It's not. My first version didn't have it but it still crashed.
> It's what actually prevents the crash.
> I also don't know why, but it's true.

very weird as HWIF(drive) == drive->hwif:

	ide_hwif_t *hwif = HWIF(drive);

...

	q = blk_init_queue_node(do_ide_request, &ide_lock,
				pcibus_to_node(drive->hwif->pci_dev->bus));
	if (!q)
		return 1;

...

	if (!hwif->rqsize) {

you should OOPS here

Bartlomiej
