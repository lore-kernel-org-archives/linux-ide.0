From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH 1/2] ATA: Add FSL sata v2 controller support
Date: Tue, 15 Mar 2011 10:39:46 -0500
Message-ID: <F1C7AE8B-477C-478D-953A-064FD13CF859@freescale.com>
References: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.184]:41923
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757839Ab1COPy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Mar 2011 11:54:58 -0400
In-Reply-To: <1295428050-21934-1-git-send-email-B33228@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xulei <B33228@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, jgarzik@pobox.com


On Jan 19, 2011, at 3:07 AM, Xulei wrote:

> In FSL sata v2 block, the snoop bit of PRDT Word3 description
> information is at bit28 instead of bit22.
> 
> This patch adds FSL sata v2 probe and resolve this difference.
> 
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Acked-by: Jeff Garzik <jgarzik@redhat.com>
> ---
> drivers/ata/sata_fsl.c |   25 ++++++++++++++++++-------
> 1 files changed, 18 insertions(+), 7 deletions(-)

applied

- k

