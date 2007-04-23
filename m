From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] sl82c105: Switch to ref counting API
Date: Mon, 23 Apr 2007 18:04:02 +0400
Message-ID: <462CBCD2.3080302@ru.mvista.com>
References: <20070423145445.45f5dc6a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:63148 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754058AbXDWODH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Apr 2007 10:03:07 -0400
In-Reply-To: <20070423145445.45f5dc6a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org

Hello.

Alan Cox wrote:

> Not sure how this one got missed in the great purge some time ago but it
> did. 

> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc6-mm1/drivers/ide/pci/sl82c105.c linux-2.6.21-rc6-mm1/drivers/ide/pci/sl82c105.c
> --- linux.vanilla-2.6.21-rc6-mm1/drivers/ide/pci/sl82c105.c	2007-04-12 14:15:04.000000000 +0100
> +++ linux-2.6.21-rc6-mm1/drivers/ide/pci/sl82c105.c	2007-04-23 11:58:55.016516864 +0100
> @@ -349,7 +349,7 @@
>  	/*
>  	 * The bridge should be part of the same device, but function 0.
>  	 */
> -	bridge = pci_find_slot(dev->bus->number,
> +	bridge = pci_get_bus_and_slot(dev->bus->number,
>  			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));

   Isn't it better to use pci_get_slot()?

WBR, Sergei
