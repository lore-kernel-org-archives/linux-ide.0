From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] IDE: compile fix for sff_dma_ops
Date: Fri, 22 Aug 2008 03:28:39 +0400
Message-ID: <48ADFA27.2070002@ru.mvista.com>
References: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com> <87bpzm7yoi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5795 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751831AbYHUX2p (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Aug 2008 19:28:45 -0400
In-Reply-To: <87bpzm7yoi.fsf@deeprootsystems.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-ide@vger.kernel.org

Hello.

Kevin Hilman wrote:

>> The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
>> of BLK_DEV_IDEDMA_PCI.
> Oops, I sent the wrong version of this patch.  Here's a better version
> which moves sff_dma_ops into an existing #ifdef block.
>
> Kevin
>
> From d9c182b5109591b9a28384991bcd820554fad371 Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@deeprootsystems.com>
> Date: Thu, 21 Aug 2008 10:31:44 -0700
> Subject: [PATCH] IDE: compile fix for sff_dma_ops
>
> The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
> of BLK_DEV_IDEDMA_PCI.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
[...]
> diff --git a/include/linux/ide.h b/include/linux/ide.h
> index eb1721c..cf95ca7 100644
> --- a/include/linux/ide.h
> +++ b/include/linux/ide.h
>   
[...]
> @@ -1276,6 +1275,7 @@ int ide_dma_test_irq(ide_drive_t *);
>  extern void ide_dma_lost_irq(ide_drive_t *);
>  extern void ide_dma_timeout(ide_drive_t *);
>  extern const struct ide_dma_ops sff_dma_ops;
> +extern const struct ide_dma_ops sff_dma_ops;
>  #endif /* CONFIG_BLK_DEV_IDEDMA_SFF */

   Somethiung went wrong again.  Do you see what? :-)

MBR, Sergei


