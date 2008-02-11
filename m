From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] libata: ignore deverr on SETXFER if mode
 is configured
Date: Mon, 11 Feb 2008 14:30:26 -0500
Message-ID: <47B0A252.4010706@garzik.org>
References: <47AA6010.30003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55250 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760282AbYBKTa2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Feb 2008 14:30:28 -0500
In-Reply-To: <47AA6010.30003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Tejun Heo wrote:
> Some controllers (VIA CX700) raise device error on SETXFER even after
> mode configuration succeeded.  Update ata_dev_set_mode() such that
> device error is ignored if transfer mode is configured correctly.  To
> implement this, device is revalidated even after device error on
> SETXFER.
> 
> This fixes kernel bugzilla bug 8563.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/ata/libata-core.c |   48 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)

applied


