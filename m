From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] cy82c693: fix PCI device selection
Date: Wed, 12 Oct 2011 15:02:07 -0400 (EDT)
Message-ID: <20111012.150207.1100668688848833225.davem@davemloft.net>
References: <201110111937.32501.bzolnier@gmail.com>
	<20111011.152040.662786307819949300.davem@davemloft.net>
	<201110121652.10495.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:46216 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab1JLTCL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 15:02:11 -0400
In-Reply-To: <201110121652.10495.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Wed, 12 Oct 2011 16:52:10 +0200

> David Miller wrote:
> 
>> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> Date: Tue, 11 Oct 2011 19:37:32 +0200
>> 
>> > While at it remove redundant pci_get_slot() call as cy82c693_init_one()
>> > already takes care of keeping the reference on the second port's PCI
>> > device.
>> 
>> Please do not submit unrelated changes with a bug fix, and as IDE is
>> in long-term maintainence I would not accept a risky refinement like
>> this anyways.
> 
> Removed code is just bogus, we cannot fail in ->set_pio_mode method.
> 
> Please take a look at the code:
>  
> -	/* select primary or secondary channel */
> -	if (hwif->index > 0) {  /* drive is on the secondary channel */
> -		dev = pci_get_slot(dev->bus, dev->devfn+1);
> -		if (!dev) {
> -			printk(KERN_ERR "%s: tune_drive: "
> -				"Cannot find secondary interface!\n",
> -				drive->name);
> -			return;
> -		}
> -	}
> 
> Please apply the patch,

Sorry, I will not do that, please respin the patch with the unrelated
pieces removed.  I don't care how obvious it is to you.

The IDE layer is not a place for refinements or simplifications any
longer, I'm sorry if that isn't clear to you.


