From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] pata_cs5536: ATA driver for Geode companion chip
Date: Tue, 09 Oct 2007 21:25:42 -0400
Message-ID: <470C2A16.1040606@garzik.org>
References: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:48611 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751632AbXJJBZo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 9 Oct 2007 21:25:44 -0400
In-Reply-To: <yq14ph8xg3z.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <mkp@mkp.net>
Cc: linux-ide@vger.kernel.org

Martin K. Petersen wrote:
> This is a driver specifically for the ATA controller on the Geode
> CS5536 companion chip.  The PCI device ID for this device was
> previously claimed by pata_amd.c but there were two problems with
> that:
> 
>  - Not all Geode platforms emulate the ATA registers in PCI config
>    space
> 
>  - CS5536 PIO timings are not identical to AMD74XX/8111
> 
> pata_cs5536.c relies on Geode Machine Specific Registers to configure
> the ATA function and uses the correct PIO timings for the chip.
> 
> Signed-off-by: Martin K. Petersen <mkp@mkp.net>

Just FWIW...  one you guys are happy with things, I'm ready to merge the 
driver whenever.


