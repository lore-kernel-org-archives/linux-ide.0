From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH #upstream-fixes] libata: fix NULL sdev dereference race
 in atapi_qc_complete()
Date: Tue, 02 Nov 2010 17:31:22 -0400
Message-ID: <4CD0832A.3070503@teksavvy.com>
References: <4CCE98D7.1030906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:17678 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753163Ab0KBVb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Nov 2010 17:31:27 -0400
In-Reply-To: <4CCE98D7.1030906@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, stable <stable@kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>

On 10-11-01 06:39 AM, Tejun Heo wrote:
> SCSI commands may be issued between __scsi_add_device() and dev->sdev
> assignment, so it's unsafe for ata_qc_complete() to dereference
> dev->sdev->locked without checking whether it's NULL or not.  Fix it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: stable@kernel.org
> ---
> I actually hit this race condition.  Lucky me.  :-)
>
> Thanks.
>
>   drivers/ata/libata-scsi.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> Index: work/drivers/ata/libata-scsi.c
> ===================================================================
> --- work.orig/drivers/ata/libata-scsi.c
> +++ work/drivers/ata/libata-scsi.c
> @@ -2552,8 +2552,11 @@ static void atapi_qc_complete(struct ata
>   		 *
>   		 * If door lock fails, always clear sdev->locked to
>   		 * avoid this infinite loop.
> +		 *
> +		 * This may happen before SCSI scan is complete.  Make
> +		 * sure qc->dev->sdev isn't NULL before dereferencing.
>   		 */
> -		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL)
> +		if (qc->cdb[0] == ALLOW_MEDIUM_REMOVAL&&  qc->dev->sdev)
>   			qc->dev->sdev->locked = 0;
>
>   		qc->scsicmd->result = SAM_STAT_CHECK_CONDITION;


Mmmm.. for some reason, this just screams "band-aid" to me,
and makes me worry deeply about the underlaying race condition
it all suggests..

James?
