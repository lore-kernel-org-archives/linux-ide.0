From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Tue, 04 Dec 2007 14:34:11 -0500
Message-ID: <4755ABB3.6030907@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468202627-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40313 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbXLDTeN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:34:13 -0500
In-Reply-To: <11963468202627-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com

Tejun Heo wrote:
> ATAPI devices come with plethora of bugs and many ATA controllers have
> trouble dealing with odd byte DMA transfers.  The problem is currently
> somewhat masked by not allowing DMA transfers if the transfer size
> isn't aligned to 16 bytes plus partial masking in problematic LLDs.
> 
> This masking is taken verbatim from IDE and is far from perfection.
> There's no fundamental explanation why this should be sufficient and
> there are ATAPI devices which don't work with the IDE driver.
> 
> In addition, this mixture of PIO and DMA commands reduces test
> coverage which is already insufficient considering the crazy number of
> ATAPI devices out in the wild.
> 
> Also, these misc ATAPI commands usually transfer small amount of data
> and are used infrequently.  There isn't much to be gained from using
> DMA.  Combined with the fact that another OS which is probably the
> only one that most ATAPI device vendors test against uses PIO for
> these commands, it's much wiser to use PIO for these commands and
> concentrate debugging efforts on getting PIO right for misc commands
> and DMA for bulk transfer commands.
> 
> Private command type / transfer length filtering in sata_promise,
> pata_it821x and pata_pdc2027x are removed as core layer filtering is
> more conservative.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

The other patches were OK, but I'm still not happy about "punishing the 
good guys"


