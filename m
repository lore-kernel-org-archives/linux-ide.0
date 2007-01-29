From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] libata IORDY handling
Date: Mon, 29 Jan 2007 13:34:23 +0000
Message-ID: <20070129133423.75aa208e@localhost.localdomain>
References: <200701282024.17518.sshtylyov@ru.mvista.com>
	<45BCEA03.8070901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33632 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751303AbXA2NWn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Jan 2007 08:22:43 -0500
In-Reply-To: <45BCEA03.8070901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com

>     It's sad to say but there's another bug in this function (even a 
> regression from drivers/ide/pci/siimage.c) -- the 16-bit IORDY is not enabled 
> when setting PIO mode (there's code that twiddles IORDY enable but that's 
> actually only for *taskfile* accesses, 16-bit IORDY is controlled by the same 
> PCI  config. registers 80h/84h that enable DMA/UDMA transfer on SiI 680).

Fixed - also fixed clearing the bits when going into PIO mode from DMA,
which fixes a potential DMA changedown bug.

Also redone the iordy stuff as your emails reminded me that it needed
finishing off and sorting out.

Alan
