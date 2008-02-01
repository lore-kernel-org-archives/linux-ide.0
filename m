From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RESEND] libata: implement drain buffers
Date: Fri, 01 Feb 2008 15:02:37 -0500
Message-ID: <47A37ADD.6070408@garzik.org>
References: <1201895635.3134.62.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:44431 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755589AbYBAUCl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 1 Feb 2008 15:02:41 -0500
In-Reply-To: <1201895635.3134.62.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide <linux-ide@vger.kernel.org>

James Bottomley wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Thu, 10 Jan 2008 11:42:50 -0600
> Subject: libata: implement drain buffers
> 
> This just updates the libata slave configure routine to take advantage
> of the block layer drain buffers.
> 
> I suspect I should also be checking for AHCI as well as ATA_DEV_ATAPI,
> but I couldn't see how to do that easily.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/ata/libata-scsi.c |   26 ++++++++++++++++++++++----
>  1 files changed, 22 insertions(+), 4 deletions(-)

Tejun's persistent comment/objection with these works is that you need 
two sizes, for ATAPI, the raw size and the buffered size.

	Jeff




