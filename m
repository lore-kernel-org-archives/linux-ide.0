From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/4] libata: make ata_tf_to_lba[48]() generic
Date: Fri, 04 Apr 2008 03:45:24 -0400
Message-ID: <47F5DC94.9040908@garzik.org>
References: <12066128663306-git-send-email-htejun@gmail.com> <12066128661215-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41317 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbYDDHp0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:45:26 -0400
In-Reply-To: <12066128661215-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca

Tejun Heo wrote:
> ata_tf_to_lba[48]() currently return LBA in tf + 1 for
> ata_read_native_max_address().  Make them return LBA and make it
> global so that it can be used to read LBA off TF for other purposes.
> ata_read_native_max_address() now adds 1 itself.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   12 ++++++------
>  drivers/ata/libata.h      |    2 ++
>  2 files changed, 8 insertions(+), 6 deletions(-)

applied 1-3 of 4


