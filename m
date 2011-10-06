From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Thu, 6 Oct 2011 01:03:14 -0700
Message-ID: <20111006080314.GB373@dhcp-172-17-108-109.mtv.corp.google.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com>
 <1317881037-11831-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35636 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374Ab1JFIDT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 04:03:19 -0400
Received: by gyg10 with SMTP id 10so2334803gyg.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 01:03:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317881037-11831-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mihrcke@gmail.com, linux-ide@vger.kernel.org

Hello, Gwendal.

Which tree is this patch against?

On Wed, Oct 05, 2011 at 11:03:57PM -0700, Gwendal Grignou wrote:
> Allow controllers to send SOFT_RESET to Sil3726 PMP.
> This PMP does not accept frames until the drive connected to
> its port spins up.

Do you mean until the device sets RDY by sending D2H Reg FIS?

> Some controller [Sil3132 family] can not wait for the drive to spinup
> and fails the reset, leading to unnecessary speed downgrade.
> Not allowing to send SOFT_RESET can lead some drive slow to spinup
> to be ignored and produces weird error messages.

Yeap, I agree this is nasty.

> @@ -2805,7 +2805,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  	    sata_scr_read(link, SCR_STATUS, &sstatus))
>  		rc = -ERESTART;
>  
> -	if (rc == -ERESTART || try >= max_tries)
> +	if (try >= max_tries)
> +		goto out;
> +
> +	/* Some PMP will not serve SRST until the disk is spunup,
> +	 * if the controller can not wait for the PMP to acknowledge the frame,
> +	 * wait here */
> +	if (rc == -ERESTART &&
> +	    !((lflags & ATA_LFLAG_WAIT_SRST) && (reset == softreset)))
>  		goto out;
>  
>  	now = jiffies;
> @@ -2820,6 +2827,8 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  			delta = schedule_timeout_uninterruptible(delta);
>  	}
>  
> +	if (rc == -ERESTART)
> +		goto out;

So, now libata waits for full reset period before proceeding to reset
PMP.  Hmmm... yeah, it makes sense.  Unfortunately, the only way to
achieve spinup wait in this case is waiting blindly and libata's reset
timeouts are configured to accomodate drive spinup times.  PMP SCR
failure kinda destroys those blind wait periods.

I'm not too sure about ATA_LFLAG_WAIT_SRST.  I don't think making the
new behavior default would hurt.

Can you please post before & after logs?

Thank you.

-- 
tejun
