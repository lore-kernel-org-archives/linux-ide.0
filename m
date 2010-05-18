From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/23] libata-sff: rename ap->ops->drain_fifo() to sff_drain_fifo()
Date: Mon, 17 May 2010 23:04:10 -0400
Message-ID: <4BF203AA.9090601@garzik.org>
References: <1273520507-32459-1-git-send-email-tj@kernel.org> <1273520507-32459-13-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63819 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab0ERDEO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 May 2010 23:04:14 -0400
Received: by gwaa20 with SMTP id a20so902475gwa.19
        for <linux-ide@vger.kernel.org>; Mon, 17 May 2010 20:04:13 -0700 (PDT)
In-Reply-To: <1273520507-32459-13-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, sshtylyov@mvista.com

On 05/10/2010 03:41 PM, Tejun Heo wrote:
> ->drain_fifo() is SFF specific.  Rename and relocate it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-sff.c  |    6 +++---
>   drivers/ata/pata_pcmcia.c |    2 +-
>   include/linux/libata.h    |    3 +--
>   3 files changed, 5 insertions(+), 6 deletions(-)

This patch failed to apply,

> Applying: libata-sff: rename ap->ops->drain_fifo() to sff_drain_fifo()
> error: patch failed: drivers/ata/libata-sff.c:65
> error: drivers/ata/libata-sff.c: patch does not apply
> error: patch failed: include/linux/libata.h:855
> error: include/linux/libata.h: patch does not apply
> Patch failed at 0002 libata-sff: rename ap->ops->drain_fifo() to sff_drain_fifo()

At this point, I am going to drop the rest of the patchset, and await a 
resend.  This is largely due to my wish to avoid a large deviation on 
sata_mv, which continues to be patched in further patches.

After we figure out the best patch for sata_mv, I request a 
rediff+resend of the sata_mv bits and patches 12-23.

Thanks,

	Jeff




