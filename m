From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Two fixes regarding memory allocation
Date: Sun, 31 Aug 2008 18:05:56 +0200
Message-ID: <200808311805.57395.bzolnier@gmail.com>
References: <20080829213217.4826.43132.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:35132 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbYHaQLK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 Aug 2008 12:11:10 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1603245muf.1
        for <linux-ide@vger.kernel.org>; Sun, 31 Aug 2008 09:11:08 -0700 (PDT)
In-Reply-To: <20080829213217.4826.43132.stgit@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 29 August 2008, Elias Oltmanns wrote:
> In function ide_devset_execute() we should use __GFP_WAIT rather than
> GFP_KERNEL. Also, the allocation cannot possibly fail at that point.
> More importantly, there is a potential memory leak in the device probing
> code. The infrastructure seems rather complex and I hope I haven't messed
> anything up by trying to fix this.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

thanks, applied

> @@ -972,12 +972,21 @@ static void ide_port_setup_devices(ide_hwif_t *hwif)
>  		if (ide_init_queue(drive)) {
>  			printk(KERN_ERR "ide: failed to init %s\n",
>  					drive->name);
> +			spin_lock_irq(&ide_lock);
> +			kfree(drive->id);
> +			drive->id = NULL;
> +			drive->dev_flags &= ~IDE_DFLAG_PRESENT;
> +			spin_unlock_irq(&ide_lock);
>  			continue;

ide_lock taking is superfluous here, I removed it while merging the patch
