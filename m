From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: add more toshiba laptops to
 broken suspend list
Date: Sat, 01 Dec 2007 17:46:12 -0500
Message-ID: <4751E434.1070902@garzik.org>
References: <474FAD8D.5050403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59234 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754661AbXLAWqP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 1 Dec 2007 17:46:15 -0500
In-Reply-To: <474FAD8D.5050403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, peter@bluetoad.com.au

Tejun Heo wrote:
> From: Peter Schwenke <peter@bluetoad.com.au>
> 
> Add more toshiba laptops to broken suspend list.  This is from OSDL
> bugzilla bug 7780.
> 
> tj: re-formatted patch and added description and SOB.
> 
> Signed-off-by: Peter Schwenke <peter@bluetoad.com.au>
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> This one is for #upstream-fixes && -stable.  I'll push it to Greg once
> it gets to Linus's tree.
> 
> Thanks.
> 
>  drivers/ata/ata_piix.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

applied #upstream-fixes


