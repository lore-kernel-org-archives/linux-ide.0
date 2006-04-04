From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: module reloading doesn't work
Date: Mon, 03 Apr 2006 22:47:07 -0400
Message-ID: <4431DE2B.1020306@rtr.ca>
References: <20060402155647.GB20270@localdomain> <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com> <20060403215729.GA17731@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:30597 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S964963AbWDDCrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Apr 2006 22:47:49 -0400
In-Reply-To: <20060403215729.GA17731@localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Aloni <da-x@monatomic.org>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Linux Kernel List <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>

Dan Aloni wrote:
>
>  * Normal boot
>  * insmod sata_mv
>  * all is okay, as expected
>  * rmmod sata_mv
>  * insmod sata_mv 
>  * all is bad, as expected
>  * kexec
>  * insmod sata_mv
>  * all is bad!
> 
> Conclusion: sata_mv's shutdown does something bad.

sata_mv seems to just use the default libata shutdown sequence,
so perhaps it's leaving the device in EDMA mode with interrupt
coalescing still on (from the BIOS), and interrupts are still
coming in or something..

I suppose it really ought to shut down the device before exiting,
and maybe the default of pci_disable_device() is not enough.. ?

Cheers

