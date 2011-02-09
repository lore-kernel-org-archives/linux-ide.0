From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: reduce ata_pci_[sff,bmdma]_init_one() size
Date: Wed, 9 Feb 2011 21:17:38 +0000
Message-ID: <20110209211738.2b363dca@lxorguk.ukuu.org.uk>
References: <201102091515.22677.bzolnier@gmail.com>
	<4D52F43F.5040507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35640 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753691Ab1BIVNq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2011 16:13:46 -0500
In-Reply-To: <4D52F43F.5040507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>     Perhaps this will save even more:
> 
> 	if (bmdma)
> 		pci_set_master(pdev);
> 	rc = ata_pci_sff_activate_host(host, bmdma ? ata_bmdma_interrupt :
> 						     ata_sff_interrupt, sht);

gcc is usually smart enough to work that out - and it's definitely easier
to read as Bartlomiej has it.

I agree with the comment that libata-sata rather than ifdefs would be
good for the SATA bit as well btw.

And yes ADMA was designed for PATA
