From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Serial ATA SIS 964
Date: Mon, 23 Feb 2004 20:21:43 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <403AA727.6030005@pobox.com>
References: <1077531578.681.21.camel@uk2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262173AbUBXBV4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Feb 2004 20:21:56 -0500
In-Reply-To: <1077531578.681.21.camel@uk2.local>
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> Hello,
> 
> i have written a driver for the SIS 180 Controller (included into SIS964
> Southbridge), Motherboard is K7S8XE+.
> The Driver is libata-based, running under Kernel 2.6.3
> 
> The driver works with programmed IO without problems.
> My Problem:
> The busmuster dma does not works. I think i must do some special
> initialization like the SIS 5513 driver, but i dont have any information
> about this chip.


SiS sent me docs and a board...  wanna post your driver?  :)

	Jeff



