From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 08/14] libata: kill non-sg DMA interface
Date: Tue, 04 Dec 2007 14:31:41 -0500
Message-ID: <4755AB1D.3090206@garzik.org>
References: <1196346817387-git-send-email-htejun@gmail.com> <11963468192925-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40283 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbXLDTbv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 14:31:51 -0500
In-Reply-To: <11963468192925-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Rusty Russel <rusty@rustcorp.com.au>

Tejun Heo wrote:
> With atapi_request_sense() converted to use sg, there's no user of
> non-sg interface.  Kill non-sg interface.
> 
> * ATA_QCFLAG_SINGLE and ATA_QCFLAG_SG are removed.  ATA_QCFLAG_DMAMAP
>   is used instead.  (this way no LLD change is necessary)
> 
> * qc->buf_virt is removed.
> 
> * ata_sg_init_one() and ata_sg_setup_one() are removed.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Rusty Russel <rusty@rustcorp.com.au>

I would move the kill-non-sg-path changes to the front of the patchset


