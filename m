From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Libata PATA status
Date: Wed, 4 Jul 2007 15:29:30 +0200
Message-ID: <20070704132930.GB10904@one.firstfloor.org>
References: <20070703185116.59c8f5f5@the-village.bc.nu> <p73k5tg2uj9.fsf@bingen.suse.de> <20070704131746.4bbe4d0e@the-village.bc.nu> <20070704130258.GA10904@one.firstfloor.org> <20070704141819.01a357fa@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:33160 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759239AbXGDN3c (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 09:29:32 -0400
Content-Disposition: inline
In-Reply-To: <20070704141819.01a357fa@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

> You could probably reliably map "hda/b/c/d" initially with some kind of
> forwarder providing nobody hot plugged them.  Just not sure I see the

PATA hotplug? 

SATA systems typically already use /dev/sda*, it just applies to PATA.

> point of doing it kernel side.

The point would be that old user land just works without any changes.
I know that is a virtue that has gone out of fashion recently
with udev and sysfs, but older distributions that weren't
that sysfs-layout-of-the-week dependent used to be fairly kernel version
independent.  I always found that very useful.

The hda->sda move would be the only "radical" change that prevents booting for
a long time (the last one before that was the 2.5 modutils transition)

-Andi

