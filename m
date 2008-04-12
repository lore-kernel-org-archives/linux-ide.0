From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream 1/2] libata: kill dead code paths in reset path
Date: Sat, 12 Apr 2008 00:35:16 -0400
Message-ID: <48003C04.4040508@garzik.org>
References: <47FA4AFF.2010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40271 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbYDLEfU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 12 Apr 2008 00:35:20 -0400
In-Reply-To: <47FA4AFF.2010209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Some code paths which had been made obsolete by recent reset
> simplification were still around.  Kill them.
> 
> * ata_eh_reset() checked for ATA_DEV_UNKNOWN to determine
>  classification failure.  This is no longer applicable.
> 
> * ata_do_reset() should convert ATA_DEV_UNKNOWN to ATA_DEV_NONE
>  regardless of reset result (e.g. -EAGAIN).
> 
> * LLDs don't need to convert ATA_DEV_UNKNOWN to ATA_DEV_NONE.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
> drivers/ata/libata-eh.c     |   19 +------------------
> drivers/ata/sata_inic162x.c |    2 --
> drivers/ata/sata_sil24.c    |    3 ---
> 3 files changed, 1 insertion(+), 23 deletions(-)

applied 1-2

Mark, let us know how we stand WRT sata_mv PMP needs, this should help.


