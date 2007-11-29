From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 08/14] libata: kill non-sg DMA interface
Date: Thu, 29 Nov 2007 16:00:45 +0000
Message-ID: <20071129160045.1912fc43@the-village.bc.nu>
References: <1196346817387-git-send-email-htejun@gmail.com>
	<11963468192925-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58295 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758914AbXK2QGD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 29 Nov 2007 11:06:03 -0500
In-Reply-To: <11963468192925-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Tejun Heo <htejun@gmail.com>, Rusty Russel <rusty@rustcorp.com.au>

On Thu, 29 Nov 2007 23:33:31 +0900
Tejun Heo <htejun@gmail.com> wrote:

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

Acked-by: Alan Cox <alan@redhat.com>
