From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Tue, 17 Aug 2010 18:01:58 +0100
Message-ID: <20100817180158.179e7780@lxorguk.ukuu.org.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	<4C6AB919.7060203@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51350 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753129Ab0HQQqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Aug 2010 12:46:44 -0400
In-Reply-To: <4C6AB919.7060203@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> ata_piix already has list of all the devices it supports, so maybe
> it's safe to grab all intel IDE devices from ata_generic?  ata_piix

I can't guarantee that and I'm not sure I can find anyone at Intel with
that deep a knowledge of the earliest chip errata.

> always has higher priority than ata_generic anyway and if a device
> isn't grabbed by ata_piix, we don't lose anything by grabbing it from
> ata_generic.

Priority only works if you know what is there to use, and the piix one is
for example broken if you change the bindings with sysfs. You don't for
example want to forget to compile in one driver and get generic when that
is unsafe.

The extreme example would be if you have ata_generic binding to all
devices and you forgot to compile in RZ1000 support. On the relevant
board that just ate your file system.

So the grab it all approach was dismissed.

> > Is it documented ? The instructions it was written to came from the
> > people who do the chips.
> 
> Yeap, that's much better, but I still think it would be better to
> avoid such detection magics if possible.

Well yes but the logic is simple.

0xF8 is non zero on all later Intel ATA PCI chipsets
0x40 is writable on all earlier Intel ATA PCI chipsets, and zero + non
writable on the IDE-R devices.

The other thing I did consider was submitting an Intel IDE-R driver that
contained the check and matched IDE CLASS & vendor == INTEL. That has the
advantage of not getting autoloaded unnecessarily so easily, but means we
have another driver.

Alan


