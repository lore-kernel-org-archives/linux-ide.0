From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: Allow SOFT_RESET for Sil3726
Date: Thu, 06 Oct 2011 14:42:46 +0400
Message-ID: <4E8D8626.6070000@mvista.com>
References: <CAMHSBOWbaLjbWZ7PNwTa-AsZRAzrOGLgSip=q2=u+qVQW4u3mQ@mail.gmail.com> <1317881037-11831-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754615Ab1JFKni (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Oct 2011 06:43:38 -0400
Received: by wwf22 with SMTP id 22so4036603wwf.1
        for <linux-ide@vger.kernel.org>; Thu, 06 Oct 2011 03:43:36 -0700 (PDT)
In-Reply-To: <1317881037-11831-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: mihrcke@gmail.com, linux-ide@vger.kernel.org

Hello.

On 06-10-2011 10:03, Gwendal Grignou wrote:

> Allow controllers to send SOFT_RESET to Sil3726 PMP.
> This PMP does not accept frames until the drive connected to
> its port spins up.
> Some controller [Sil3132 family] can not wait for the drive to spinup
> and fails the reset, leading to unnecessary speed downgrade.

> Not allowing to send SOFT_RESET can lead some drive slow to spinup
> to be ignored and produces weird error messages.

> This fix allows the error handler to wait if the controller is unable
> to send a SOFT_RESET.

> Change-Id: I7eeea152facb4b76e5c69cfde5ef8188874fbaba

    Please get rid of this line, it has no place in the upstream commit.

> Signed-off-by: Gwendal Grignou<gwendal@google.com>
> ---
>   drivers/ata/libata-eh.c  |   11 ++++++++++-
>   drivers/ata/libata-pmp.c |   10 ++++------
>   include/linux/libata.h   |    1 +
>   3 files changed, 15 insertions(+), 7 deletions(-)

> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 49af350..60223c3 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2805,7 +2805,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
>   	    sata_scr_read(link, SCR_STATUS,&sstatus))
>   		rc = -ERESTART;
>
> -	if (rc == -ERESTART || try>= max_tries)
> +	if (try>= max_tries)
> +		goto out;
> +
> +	/* Some PMP will not serve SRST until the disk is spunup,
> +	 * if the controller can not wait for the PMP to acknowledge the frame,
> +	 * wait here */

    The preferred multi-line comment style:

/*
  * bla
  * bla
  */

> +	if (rc == -ERESTART&&
> +	    !((lflags&  ATA_LFLAG_WAIT_SRST)&&  (reset == softreset)))
>   		goto out;
>
>   	now = jiffies;
[...]
> diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
> index ad0e71d..5fbbe2f 100644
> --- a/drivers/ata/libata-pmp.c
> +++ b/drivers/ata/libata-pmp.c
> @@ -365,13 +365,11 @@ static void sata_pmp_quirks(struct ata_port *ap)
>   	if (vendor == 0x1095&&  devid == 0x3726) {
>   		/* sil3726 quirks */
>   		ata_for_each_link(link, ap, EDGE) {
> -			/* Class code report is unreliable and SRST
> -			 * times out under certain configurations.
> -			 */
> +			/* Class code report is unreliable */
> +			/* PMP does not forward SRST until the drive spins up */
>   			if (link->pmp < 5)
> -				link->flags |= ATA_LFLAG_NO_SRST |
> -					       ATA_LFLAG_ASSUME_ATA;
> -

    Why remove the empty line?

> +				link->flags |= ATA_LFLAG_ASSUME_ATA |
> +					       ATA_LFLAG_WAIT_SRST;
>   			/* port 5 is for SEMB device and it doesn't like SRST */
>   			if (link->pmp == 5)
>   				link->flags |= ATA_LFLAG_NO_SRST |

WBR, Sergei
