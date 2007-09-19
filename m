From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: Add a drivers/ide style  DMA disable
Date: Wed, 19 Sep 2007 17:40:54 +0100
Message-ID: <20070919174054.1ef27707@the-village.bc.nu>
References: <20070822233710.415faaf0@the-village.bc.nu>
	<46F145E1.1050107@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58013 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754770AbXISQd5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Sep 2007 12:33:57 -0400
In-Reply-To: <46F145E1.1050107@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, jeff@garzik.org

> This doesn't help distro installers with modular libata, as there's
> no good way to get the parameter to the driver. (libata.pata_dma=0
> just causes "unrecognized parameter" message on boot.)

And for how long have people been saying that Fedora needs to sort out
passing module parameters from the boot command line via anaconda ?

So I'm sorry but "Mummy my installer sucks" doesn't get sympathy.
Distribution problem not kernel.

Alan
