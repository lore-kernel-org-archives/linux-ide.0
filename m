From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/2] sata_nv: don't use legacy DMA in ADMA mode
Date: Thu, 15 Nov 2007 10:43:35 +0900
Message-ID: <473BA447.6090909@gmail.com>
References: <473A7628.3010907@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:22624 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbXKOBno (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 20:43:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so349380rvb
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 17:43:43 -0800 (PST)
In-Reply-To: <473A7628.3010907@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

Hello,

Robert Hancock wrote:
> We need to run any DMA command with result taskfile requested in ADMA mode
> when the port is in ADMA mode, otherwise it may try to use the legacy DMA engine
> in ADMA mode which is not allowed. Enforce this with BUG_ON() since data
> corruption could potentially result if this happened.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
> 
> --- linux-2.6.24-rc1-git10/drivers/ata/sata_nv.c	2007-11-01 20:01:32.000000000 -0600
> +++ linux-2.6.24-rc1-git10edit/drivers/ata/sata_nv.c	2007-11-13 19:01:09.000000000 -0600
> @@ -791,11 +797,13 @@
>  
>  static void nv_adma_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
>  {
> -	/* Since commands where a result TF is requested are not
> -	   executed in ADMA mode, the only time this function will be called
> -	   in ADMA mode will be if a command fails. In this case we
> -	   don't care about going into register mode with ADMA commands
> -	   pending, as the commands will all shortly be aborted anyway. */
> +	/* Other than when internal or pass-through commands are executed,
> +	   the only time this function will be called in ADMA mode will be
> +	   if a command fails. In the failure case we don't care about going
> +	   into register mode with ADMA commands pending, as the commands will
> +	   all shortly be aborted anyway. We assume that NCQ commands are not
> +	   issued via passthrough and so this will not abort any commands in
> +	   that case. */
>  	nv_adma_register_mode(ap);

So, now if an ATA DMA command is issued w/ RESULT_TF set, it's issued
using ADMA.  Then when nv_adma_tf_read() is called on success path, it
switches into register mode and read TF which is okay as long as there's
no other ADMA commands in flight and that's why you wrote about not
issuing NCQ commands via NCQ.  Am I understanding it correctly?

If so, can you please add that switching into register mode is okay as
long as there's no other ADMA commands in flight and add
WARN_ON((qc->flags & ATA_QCFLAG_RESULT_TF) && link->sactive)?

Thanks.

-- 
tejun
