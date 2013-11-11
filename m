From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/6] libata: avoid waking disk to check power
Date: Mon, 11 Nov 2013 17:05:49 +0400
Message-ID: <5280D62D.6070909@cogentembedded.com>
References: <cover.1384030893.git.psusi@ubuntu.com> <04ad6fca8105259a952c5d7c9ec5c5c0c52e6266.1384030893.git.psusi@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <04ad6fca8105259a952c5d7c9ec5c5c0c52e6266.1384030893.git.psusi@ubuntu.com>
Sender: linux-scsi-owner@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>, todd.e.brandt@linux.intel.com
Cc: tj@kernel.org, JBottomley@parallels.com, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 10-11-2013 1:03, Phillip Susi wrote:

> When a disk is in SLEEP mode it can not respond to commands,
> including the CHECK POWER command.  Instead of waking up the
> sleeping disk, fake the reply to the CHECK POWER command to
> indicate the disk is in standby mode.  This prevents udisks
> from waking up sleeping disks when it polls to see if they
> are awake or not before trying to read their smart status.
> ---
>   drivers/ata/libata-core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 83b1a9f..686c441 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5084,6 +5084,14 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
>
>   	/* if device is sleeping, schedule reset and abort the link */
>   	if (unlikely(qc->dev->flags & ATA_DFLAG_SLEEPING)) {
> +		if (unlikely(qc->tf.command == ATA_CMD_CHK_POWER))
> +		{

    Keep { on the same line as *if* please.

WBR, Sergei

