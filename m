From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Fix pata_pdc2027x incorrect pio_mask and mwdma_mask
Date: Wed, 27 Oct 2004 10:49:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417FB590.6020008@pobox.com>
References: <00e801c4bc10$387e33b0$8c764109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45483 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262469AbUJ0OuE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 10:50:04 -0400
In-Reply-To: <00e801c4bc10$387e33b0$8c764109@tw.ibm.com>
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Jeff:
> 
>   Fix pata_pdc2027x incorrect pio_mask and mwdma_mask for your review.
> (patch is against the libata-dev-2.6 tree.)

patch applied.


> Signed-off-by: Albert Lee<albertcc@tw.ibm.com>

In addition to the last email (just sent), I have one further request:
please add a space between "Albert Lee" and "<albertcc@tw.ibm.com>"

Thanks,

	Jeff


