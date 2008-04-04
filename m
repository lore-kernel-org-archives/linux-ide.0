From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 19/27] libata: unify mechanism to request follow-up SRST
Date: Fri, 04 Apr 2008 03:00:01 -0400
Message-ID: <47F5D1F1.8090101@garzik.org>
References: <1206451025926-git-send-email-htejun@gmail.com> <1206451028739-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37914 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752667AbYDDHAE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:00:04 -0400
In-Reply-To: <1206451028739-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com

Tejun Heo wrote:
> Previously, there were two ways to trigger follow-up SRST from
> hardreset method - returning -EAGAIN and leaving all device classes
> unmodified.  Drivers never used the latter mechanism and the only use
> case for the former was when hardreset couldn't classify.
> 
> Drop the latter mechanism and let -EAGAIN mean "perform follow-up SRST
> if classification is required".  This change removes unnecessary
> follow-up SRSTs and simplifies reset implementations.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c        |    3 ---
>  drivers/ata/libata-core.c |    1 -
>  drivers/ata/libata-eh.c   |   26 ++++++++------------------
>  drivers/ata/libata-sff.c  |    1 -
>  4 files changed, 8 insertions(+), 23 deletions(-)

related long term to-do item:  support hard and soft resets delivered 
via SG_IO according to the SAT standard


