From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: replace ap->cbl tests with ATA_FLAG_SATA tests
Date: Thu, 24 May 2007 23:05:56 -0400
Message-ID: <46565294.50905@garzik.org>
References: <4651C9EB.2040707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50673 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbXEYDF6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 23:05:58 -0400
In-Reply-To: <4651C9EB.2040707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> ap->cbl == ATA_CBL_SATA indicates SATA cable while ap->flags &
> ATA_FLAG_SATA indicates SATA host port.  Till now they always gave the
> same result but SATA/PATA bridge handling will change that.  Switch to
> ATA_FLAG_SATA test if we're testing for host port type.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  libata-core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

applied


