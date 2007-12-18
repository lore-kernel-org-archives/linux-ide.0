From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: update atapi_eh_request_sense()
 such that lbam/lbah contains buffer size
Date: Mon, 17 Dec 2007 20:37:57 -0500
Message-ID: <47672475.2010400@garzik.org>
References: <475F51AE.1010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:60153 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757785AbXLRBiB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Dec 2007 20:38:01 -0500
In-Reply-To: <475F51AE.1010305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, will@trivescon.com.au, yannick.dirou@axetic.com, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> While updating lbam/h for ATAPI commands, atapi_eh_request_sense() was
> left out.  Update it.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This patch is from improve-ATAPI-data-xfer patchset pending for
> #upstream.
> 
>  drivers/ata/libata-eh.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied #upstream-fixes


